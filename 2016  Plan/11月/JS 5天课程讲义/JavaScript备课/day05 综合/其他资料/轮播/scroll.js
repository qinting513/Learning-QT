window.onload = function(){ 
 //获取装图片的盒子 
 var box = document.getElementById('box'); 
 //获取装页码的盒子 
 var pointer = document.getElementById('pointer'); 
 //获取盒子中的所有图片 
 var imglist = box.getElementsByTagName('img') 
 //获取盒子中的所有页码 
 var pointerList = pointer.getElementsByTagName('span'); 
 //图片的宽度,正负用于左右的循环 
 var n = -600; 
 //增加一倍的图片用于循环 
 box.innerHTML = box.innerHTML+box.innerHTML; 
 //设置盒子的宽 
 box.style.width = imglist[0].offsetWidth*imglist.length+"px"; 
 var timer = null; 
 timer = setInterval(function(){ 
  scroll(box,n,pointerList); 
 },2000); 
 box.onmouseover = function(){ 
  clearInterval(timer); 
 } 
 pointer.onmouseover = function(){ 
  clearInterval(timer); 
 } 
 box.onmouseout = function(){ 
  timer = setInterval(function (){ 
   scroll(box,n,pointerList); 
  },2000); 
 } 
 //设置页码的点击事件 
 for(var i=0;i<pointerList.length;i++){ 
  pointerList[i].index=i;//设置一个参数，用下面调用某个页码 
  //如果不设置参数，在调用页码的时候会直接调用最后一个，因为我们使用了循环 
  pointerList[i].onclick=function (){ 
   for(var j=0;j<pointerList.length;j++){ 
    pointerList[j].className='';//清空激活的class 
   } 
   move(box,n*(this.index));//移动图片 
   this.className='active';//激活点击的页码 
  } 
 } 
   
} 
/** 
 * 循环滚动函数 
 * @param {Object} box 
 * @param {Object} n 
 */
function scroll(box,n,page){ 
 //判断是否到达临界点，即box的中间部分 
 if(box.offsetLeft<=-box.offsetWidth/2){ 
  box.style.left = "0px";//重新从头开始 
  console.log('0'); 
 } 
 if(box.offsetLeft%n!=0){ 
  //因为在我们切换浏览器标签页或者切换去其他软件界面的时候， 
  //会影响到setInterval,有时候setInterval会增加好几秒，在这里我们必须加一个判断 
  //只有当它走完了一个整个的图片宽度时，我们才进行下一次滚动。 
 } 
 else{ 
  pageScroll(box,n,page); 
  move(box,n+box.offsetLeft); 
 } 
} 
/** 
 * 滚动页码函数 
 * @param {Object} box 
 * @param {Object} n 
 * @param {Object} page 
 */
function pageScroll(box,n,page){ 
 //直接通过图片盒子的定位判断页码值，但是此时的页码值是滚动之前的，所以后面的值要+1使用 
 var index = Math.abs(box.offsetLeft/n); 
 console.log(index); 
 for(var i=0;i<page.length;i++){ 
  page[i].className=''; 
 } 
 //判断是不是最后一页，是最后一页的话+1要变成0； 
 if(index<page.length-1){ 
  page[index+1].className='active'; 
 } 
 else{ 
  page[0].className='active'; 
 } 
} 
  
/** 
 * 变速移动 
 * @param {Object} ele 
 * @param {Object} target 
 */
function move(ele,target){ 
 clearInterval(ele.timer); 
 console.log(new Date()); 
 ele.timer = setInterval(function () { 
  var step = (target-ele.offsetLeft)/10; 
  step = step>0?Math.ceil(step):Math.floor(step); 
  if(target==ele.offsetLeft){ 
   console.log(new Date()); 
   clearInterval(ele.timer); 
  } 
  else{ 
   ele.style.left = ele.offsetLeft + step + "px"; 
  } 
 },30); 
}
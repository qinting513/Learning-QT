
var index=0;
//innerHTML 属性 用于设置或返回id类型为w的的开始和结束标签之间的内容
var word=document.getElementById("w").innerHTML;

function type()
{
	// console.log( word.substring(0,index++) );
    document.getElementById("aa").innerHTML = word.substring(0,index++);
}

setInterval(type, 1000);



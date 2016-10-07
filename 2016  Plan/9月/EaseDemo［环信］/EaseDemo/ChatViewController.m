//
//  ChatViewController.m
//  EaseDemo
//
//  Created by Qinting on 16/9/1.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ChatViewController.h"
#import <YYTextView.h>
#import "EasemobManager.h"
#import "YYTool.h"
#import "UIView+Extension.h"
#import "RecordButton.h"
#import "amrFileCodec.h"
#import <UIImageView+WebCache.h>
#import <EMConversation.h>

#define kImageWH 80
#define kScreenW [UIScreen mainScreen].bounds.size.width

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,YYTextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet YYTextView *msgTextView;
@property (nonatomic,strong) NSMutableArray  *allMessages;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrant;

/** 展示表情图片的scrollView */
@property (nonatomic,strong) UIScrollView  *faceSV;
/** 保存表情图片的数组 */
@property (nonatomic,strong)   NSArray *faceArr ;

/** 当进到系统，选择系统图片时用来展示图片的 */
@property (nonatomic,strong) UIScrollView  *pickerSv;
/** 保存选择的系统图片，存UIImageView对象 */
@property (nonatomic,strong) NSMutableArray  *selectedImageViews;
//增加图片按钮
@property (nonatomic, strong)UIButton *addImageButton;
// 发送页面的scrollView
@property (nonatomic, strong)UIScrollView *selectedImageSV;
/** 录音 */
@property (nonatomic,strong) UIView  *recordView;
@property (nonatomic,strong) UILabel  *timeLabel;
@property (nonatomic,strong) RecordButton   *recordBtn;
@property (nonatomic, strong)NSData *voiceData;
@property (nonatomic,assign)  NSTimeInterval duration;
@property (nonatomic, strong)AVAudioPlayer *player;

@end

@implementation ChatViewController

#pragma  mark - 发送按钮
- (IBAction)sendMsg:(id)sender {
    if(self.msgTextView.text.length >  0)  {
     EMMessage *message =  [[EasemobManager sharedManager] sendMessageWithText:self.msgTextView.text andUsername:self.toUser];
    [self.allMessages addObject:message];
    [self.tableView reloadData];
    self.msgTextView.text = @"";
    }
    if(self.selectedImageViews.count > 0){
        for (UIImageView *iv in self.selectedImageViews) {
          EMMessage *message =  [[EasemobManager sharedManager] sendImageWithImage:iv.image andUserName:self.toUser];
            [self.allMessages addObject:message];
            [self.tableView reloadData];
        }
        [self.selectedImageViews removeAllObjects];
        [self.selectedImageSV removeAllSubviews];
        [self.selectedImageSV addSubview:self.addImageButton];
     [UIView animateWithDuration:0.5 animations:^{
          self.addImageButton.center  = CGPointMake(20 + self.selectedImageViews.count * 120+ self.addImageButton.bounds.size.width / 2, self.addImageButton.center.y);
     }];
    }
    
    if(self.voiceData){
        EMMessage *message = [[EasemobManager sharedManager] sendVoiceWithVoiceData:self.voiceData duration:self.duration andUserName:self.toUser];
        [self.allMessages addObject:message];
        [self.tableView reloadData];
        self.voiceData = nil;
        self.timeLabel.text = @"";
    }
    [self scrollTableView];
}

- (IBAction)bottomBtnsClick:(UIButton*)sender {
    switch (sender.tag) {
        case 0://相册
        {
            self.msgTextView.inputView = [self.msgTextView.inputView isEqual:self.selectedImageSV]?nil:self.selectedImageSV;
            [self.msgTextView reloadInputViews];
            //如果一张都没选择过 则直接跳转到选择图片页面
            if (self.selectedImageViews.count==0) {
                UIImagePickerController *pick=[UIImagePickerController new];
                pick.delegate=self;
                [self presentViewController:pick animated:YES completion:nil];
            }
            break;
        }
        case 1: //文件
            
            break;
        case 2: //声音
        {
            [self.msgTextView becomeFirstResponder];
            self.msgTextView.inputView = [  self.msgTextView.inputView isEqual:self.recordView] ? nil : self.recordView;
            [self.msgTextView reloadInputViews];
            break;
        }
        case 3://视频
            
            break;
        case 4://红包
            
            break;
        case 5://emoji
        {
            [self.msgTextView becomeFirstResponder];
            /** 如果有值，则为空，没有值则设置值 */
            self.msgTextView.inputView = [self.msgTextView.inputView isEqual:self.faceSV]?nil:self.faceSV;
            [self.msgTextView reloadInputViews];
            
            break;
        }
        default:
            break;
    }
}
#pragma mark - 视图的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = self.toUser;
    self.msgTextView.font = [UIFont systemFontOfSize:20];
    self.msgTextView.delegate = self;
    
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.toUser conversationType:eConversationTypeChat];
    self.allMessages = [[conversation loadAllMessages] mutableCopy];
    [self scrollTableView];
}

#pragma  mark - 键盘弹起和收回
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMessageAction:) name:@"ReceiveMessageNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recordFinishAction:) name:@"RecordDidFinishNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(offlineMessagesAction:) name:@"ReceiveOfflineMessagesNotification" object:nil];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scrollTableView) name:UIKeyboardDidShowNotification object:nil];
    if (self.selectedImageViews.count>0) {
        [self.msgTextView becomeFirstResponder];
    }
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (notification.name == UIKeyboardWillShowNotification) {
        self.bottomConstrant.constant = keyboardEndFrame.size.height;
    }else{
        self.bottomConstrant.constant = 0;
    }
    [self.view layoutIfNeeded];
    [UIView commitAnimations];
}
/**  滚动tableview */
-(void)scrollTableView{
    if ( self.allMessages.count == 0 ) return;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.allMessages.count-1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
/** 开始滚动时收键盘 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.msgTextView resignFirstResponder];
}

#pragma mark - 接收到消息
-(void)newMessageAction:(NSNotification *)noti{
    EMMessage *message  = noti.object;
//    要判断是同一个人才接收
    if([message.from isEqualToString:self.toUser]){
        [self.allMessages addObject:message];
        [self.tableView reloadData];
    }
  [self scrollTableView];
}

-(void)offlineMessagesAction:(NSNotification*)noti{

}

#pragma mark - 懒加载
- (NSMutableArray *)allMessages {
    if(_allMessages == nil) {
        _allMessages = [[NSMutableArray alloc] init];
    }
    return _allMessages;
}
//选择图片的数组
- (NSMutableArray *)selectedImageViews {
    if(_selectedImageViews == nil) {
        _selectedImageViews = [[NSMutableArray alloc] init];
    }
    return _selectedImageViews;
}

- (UIScrollView *)selectedImageSV {
    if(_selectedImageSV == nil) {
        _selectedImageSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 216)];
        self.addImageButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 100, 140)];
        [self.addImageButton setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
        [self.selectedImageSV addSubview:self.addImageButton];
        
        [self.addImageButton addTarget:self action:@selector(addImageAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedImageSV;
}
-(void)addImageAction{
    if(self.selectedImageViews.count < 9){
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}


#pragma  mark - 表情相关
- (UIScrollView *)faceSV {
    if(_faceSV == nil) {
        _faceSV = [[UIScrollView alloc] init];
        //设置表情和文本的匹配
        [YYTool faceMappingWithTextView:self.msgTextView];
        _faceSV.frame = CGRectMake(0, 0, self.view.bounds.size.width, 216);
        _faceSV.showsHorizontalScrollIndicator = NO;
        /** 添加表情 */
        NSString *path = [[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"];
        self.faceArr = [NSArray arrayWithContentsOfFile:path];
        //页数  每页 4行 8列
        NSInteger page = self.faceArr.count %32 == 0  ? self.faceArr.count / 32 : self.faceArr.count /32 + 1;
        [_faceSV setContentSize:CGSizeMake(page*self.view.bounds.size.width, 0)];
        _faceSV.pagingEnabled = YES;
        
        CGFloat widthH = self.view.bounds.size.width / 8;
        
        for(int i = 0; i< page; i++){
            NSInteger count = 32;
            if(i == page - 1)  count = self.faceArr.count % 32;
            //            j 是第几个
            for(int j = 0 ; j < count ;j++){
                UIButton *faceBtn = [[UIButton alloc]initWithFrame:CGRectMake(j%8*widthH + i *self.view.frame.size.width, j/8 * widthH, widthH, widthH)];
                [_faceSV addSubview:faceBtn];
                
                faceBtn.tag = j + 32 * i;
                //                 i 是0 的时候，取出第一页的，i是1的时候取出第二页的emoji
                NSDictionary *faceDic = self.faceArr[j + 32 * i];
                NSString *imageName = faceDic[@"png"];
                [faceBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
                [faceBtn addTarget:self action:@selector(faceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
    }
    return _faceSV;
}

-(void)faceBtnClick:(UIButton *)btn{
    NSDictionary *faceDic = self.faceArr[btn.tag];
    NSString *text = faceDic[@"chs"];
    [self.msgTextView insertText:text];
}

-(void)textViewDidBeginEditing:(YYTextView *)textView{
    self.msgTextView = textView;
}

#pragma mark - 选择图片
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //判断出第二个页面时才添加
    if (navigationController.viewControllers.count == 2 ) {
        //得到页面中view的高度 把高度 -100 使得能选择最后一张图
        UIView *cv = [viewController.view.subviews firstObject];
        CGRect frame = cv.frame;
        frame.size.height  -= 100;
        cv.frame = frame;
        
        //       底部承载选择了图片的scrollView
        UIView *v  = [[UIView alloc]initWithFrame:CGRectMake(0 , [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, kImageWH)];
        v.backgroundColor = [UIColor redColor];
        [viewController.view addSubview:v];
        
        UIScrollView *pickerSv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, kImageWH)];
        pickerSv.backgroundColor = [UIColor greenColor];
        [v addSubview:pickerSv];
        self.pickerSv = pickerSv;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.frame = CGRectMake(v.frame.size.width - 80 , 0, 80, 20);
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [v addSubview:btn];
        [btn addTarget:self action:@selector(selectComplete) forControlEvents:UIControlEventTouchUpInside];
    }
    //再次点击加号 选择图片的时候，把之前选择的图片添加进去
    for(int i = 0;i < self.selectedImageViews.count; i ++){
        UIImageView *iv = self.selectedImageViews[i];
        iv.frame = CGRectMake(i*80, 0, kImageWH, kImageWH);
        [self.pickerSv addSubview:iv];
    }
//    [self.selectedImageSV removeAllSubviews];
    
}

/** 选择多张图片 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageView *iv =  [[UIImageView alloc]initWithFrame:CGRectMake(self.selectedImageViews.count*80, 0, kImageWH, kImageWH)];
    iv.image = image;
    iv.userInteractionEnabled = YES;
    [self.pickerSv addSubview:iv];
    [self.selectedImageViews addObject:iv];
    self.pickerSv.contentSize = CGSizeMake(self.selectedImageViews.count*80, 0);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, 0, 20, 20);
    [btn setTitle:@"X" forState:UIControlStateNormal];
    [iv addSubview:btn];
    [btn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    if(self.selectedImageViews.count == 9){
        [self selectComplete];
    }
}

/** 完成按钮  */
-(void)selectComplete{
    //遍历选择到的图片，把选择的图片添加到发送页面的sv
    for(int i = 0; i<self.selectedImageViews.count; i++){
        UIImageView *iv = self.selectedImageViews[i];
        //        形状变大了
        iv.frame = CGRectMake(20 + 120*i, 30, 100, 140);
        [self.selectedImageSV addSubview:iv];
    }
    self.selectedImageSV.contentSize = CGSizeMake((self.selectedImageViews.count + 1) * 120, 0);
    self.addImageButton.center  = CGPointMake(20 + self.selectedImageViews.count * 120+ self.addImageButton.bounds.size.width / 2, self.addImageButton.center.y);
    [self.pickerSv removeAllSubviews];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self updateImageCountLabel];
}

-(void)updateImageCountLabel{
    //    self.imageCountLabel.hidden =  self.selectedImageViews.count == 0 ? YES : NO;
    //    self.imageCountLabel.text = @(self.selectedImageViews.count).stringValue;
}

///** 图片右上角删除按钮 */
-(void)deleteImage:(UIButton *)btn{
//    从数组删除
          [self.selectedImageViews removeObject:btn.superview];
    /** 重新布局 */
    for(int i = 0; i< self.selectedImageViews.count; i++){
        UIImageView *imageView = self.selectedImageViews[i];

        if(btn.superview.superview == self.selectedImageSV){
            self.selectedImageSV.contentSize = CGSizeMake(140 + 120*self.selectedImageViews.count, 140);
            [UIView animateWithDuration:0.5 animations:^{
                imageView.frame  = CGRectMake(20 + 120*i, 30, 100, 140);
                   self.addImageButton.center  = CGPointMake(20 + self.selectedImageViews.count * 120+ self.addImageButton.bounds.size.width / 2, self.addImageButton.center.y);
            }];
        }else{
            self.pickerSv.contentSize = CGSizeMake(80+ 80*self.selectedImageViews.count, kImageWH);
            [UIView animateWithDuration:0.5 animations:^{
                imageView.frame  = CGRectMake(i*80, 0, kImageWH, kImageWH);
            }];
        }
        
    }
        [btn.superview removeFromSuperview];
 
}


#pragma mark - 录音相关的
- (UIView *)recordView {
    if(_recordView == nil) {
        _recordView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 216)];
        RecordButton *recordBtn = [[RecordButton  alloc]initWithFrame:CGRectMake(0, 0, kScreenW, _recordView.frame.size.height - 40)];
        recordBtn.center =  CGPointMake(self.recordView.center.x, self.recordView.center.y-10);
        [recordBtn setImage:[UIImage imageNamed:@"mic_normal_358x358"] forState:UIControlStateNormal];
        [_recordView addSubview: recordBtn];
        self.recordBtn = recordBtn;
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _recordView.frame.size.height - 40, kScreenW, 40)];
//         self.timeLabel.backgroundColor = [UIColor blueColor];
        self.timeLabel.textColor = [UIColor redColor];
        [_recordView addSubview:  self.timeLabel];
         self.timeLabel.textAlignment  = NSTextAlignmentCenter;
    }
    return _recordView;
}

- (void)recordFinishAction:(NSNotification *)notfi {
    
    float time = [notfi.object[@"time"]floatValue];
    self.duration = time;
    NSData *voiceData = notfi.object[@"data"];
    NSLog(@"时长：%f   文件长度:%ld",time,voiceData.length);
    self.timeLabel.text = [NSString stringWithFormat:@"录音时长：%.2f秒",time];
    self.voiceData = voiceData;
//    [[EasemobManager sharedManager]sendVoiceWithVoiceData:voiceData duration:time andUserName:self.toUser];
}

//播放录音
-(void)playAction{
  
}

#pragma mark - tableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    EMMessage *msg = self.allMessages[indexPath.row];

    //得到消息的具体内容
    id<IEMMessageBody> msgBody = msg.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            cell.textLabel.text = txt;
            if([msg.to isEqualToString:self.toUser]){ //我发的内容  to的对象刚好是他
                cell.detailTextLabel.text = @"我说：";
            }else{
                cell.detailTextLabel.text = @"他说：";
            }
                break;
        }
        case eMessageBodyType_Image:
        {
  
            if([msg.to isEqualToString:self.toUser]){ // 自己发的
                cell.textLabel.text = @"我发的图片";
        
            }else{
                cell.textLabel.text = @"ta发的图片";
            }
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在（音频会自动调用）
            NSLog(@"音频的secret -- %@"        ,body.secretKey);
            NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"音频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
            if([msg.to isEqualToString:self.toUser]){ // 自己发的
                cell.textLabel.text = @"我发的语音";
                
            }else{
                cell.textLabel.text = @"ta发的语音";
            }
        }
            break;
            
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EMMessage *message = self.allMessages[indexPath.row];
    
    //得到消息的具体内容
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    switch ((int)msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            
        }
            break;
        case eMessageBodyType_Image:
        {
            
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
            NSLog(@"大图local路径 -- %@"    ,body.localPath);
            
            UIViewController *vc = [UIViewController new];
            UIImageView *iv = [[UIImageView alloc]initWithFrame:vc.view.bounds];
            
            [vc.view addSubview:iv];
            
            if ([message.to isEqualToString:self.toUser]) {//自己发
                iv.image = [UIImage imageWithContentsOfFile:body.localPath];
                
                
            }else{//接收到
                [iv sd_setImageWithURL:[NSURL URLWithString:body.remotePath]];
            }
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case eMessageBodyType_Voice:
        {
                 EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            if([message.to isEqualToString:self.toUser]){ // 自己发的
                NSData *data = [NSData dataWithContentsOfFile:body.localPath];
                data = DecodeAMRToWAVE(data);
                self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
                [self.player play];
            }else{
               
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:body.remotePath]];
                    
                    data = DecodeAMRToWAVE(data);
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.player = [[AVAudioPlayer alloc]initWithData:data error:nil];
                        [self.player play];
                        
                    });
                });
            }
        }
            break;
           
    }
    
}




@end

//
//  ViewController.m
//  MobShareDemo
//
//  Created by Qinting on 16/9/13.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)share:(id)sender {
//         [self  showShareActionSheet];
//        [self  showShareEditor];
//        [self sinaShare];
            [self test];
}


//显示分享菜单
-(void)showShareActionSheet{
    //1、创建分享参数
            NSArray* imageArray = @[[UIImage imageNamed:@"share2"],[UIImage imageNamed:@"share3"],[UIImage imageNamed:@"share1"] ];
    /** 网络图片  http://wiki.mob.com/ios9-%E5%AF%B9sharesdk%E7%9A%84%E5%BD%B1%E5%93%8D%EF%BC%88%E9%80%82%E9%85%8Dios-9%E5%BF%85%E8%AF%BB%EF%BC%89/ */
//    NSArray* imageArray = @[@"http://ww3.sinaimg.cn/mw690/48f122e6jw1f7bsek9krdj211i1e07wi.jpg"];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"你今天好吗？"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"www.baidu.com"]   //别人点击你分享的东西，跳转到的界面
                                          title:@"你好"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];
    }
    
}

// 显示内容编辑视图
-(void)showShareEditor{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"share2"],[UIImage imageNamed:@"share3"],[UIImage imageNamed:@"share1"] ];
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupSinaWeiboShareParamsByText:@"幕客内有视频可以看哦"
                                               title:@"幕客网"
                                               image:imageArray
                                                 url:[NSURL URLWithString:@"http://www.imooc.com/course/list"]
                                            latitude:122.0
                                           longitude:39.0
                                            objectID:@"iOS菜鸟"
                                                type:SSDKContentTypeAuto];
    // 2 。发送分享    showShareEditor：显示分享时编辑界面下的平台，点击分享后会跳转到那个应用
    /**
     *  显示内容编辑视图
     *
     *  @param platformType             分享的平台类型
     *  @param otherPlatformTypes       除分享平台外，还可以分享的平台类型。
     *  @param shareParams              分享内容参数
     *  @param shareStateChangedHandler 分享状态变更事件
     *
     *  @return 内容编辑视图控制器
     */
    [ShareSDK showShareEditor:  SSDKPlatformSubTypeQQFriend
           otherPlatformTypes:@[]
                  shareParams:shareParams
          onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType,
                                NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
              NSLog(@"分享的内容: %@",contentEntity);
              switch (state) {
                  case SSDKResponseStateSuccess:
                  {
                      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                          message:nil
                                                                         delegate:nil
                                                                cancelButtonTitle:@"确定"
                                                                otherButtonTitles:nil];
                      [alertView show];
                      break;
                  }
                  case SSDKResponseStateFail:
                  {
                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                      message:[NSString stringWithFormat:@"%@",error]
                                                                     delegate:nil
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil, nil];
                      [alert show];
                      break;
                  }
                  default:
                      break;
              }
          }];
}

// sina share   直接分享 没有界面
-(void)sinaShare{
    //1、创建分享参数
    //            NSArray* imageArray = @[[UIImage imageNamed:@"share2"],[UIImage imageNamed:@"share3"],[UIImage imageNamed:@"share1"] ];
    /** 网络图片  http://wiki.mob.com/ios9-%E5%AF%B9sharesdk%E7%9A%84%E5%BD%B1%E5%93%8D%EF%BC%88%E9%80%82%E9%85%8Dios-9%E5%BF%85%E8%AF%BB%EF%BC%89/ */
    NSString *imageUrl = @"http://ww3.sinaimg.cn/mw690/48f122e6jw1f7bsek9krdj211i1e07wi.jpg";
//    NSArray* imageArray = @[imageUrl];  //如果是网络图片的地址，直接装到数组里是出错的，需要以下转换
    
    NSData * image_data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage * sina_image = [[UIImage alloc]initWithData:image_data];
    
    if (sina_image) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"你今天好吗？"
                                         images:sina_image
                                            url:[NSURL URLWithString:@"www.baidu.com"]   //别人点击你分享的东西，跳转到的界面
                                          title:@"你好"
                                           type:SSDKContentTypeAuto];
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }
                         break;
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         NSLog(@"错误%@",error);
                         
                     }
                         break;
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         
                     }
                         break;
                     default:
                         break;
                 }
                 
             }];
    }
    
    
}

// 设置各个平台的分享样式
-(void)test{
    NSString *title = @"林心如";
//    NSString *linkUrl = @"http://ww3.sinaimg.cn/mw690/48f122e6jw1f7bsek9krdj211i1e07wi.jpg";
    NSString *linkUrl = @"http://www.youku.com";
    NSString *imageUrl = @"http://ww3.sinaimg.cn/mw690/48f122e6jw1f7bsek9krdj211i1e07wi.jpg";
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * sina_text = [NSString stringWithFormat:@"%@%@",title,linkUrl];
    NSData * image_data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage * sina_image = [[UIImage alloc]initWithData:image_data];
    
//    设置新浪微博分享参数
    [shareParams SSDKSetupSinaWeiboShareParamsByText:sina_text title:@"sina ShareSDK" image:sina_image url:nil latitude:0.0 longitude:0.0 objectID:nil type:SSDKContentTypeAuto];
    
//    设置QQ分享参数
    [shareParams SSDKSetupQQParamsByText:@"QQ好友平台的测试" title:title url:[NSURL URLWithString:linkUrl] thumbImage:imageUrl image:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeQQFriend];
    
    [shareParams  SSDKSetupWeChatParamsByText:@"iOS" title:title  url:[NSURL URLWithString:linkUrl] thumbImage:[UIImage imageNamed:@"share"] image:[UIImage imageNamed:@"share3"] musicFileURL:nil extInfo:@"extInfo" fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
        [shareParams  SSDKSetupWeChatParamsByText:@"微信朋友圈" title:title  url:[NSURL URLWithString:linkUrl] thumbImage:[UIImage imageNamed:@"shar1"] image:[UIImage imageNamed:@"share2"] musicFileURL:nil extInfo:@"extInfo" fileData:nil emoticonData:nil type:SSDKContentTypeAuto forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
    
    //  设置分享参数
//    [shareParams SSDKSetupShareParamsByText:@""
//                                     images:imageUrl
//                                        url:[NSURL URLWithString:linkUrl]
//                                      title:title
//                                       type:SSDKContentTypeAuto];
    
    SSUIShareActionSheetController *sheet =  [ShareSDK showShareActionSheet:self.view items:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeQZone),@(SSDKPlatformSubTypeQQFriend),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeWechatTimeline)] shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
                
            }
                break;
            case SSDKResponseStateFail:
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];
            }
                break;
            case SSDKResponseStateCancel:
            {
                
            }
                break;
            default:
                break;
        }
        
    }];
    
    
//    [sheet.directSharePlatforms addObject:@(SSDKPlatformTypeSinaWeibo)];
}

@end

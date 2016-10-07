//
//  QTVideoModel.h
//  QTGameLive
//
//  Created by Qinting on 16/4/17.
//  Copyright © 2016年 Qinting. All rights reserved.
//



#import <Foundation/Foundation.h>

/** ESJSONFormat 使用注意
 1.要确保录入的插件的内容是JSON类型的第一个 是字典
 2.类名要有层次感，这样有效防止类名重复
 */

@class QTVideoVideolistModel,QTVideoVideotopicModel,QTVideoVideosidlistModel;

@interface QTVideoModel : NSObject

@property (nonatomic, copy) NSString *videoHomeSid;

// videoList ---> QTVideoVideolistModel
@property (nonatomic, strong) NSArray<QTVideoVideolistModel *> *videoList;

//videoSidList ---> QTVideoVideosidlistModel
@property (nonatomic, strong) NSArray<QTVideoVideosidlistModel *> *videoSidList;


@end

@interface QTVideoVideolistModel : NSObject

// ptime >> pTime
@property (nonatomic, copy) NSString *pTime;

//videosource >> videoSource
@property (nonatomic, copy) NSString *videoSource;

//sectiontitle >> sectionTitle
@property (nonatomic, copy) NSString *sectionTitle;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *topicImg;

@property (nonatomic, copy) NSString *m3u8_url;

@property (nonatomic, copy) NSString *topicSid;

@property (nonatomic, copy) NSString *vid;

//playersize >> playerSize
@property (nonatomic, assign) NSInteger playerSize;

@property (nonatomic, copy) NSString *topicName;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *replyBoard;

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, assign) NSInteger playCount;

@property (nonatomic, assign) NSInteger length;

@property (nonatomic, copy) NSString *topicDesc;

@property (nonatomic, copy) NSString *mp4Hd_url;

//replyid >> replyId
@property (nonatomic, copy) NSString *replyId;

//videoTopic >>  QTVideoVideotopicModel
@property (nonatomic, strong) QTVideoVideotopicModel *videoTopic;

@property (nonatomic, copy) NSString *m3u8Hd_url;

@property (nonatomic, copy) NSString *mp4_url;

// description ---> desc
@property (nonatomic, copy) NSString *desc;

@end

@interface QTVideoVideotopicModel : NSObject

//
@property (nonatomic, copy) NSString *tname;

@property (nonatomic, copy) NSString *alias;

@property (nonatomic, copy) NSString *tid;

@property (nonatomic, copy) NSString *ename;

@end

@interface QTVideoVideosidlistModel : NSObject

@property (nonatomic, copy) NSString *sid;

@property (nonatomic, copy) NSString *title;

// imgsrc >> imgSrc
@property (nonatomic, copy) NSString *imgSrc;

@end


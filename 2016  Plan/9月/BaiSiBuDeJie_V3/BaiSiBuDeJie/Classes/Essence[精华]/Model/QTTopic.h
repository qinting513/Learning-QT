//
//  QTTopic.h
//  BaiSiBuDeJie
//
                        /*
                         *----------Dragon be here!----------*
                         * 　　　┏┓　　　┏┓
                         * 　　┏┛┻━━━┛┻┓
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　━　　　┃
                         * 　　┃　┳┛　┗┳　┃
                         * 　　┃　　　　　　　┃
                         * 　　┃　　　┻　　　┃
                         * 　　┃　　　　　　　┃
                         * 　　┗━┓　　　┏━┛
                         * 　　　　┃　　　┃神兽保佑
                         * 　　　　┃　　　┃代码永无BUG！
                         * 　　　　┃　　　┗━━━┓
                         * 　　　　┃　　　　　　　┣┓
                         * 　　　　┃　　　　　　　┏┛
                         * 　　　　┗┓┓┏━┳┓┏┛
                         * 　　　　　┃┫┫　┃┫┫
                         * 　　　　　┗┻┛　┗┻┛
                         * ━━━━━神兽出没，杀死BUG━━━━━━*
                         *
                         *  http://my.oschina.net/AngusTing/blog?catalog=3487645
                         *  推荐博客 http://www.jianshu.com/users/1c034326279d/latest_articles
                         *
                         */

//  Created by Qinting on 16/5/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTTopic : NSObject
@property (copy, nonatomic) NSString *id;
/** 发帖人的昵称 */
@property (copy, nonatomic) NSString *name;
/** 系统审核通过后创建帖子的时间 */
@property (copy, nonatomic) NSString *created_at;
/** 帖子的内容 */
@property (copy, nonatomic) NSString *text;
/** 帖子的类型 */
@property (assign, nonatomic) QTTopicType type;
/** 头像的图片url地址 */
@property (copy, nonatomic) NSString *profile_image;
/** 踩的人数 */
@property (assign, nonatomic) int hate;
/** 帖子的被评论数量 */
@property (assign, nonatomic) int comment;
/** 转发的数量 */
@property (assign, nonatomic) int repost;
/** 顶的数量 */
@property (assign, nonatomic) int love;
/** 主题 */
@property (strong, nonatomic) NSArray *themes;
/** 是否为新浪会员 */
@property (assign, nonatomic, getter=isSina_v) BOOL sina_v;

/****** 图片相关 ******/
/** 配图 */
@property (copy, nonatomic) NSString *image2;
/** 是否为gif图片 */
@property (assign, nonatomic) BOOL is_gif;
/** 视频或图片类型帖子的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 视频或图片类型帖子的高度 */
@property (assign, nonatomic) CGFloat height;

/****** 音频相关 ******/
/** 音频的时长 */
@property (assign, nonatomic) int voicetime;
/** 播放次数 */
@property (assign, nonatomic) int playcount;
/** 音频的播放地址 */
@property (copy, nonatomic) NSString *voiceuri;

/****** 视频相关 ******/
/** 视频的播放地址 */
@property (copy, nonatomic) NSString *videouri;
/** 视频的时长 */
@property (assign, nonatomic) int videotime;

/****** 额外添加的属性 ******/
@property (assign, nonatomic, getter=isBigImage) BOOL bigImage;
@end

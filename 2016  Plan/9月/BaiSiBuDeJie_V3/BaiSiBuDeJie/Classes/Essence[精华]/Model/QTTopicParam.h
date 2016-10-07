//
//  QTTopicParam.h
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

/** 该类为网络请求的参数类 */

@interface QTTopicParam : NSObject

/** 参数值为list，如果想要获取“新帖”板块的帖子，则传入"newlist"即可 */
@property (nonatomic,copy) NSString  *a;

/** 帖子：data */
@property (nonatomic,copy) NSString  *c;

/** 第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。 */
@property (nonatomic,copy) NSString   *maxtime;

/** 	当前所加载的页码数，默认为0  */
@property (nonatomic,strong) NSNumber *page;
/** 每页显示的帖子数量，默认为20 */
@property (nonatomic,strong) NSNumber *per;

/** 1为全部，10为图片，29为段子，31为音频，41为视频，默认为1 */
@property (nonatomic,assign)   QTTopicType type;



@end

//
//  ViewController.m
//  iCarouselDemo
//
//  Created by Qinting on 16/6/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "iCarousel.h"


@interface ViewController ()<iCarouselDataSource,iCarouselDelegate>
@property (nonatomic,strong) iCarousel *carousel;
@property (nonatomic,assign) CGSize  taskSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat taskWidth = [UIScreen mainScreen].bounds.size.width *5.0f/7.0f;
    self.taskSize = CGSizeMake(taskWidth, taskWidth *16.0f/9.0f);
    [self.view setBackgroundColor:[UIColor grayColor]];
    self.carousel = [[iCarousel alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview: self.carousel];
    [self.carousel setDelegate:self];
    [self.carousel setDataSource:self];
    [self.carousel setType:iCarouselTypeCustom];
}

-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 7;
}

-(UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIView *taskView = view;
    if (taskView == nil) {
        taskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.taskSize.width, self.taskSize.height)];
        
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:taskView.bounds];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
//        [imageView setBackgroundColor:[UIColor whiteColor]];
       
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"img%ld",index+1]];
        imageView.image = image;
         [taskView addSubview:imageView];
        
        /** 添加圆角效果 */
        [taskView .layer setShadowPath:[UIBezierPath bezierPathWithRoundedRect:imageView.frame cornerRadius:10.0f].CGPath ] ;
        [taskView.layer setShadowRadius:3.0f];
        [taskView.layer setShadowColor:[UIColor blackColor].CGColor];
        [taskView.layer setShadowOffset:CGSizeZero];
            /** 给imageView 添加圆角效果 */
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:imageView.bounds];
        [layer setPath:[UIBezierPath bezierPathWithRoundedRect:imageView.frame cornerRadius:10.0f].CGPath ];
        [imageView.layer setMask:layer];
        
//        UILabel *label = [[UILabel alloc]initWithFrame:taskView.bounds];
//        [label setText:[@(index) stringValue]];
//        [label setFont:[UIFont systemFontOfSize:50]];
//        [label setTextAlignment:NSTextAlignmentCenter];
//        [taskView addSubview:label];
   }
    return taskView;
}

// 计算缩放
-(CGFloat)calculateScaleWithOffset:(CGFloat)offset{
    return offset * 0.02f + 1.0f;
}

// 计算位移
-(CGFloat )calculateTranslationWithOffset:(CGFloat)offset{
    CGFloat z = 5.0f / 4.0f;
    CGFloat a = 5.0f / 8.0f;
    
    //移出屏幕
    if(offset >= z/a){
        return 2.0f;
    }
    return 1/(z-a*offset) - 1/z;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    CGFloat scale = [self calculateScaleWithOffset:offset];
    CGFloat translation = [self calculateTranslationWithOffset:offset];
    /** 调整层级关系  把0改为offset */
    return CATransform3DScale(CATransform3DTranslate(transform, translation*self.taskSize.width, 0, offset), scale, scale, 1.0f);
}

#pragma mark - delegate
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"selected: %ld",index);

}

@end

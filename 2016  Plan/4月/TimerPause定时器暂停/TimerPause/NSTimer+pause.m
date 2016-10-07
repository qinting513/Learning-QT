//
//  NSTimer+pause.m
//  TimerPause
//
//  Created by Qinting on 16/4/14.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "NSTimer+pause.h"

@implementation NSTimer (pause)


-(void)pauseTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    [self setFireDate:[NSDate distantFuture]];
}

-(void)resumeTimer{
        
        if (![self isValid]) {
            return ;
        }
        
        [self setFireDate:[NSDate date]];
        
}

@end

//
//  Detail.h
//  Decoration
//
//  Created by tarena on 16/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DetailTeam,DetailProgress,DetailProgressSteps;

@interface Detail : NSObject

@property (nonatomic, strong) NSNumber* budget;

@property (nonatomic, strong) NSArray<DetailProgress *> *progress;

@property (nonatomic, copy) NSString *info;

@property (nonatomic, strong) NSArray<DetailTeam *> *team;

@property (nonatomic, copy) NSString *master;

@property (nonatomic, copy) NSString *address;

@end
@interface DetailTeam : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *icon;

@end

@interface DetailProgress : NSObject

@property (nonatomic, copy) NSString *progressName;

@property (nonatomic, copy) NSString *dayCount;

@property (nonatomic, strong) NSArray<DetailProgressSteps *> *steps;

@property (nonatomic, copy) NSString *date;

@end

@interface DetailProgressSteps : NSObject

@property (nonatomic, copy) NSString *step;

@property (nonatomic, copy) NSString *progressNum;

@property (nonatomic,strong) NSArray  *photos;

@end


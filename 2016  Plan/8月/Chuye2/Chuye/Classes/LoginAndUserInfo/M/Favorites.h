//
//  Favorites.h
//  Chuye
//
               

//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FavoritesData,FavoritesDataUser;

@interface Favorites : NSObject

@property (nonatomic, strong) NSArray<FavoritesData *> *data;

@property (nonatomic, assign) NSInteger code;

@end
@interface FavoritesData : NSObject

@property (nonatomic, assign) NSInteger Access;

@property (nonatomic, assign) NSInteger Praise;

@property (nonatomic, copy) NSString *CreateAt;

@property (nonatomic, assign) NSInteger Fid;

@property (nonatomic, copy) NSString *Thumbnail;

@property (nonatomic, copy) NSString *Uri;

@property (nonatomic, assign) NSInteger Comments;

@property (nonatomic, copy) NSString *Title;

@property (nonatomic, strong) FavoritesDataUser *User;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger Share;

@end

@interface FavoritesDataUser : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *introduction;

@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *headPhoto;

@property (nonatomic, assign) NSInteger sex;

@end


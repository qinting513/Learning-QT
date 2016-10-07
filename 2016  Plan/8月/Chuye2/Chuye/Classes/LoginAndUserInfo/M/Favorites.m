//
//  Favorites.m
//  Chuye
//
//  Created by Qinting on 16/8/19.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Favorites.h"

@implementation Favorites
+(NSDictionary *)objectInArray{
    return @{@"data":[FavoritesData class]};
}
@end
@implementation FavoritesData
+(NSDictionary *)objectInArray{
    return @{@"User":[FavoritesDataUser class]};
}
@end


@implementation FavoritesDataUser

@end



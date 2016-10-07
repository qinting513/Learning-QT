//
//  Node.m
//  TreeTableView
//
//  Created by Qinting on 16/4/24.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)initWithParentId : (int)parentId nodeId : (int)nodeId name : (NSString *)name depth : (int)depth expand : (BOOL)expand{
    self = [self init];
    if (self) {
        self.parentId = parentId;
        self.nodeId = nodeId;
        self.name = name;
        self.depth = depth;
        self.expand = expand;
    }
    return self;
}

@end

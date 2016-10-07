//
//  Employee+CoreDataProperties.h
//  Employee
//
//  Created by Qinting on 16/5/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Employee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSNumber *height;

@end

NS_ASSUME_NONNULL_END

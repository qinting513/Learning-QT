//
//  ViewController.m
//  Employee
//
//  Created by Qinting on 16/5/8.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "Employee+CoreDataProperties.h"

@interface ViewController ()
@property (nonatomic,strong) NSManagedObjectContext *context;
- (IBAction)insertData:(id)sender;
- (IBAction)queryData:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setupDB];
  
    
}

- (void)setupDB{

    /** 1.创建上下文 */
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    /** 传一个nil，即可以把所有的都关联  */
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    /** 持久化存储调度器 */
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    NSError *error = nil;
    /** 数据保存的路径 */
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [doc  stringByAppendingPathComponent:@"company.sqlite"];
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlPath]   options:nil error:&error];
    /** 关联模型文件 */
    context.persistentStoreCoordinator = store;
    self.context = context;
}


- (IBAction)insertData:(id)sender {

    Employee *emp = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];
    emp.name = @"zhangsan";
    emp.age = @19;
    emp.height = @1.98;
    
    NSError *error = nil;
    [self.context  save:&error];
    if (!error) {
        NSLog(@"插入成功");
    }
}
- (IBAction)queryData:(id)sender {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];
    NSError *error = nil;
   NSArray *emps =  [self.context executeFetchRequest:request error:&error];
    if (!error) {
//        NSLog(@"emps:%@",emps);
        for (Employee *ee  in emps) {
            NSLog(@"emp:%@ %@ %@",ee.name,ee.age,ee.height);
        }
    }else{
        NSLog(@"error:%@",error);
    }
    
}
@end

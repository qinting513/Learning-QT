//
//  ViewController.m
//  SqlCURD
//
//  Created by Qinting on 16/5/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "FMDB.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//db是数据库的句柄，就是数据库的象征，要对数据库进行增删改查，就得操作这个实例
@property (nonatomic,assign)  FMDatabase * database;

@property (nonatomic,strong) NSMutableArray *allPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allPerson = [NSMutableArray array];
    self.tableView.dataSource = self;
    
}

/** 注意写成单例，要不然出现也指针错误 */
-(FMDatabase*)database
{
    //    1.创建一个静态的空的对象
    static FMDatabase* database = nil;
    //    2.创建一个静态的单次任务
    static dispatch_once_t onceToken;
    //    3.使用一次性任务,初始化单例对象
    dispatch_once(&onceToken,^{
        //        初始化 （路径 + 创建db对象 + 打开）
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [docPath stringByAppendingPathComponent:@"t_studentDB.sqlite"];
        database = [FMDatabase databaseWithPath:dbPath];
    });
    //    block里只执行一次，
    if ([database open]) {
        return database;
    }
    else
    { //打不开则retry打开
        return nil;
    }
}

- (IBAction)createTable:(id)sender {
  
    if([self.database open]){

        BOOL isOK = [self.database executeUpdate:@ "create table if not exists  t_student( id integer  primary key autoincrement, name  text, age  integer)"];
        if (! isOK ) {
            NSLog(@"创建表失败：%@",self.database.lastError);
        }else{
            NSLog(@"创建表成功");
        }
    }
    [self.database close];
}

- (IBAction)deleteTable:(id)sender {
   [self.database open];
    
    BOOL isOK = [self.database executeUpdate:@"drop table if exists  t_student"];
    if (! isOK ) {
        NSLog(@"deleteTable失败：%@",self.database.lastError);
    }else{
        NSLog(@"deleteTable成功");
    }
    [self.allPerson removeAllObjects];
    [self.tableView reloadData];
    
    [self.database close];
}

- (IBAction)addColumn:(id)sender {
    [self.database open];
    BOOL isOK = [self.database executeUpdateWithFormat:@"insert into t_student (name,age) values (%@,%d)",@"zhangsan",10];
    if (! isOK ) {
        NSLog(@"addColumn失败：%@",self.database.lastError);
    }else{
        NSLog(@"addColumn成功");
    }
    [self selectColumn:sender];
      [self.database close];
}
- (IBAction)deleteColumn:(id)sender {
    [self.database open];
   BOOL isOK = [self.database executeUpdate:@"delete from t_student where name = 'zhangsan' "];
    if (! isOK ) {
        NSLog(@"deleteColumn失败：%@",self.database.lastError);
    }else{
        NSLog(@"deleteColumn成功");
    }
    [self selectColumn:sender];
        [self.database close];
}

- (IBAction)updateColumn:(id)sender {
    [self.database open];
   BOOL isOK = [self.database executeUpdate:@"update  t_student set name = 'Xiao' where id < 3"];
    if (! isOK ) {
        NSLog(@"updateColumn失败：%@",self.database.lastError);
    }else{
        NSLog(@"updateColumn成功");
    }
    [self selectColumn:sender];
    [self.database close];
}
- (IBAction)selectColumn:(id)sender {
    [self.database open];
    
    [self.allPerson removeAllObjects];
    FMResultSet *resultSet = [self.database executeQuery:@"select * from t_student "];
    while([resultSet next]){
        NSString *name = [resultSet stringForColumn:@"name"];
        int age = [resultSet intForColumn:@"age"];
        Person *p = [[Person alloc ]initWithName:name andAge:age];
        [self.allPerson addObject:p];
    }
    [self.tableView reloadData];
    [self.database close];

}


#pragma mark - 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.allPerson.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    Person *p = self.allPerson[indexPath.row];
    cell.textLabel.text = p.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",p.age];
    return cell;
}

@end

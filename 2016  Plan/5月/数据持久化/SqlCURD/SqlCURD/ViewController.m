//
//  ViewController.m
//  SqlCURD
//
//  Created by Qinting on 16/5/5.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>
#import "Person.h"

@interface ViewController ()<UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//db是数据库的句柄，就是数据库的象征，要对数据库进行增删改查，就得操作这个实例
@property (nonatomic,assign)  sqlite3 *database;

@property (nonatomic,strong) NSMutableArray *allPerson;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allPerson = [NSMutableArray array];
    self.tableView.dataSource = self;
    
    /** 打开数据库 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dbPath = [docPath stringByAppendingPathComponent:@"t_studentDB.sqlite"];
    
    int ret = sqlite3_open(dbPath.UTF8String,&_database);
    if (ret == SQLITE_OK) {
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"代开数据库失败：%s",sqlite3_errmsg(_database));
    }
    
}

- (IBAction)createTable:(id)sender {
 
    char *error = NULL;
const char *createTable = "create table if not exists  t_student( id integer  primary key autoincrement, name  text, age  integer)";
    int ret1 = sqlite3_exec(_database,createTable,NULL,NULL,&error);
    if (ret1 != SQLITE_OK) {
        NSLog(@"创建表失败：%s",error);
    }else{
        NSLog(@"创建表成功");
    }
}

- (IBAction)deleteTable:(id)sender {
    char *error = NULL;
    const char *delete = "drop table  if exists  t_student ";
    int ret = sqlite3_exec(_database, delete, NULL, NULL, &error);
    if (ret != SQLITE_OK) {
        NSLog(@"删除失败：%s",error);
    }else{
        NSLog(@"删除表成功");
        [self.allPerson removeAllObjects];
        [self.tableView reloadData];
    }
}

- (IBAction)addColumn:(id)sender {
    char *error = NULL;
    NSString *add = [NSString stringWithFormat:@"insert into t_student (name,age) values ('%@',%d)",@"zhangsan",10];
    int ret = sqlite3_exec(_database, add.UTF8String, NULL, NULL, &error);
    if (ret != SQLITE_OK) {
        NSLog(@"添加字段失败：%s",error);
    }else{
        NSLog(@"添加字段成功");
//        [self.tableView reloadData];
        [self selectColumn:sender];
    }
    
}
- (IBAction)deleteColumn:(id)sender {
    char *error = NULL;
    const char *delete = "delete from t_student where name = 'zhangsan' ";
    int ret = sqlite3_exec(_database, delete, NULL, NULL, &error);
    if (ret != SQLITE_OK) {
        NSLog(@"删除字段失败：%s",error);
    }else{
        NSLog(@"删除字段成功");
//        [self.tableView reloadData];
        [self selectColumn:sender];
    }
}

- (IBAction)updateColumn:(id)sender {
    char *error = NULL;
    const char *update = "update  t_student set name = 'Xiao' where id > 3";
    int ret = sqlite3_exec(_database, update , NULL, NULL, &error);
    if (ret != SQLITE_OK) {
        NSLog(@"更新失败：%s",error);
    }else{
        NSLog(@"更新成功");
//        [self.tableView reloadData];
        [self selectColumn:sender];
    }
}
- (IBAction)selectColumn:(id)sender {
    
    const char *select = "select * from t_student ";
    sqlite3_stmt *stmt = NULL;
  int ret =  sqlite3_prepare(_database, select, -1, &stmt, NULL);
    if(ret != SQLITE_OK){
        NSLog(@"查询不成功:%s",sqlite3_errmsg(_database));
    }else{
        [self.allPerson removeAllObjects];
        while(sqlite3_step(stmt) == SQLITE_ROW){
            int ID = sqlite3_column_int(stmt,0);
            NSLog(@"ID:%d",ID);
            const unsigned char *name = sqlite3_column_text(stmt,1);
            int age = sqlite3_column_int(stmt,2);
            NSString* pName = [[NSString alloc]initWithUTF8String:name];
            
            Person *p = [[Person alloc]initWithName:pName andAge:age];
            [self.allPerson addObject:p];
        }
        //        收尾工作，将stmt存储的数据释放掉
        sqlite3_finalize(stmt);
        [self.tableView reloadData];
        NSLog(@"查询成功");
    }
  

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

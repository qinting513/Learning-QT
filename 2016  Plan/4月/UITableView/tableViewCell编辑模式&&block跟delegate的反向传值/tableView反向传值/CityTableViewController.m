//
//  CityTableViewController.m
//  City_TableView
//
//  Created by tarena01 on 15/11/16.
//  Copyright (c) 2015年 tarena01. All rights reserved.
//

#import "CityTableViewController.h"
#import "City.h"
#import "InputViewController.h"

@interface CityTableViewController () <InputViewControllerDelegate>

@property (nonatomic,strong)NSMutableArray* allCitys;


@end

@implementation CityTableViewController

-(NSArray*)allCitys
{
    if (!_allCitys)
    {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"City.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _allCitys = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            City *city = [City cityWithDictionary:dict];
            [_allCitys addObject:city];
        }
    }
    return _allCitys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市列表";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(deleteCell:)];
   
}


#pragma mark - Table view data source
//回答三问
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 return self.allCitys.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    static NSString* cellID =@"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    City* city = self.allCitys[indexPath.row];
    cell.textLabel.text = city.cityName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"NO.：%ld",city.population];
    return cell;
}

#pragma mark -- tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark -- tableView add && 值的回传

-(void)add:(UIBarButtonItem*)button
{
    InputViewController * inputVC = [[InputViewController alloc]init];
//    inputVC.delegate = self;
    /** 用block方法回传 */
    inputVC.returnCityBlock = ^(City *city){
    
        if ((city.cityName == nil) || (city.population == 0))
        {
            return;
        }
        else
        {
            //        先处理数据模型再刷新表格
            [self.allCitys insertObject:city atIndex:0];
            //        [self.allCitys addObject:city];  //加到最后面
            
            //    [self.tableView reloadData];
            //在表格最后增加一行
            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            
        }
    
    };
    
    [self.navigationController pushViewController:inputVC animated:YES];
    
}

-(void)inputViewOController:(InputViewController *)inputVC didReturnCity:(City *)city
{
    if ((city.cityName == nil) || (city.population == 0))
    {
        return;
    }
    else
    {
//        先处理数据模型再刷新表格
        [self.allCitys insertObject:city atIndex:0];
//        [self.allCitys addObject:city];  //加到最后面
        
        //    [self.tableView reloadData];
        //在表格最后增加一行
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    }
}

-(void)deleteCell:(UIBarButtonItem*)button
{
    [self.tableView setEditing:!self.tableView.editing animated:YES] ;
    button.title = self.tableView.editing ? @"完成" : @"编辑" ;
}

#pragma mark -- 表格的编辑功能
//两问一答： 先处理数据模型再刷新表格
//当前行是否可以进入编辑模式
//当前行是何种编辑样式
//点击按钮后执行什么动作
//1.是否能编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if  (indexPath.row == 0)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
//2.当前行的编辑样式是什么
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return  UITableViewCellEditingStyleDelete;
//    if (indexPath.row == _allCitys.count-1)
//    {
//        return UITableViewCellEditingStyleInsert;
//    }
//    else
//    {
//       return  UITableViewCellEditingStyleDelete;
//    }
//    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete; //多选，但Apple不给上架
    
}
//答1：点击按钮后做什么 返回值一般是void
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"click..."); //当点击删除那两个字或者绿色加号按钮时打印，说明点击后该做什么动作
    if(editingStyle == UITableViewCellEditingStyleInsert)
        // add one row
    {
        //        1。先将数据增加到数据模型中

        City* newCity = [[City alloc]init];
        newCity.cityName = @"test";
        newCity.population = 1000;
        [self.allCitys addObject:newCity];
        //        2.刷新表格
        NSIndexPath* newIndexPath = [NSIndexPath indexPathForRow:self.allCitys.count-1 inSection:0];
        [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationMiddle];
  
    }
    else if (editingStyle == UITableViewCellEditingStyleDelete)
        //delete one row
    {
        [self.allCitys removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        NSLog(@"retainCount: %ld",self.allCitys.count);
    }
    
}

#pragma mark --move 表格的移动
//一问一答  先处理数据模型再刷新表格
//1.能否 移动
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//2.答：怎么移动
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
// 1.按照旧的位置，找到原始的数据
    City* city = [self.allCitys objectAtIndex:sourceIndexPath.row];
//    2.将数据从原来的位置移除
    [self.allCitys removeObject:city];
//    3.再将数据按照新的位置插入回数组
    [self.allCitys insertObject:city atIndex:destinationIndexPath.row];
    
}

@end

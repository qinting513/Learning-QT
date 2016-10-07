//
//  TRFoldTableViewController.m
//  TableVIewFold
//
//  Created by yyh on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TRFoldTableViewController.h"

@interface TRFoldTableViewController ()<TRFoldingSectionHeaderDelegate>

@property (nonatomic ,strong) NSMutableArray *rowArrays;
@property (nonatomic ,assign) BOOL isOpen;

@end

@implementation TRFoldTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 50;
}


#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
               
    
    TRFoldView *sectionHeaderView = [[TRFoldView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:self.tableView heightForHeaderInSection:section]) withTag:section andIsOpen:[self.rowArrays[section][@"isOpen"] boolValue]];
    NSLog(@"%ld +++++ %@", section,self.rowArrays[section][@"isOpen"]);
    sectionHeaderView.tapDelegate = self;
    return sectionHeaderView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.rowArrays[section][@"isOpen"] boolValue]) {
        return [self.rowArrays[section][@"array"] count]  ;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if ([self.rowArrays[indexPath.section][@"isOpen"] boolValue]) {
               cell.textLabel.text = [NSString stringWithFormat:@"Row %ld",indexPath.row];
    }
     return cell;
}


-(void)foldingSectionHeaderTappedAtIndex:(NSInteger)index andIsOpen:(BOOL)isOpen
{
    //判断给分区下存在的行数取出来
    NSInteger numberOfRow = [self tableView:self.tableView numberOfRowsInSection:index];
    
    NSMutableArray *rowArray = [NSMutableArray array];
    //判断分区是否是存在行数，存在则取出，不存在则赋值
    if (!numberOfRow) {
        for (NSInteger i = 0; i < 3; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
        
    }else{
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }

    }
    //更改数组中字典中对应key的value
    self.rowArrays[index][@"isOpen"] = [NSNumber numberWithBool:isOpen];
    //声明一个数组
    NSArray *array = @[@"",@"",@""];
    //判断传回来的值，如果是折叠的则删除数据（行），否则增加数据
    if (isOpen) {
        self.rowArrays[index][@"array"] = [array mutableCopy];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
    }else{
        [ self.rowArrays[index][@"array"] removeAllObjects];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
    }
    
}
#pragma mark - 懒加载
- (NSMutableArray *)rowArrays {
    if(_rowArrays == nil) {
        _rowArrays = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i++) {
            NSMutableArray *array = [NSMutableArray array];
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"isOpen"] = [NSNumber numberWithBool:NO];
            dic[@"array"] = array;
            [_rowArrays addObject:dic];
        }
    }
    return _rowArrays;
}

@end

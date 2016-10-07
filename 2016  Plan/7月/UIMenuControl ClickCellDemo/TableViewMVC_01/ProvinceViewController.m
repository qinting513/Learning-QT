//
//  abcViewController.m
//  tableView
//
//  Created by tarena19 on 2015/10/23.
//  Copyright (c) 2015年 ___FULLUSERNAME___. All rights reserved.
//


#import "ProvinceViewController.h"
#import "DataManager.h"
#import "Provinces.h"

@interface ProvinceViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 所有省份 */
@property (nonatomic,strong) NSArray *allProvinces;
@property (nonatomic,strong) UITableView *tableView;
/** 顶 的数量存在此数组里  */
@property (nonatomic,strong) NSMutableArray *dingArray;
/** 举报的数量存在此数组里 */
@property (nonatomic,strong) NSMutableArray *warnArray;

@end

@implementation ProvinceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title = @"中国";
    
    _allProvinces = [DataManager loadData];
    
    //2.creat tableView
    UITableView* tableView=[[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
     tableView.dataSource=self;
    tableView.delegate = self;
    self.tableView  = tableView;
    [self.view addSubview:tableView];
  
}

#pragma mark --dataSource

//have how many section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allProvinces.count;
}

//a section have how many row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    Provinces* p=_allProvinces[section];
    return p.cities.count;
}

//  a cell content
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier=@"cell";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    Provinces* p=_allProvinces[indexPath.section];
    cell.textLabel.text=p.cities[indexPath.row];
//    cell.textLabel.textColor=[UIColor redColor];
    
    if ([self.dingArray containsObject:indexPath]) {
#warning 注意一定要将附件置为空的，要不然会覆盖到那个勾
            cell.accessoryView = nil;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else  if ([self.warnArray containsObject:indexPath]) {
        UILabel *label = [self createLabelByCell:cell];
               cell.accessoryView = label;
    }else{
#warning 注意要有else，要不然重用的话，其他cell会有打勾或者打X
        cell.accessoryType = UITableViewCellAccessoryNone;
         cell.accessoryView = nil;
    }
    
    return cell;
}

-(UILabel *)createLabelByCell:(UITableViewCell *)cell
{
    UILabel *label = [cell.contentView viewWithTag:100];
    if (label == nil) {
        label = [UILabel new];
        label.frame = CGRectMake(0, 0, 30, 30);
        label.textAlignment = NSTextAlignmentRight;
        label.text = @"X";
        label.textColor = [UIColor redColor];
        label.tag = 100;
    }
    return label;
}

#pragma mark --tableViewDelegate

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Provinces* p=_allProvinces[section];
    return p.header;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    Provinces* p=_allProvinces[section];
    return p.footer;
}

-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray * sectionIndex=[NSMutableArray array];
    for (Provinces* p in _allProvinces)
    {
        [sectionIndex addObject:p.header];
    }
    return sectionIndex;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell  = [tableView cellForRowAtIndexPath:indexPath];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    menu.menuItems = @[
                       [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(ding:)],
                       [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(reply:)],
                       [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(warn:)]
                       ];
//    CGRect rect = CGRectMake(0, cell.frame.size.height*0.5, cell.frame.size.width, 2);
    CGRect rect = CGRectZero;
    [menu setTargetRect:rect inView:cell];
    
    //显示出来
    [menu setMenuVisible:YES animated:YES];
    
}

#pragma mark - UIMenuController 代理方法
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if(action == @selector(ding:) || action == @selector(reply:) || action == @selector(warn:) )
        return YES;
    return NO;
}

-(BOOL)canBecomeFirstResponder
{
    return  YES;
}

-(void)ding:(UIMenuController*)sender
{
    NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    
    if ([self.warnArray containsObject:indexPath]) {
        [self.warnArray removeObject:indexPath];
    }
    
    if ([self.dingArray containsObject:indexPath]) {
        [self.dingArray removeObject:indexPath];
    }else{
        [self.dingArray addObject:indexPath];
    }
    [self.tableView reloadData];
}
-(void)reply:(UIMenuController*)sender
{
       [self.tableView reloadData];
}

-(void)warn:(UIMenuController*)sender
{
    NSIndexPath *indexPath =  [self.tableView indexPathForSelectedRow];
    if ([self.dingArray containsObject:indexPath]) {
        [self.dingArray removeObject:indexPath];
    }
    
    if ([self.warnArray containsObject:indexPath]) {
        [self.warnArray removeObject:indexPath];
    }else{
        [self.warnArray addObject:indexPath];
    }
    [self.tableView reloadData];
}

#pragma mark  - 懒加载
- (NSMutableArray *)dingArray {
	if(_dingArray == nil) {
		_dingArray = [[NSMutableArray alloc] init];
	}
	return _dingArray;
}

- (NSMutableArray *)warnArray {
	if(_warnArray == nil) {
		_warnArray = [[NSMutableArray alloc] init];
	}
	return _warnArray;
}

@end

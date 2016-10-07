//
//  ViewController.m
//  RotateTableView
//
//  Created by Qinting on 16/4/22.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)  UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    CGRect tableViewRect = CGRectMake(0.0, 0.0, 80.0, self.view.bounds.size.width);
    self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.tableView.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //tableview逆时针旋转90度。
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    // scrollbar 不显示
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    //发现无论怎么调整tableView的x,y 它都始终在中心 只好将其添加到一个View上， 但是如果这个类不是UITableViewController，是ViewController的话 则似乎可以直接设置tableView的 x,y
    self.tableView.center =  view.center;
    
    [self.view  addSubview: self.tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

//tableviewCell 逆时针旋转90度。
- (UITableViewCell *)tableView :( UITableView *)tableView cellForRowAtIndexPath :( NSIndexPath*)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"identifier"];
        cell.textLabel.text = @"cell上的";
        // cell顺时针旋转90度
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
    }
    
    UILabel *label = [UILabel new];
    label.frame = cell.frame;
    label.text = @"添加的label";
    [cell.contentView addSubview:label];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"选择了第%ld行",indexPath.row);
}

@end

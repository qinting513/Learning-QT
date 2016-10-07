//
//  showResultTableViewController.m
//  tableView添加搜索框
//
//  Created by tarena01 on 15/11/18.
//  Copyright (c) 2015年 qt. All rights reserved.
//

#import "ShowResultTableViewController.h"
#import "Product.h"

@interface ShowResultTableViewController ()

@end

@implementation ShowResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    Product* p = self.resultArray[indexPath.row];
    cell.textLabel.text = p.name;
    
    if (p.type == ProductTypeDevices)
    {
        cell.detailTextLabel.text = @"Device";
    }
    else if (p.type == ProductTypeSoftware)
    {
        cell.detailTextLabel.text = @"software";
    }
    else
    {
        
        cell.detailTextLabel.text = @"other";
    }
    
    
    return cell;
}


@end

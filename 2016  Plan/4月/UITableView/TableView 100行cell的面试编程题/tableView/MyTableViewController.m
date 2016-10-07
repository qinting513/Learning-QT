//
//  MyTableViewController.m
//  tableView
//
//  Created by Qinting on 16/4/18.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTableViewCell.h"

@interface MyTableViewController ()
/**  接收退出界面的text */
@property (nonatomic,strong) NSMutableArray* textSave;
@property (nonatomic,strong) NSMutableDictionary  *mutableDic;
@end

/** 
 题目 要求：
     tableView有100个cell，每个cell（用重用机制创建的cell）都有一个TextField，
 当输入文字后，上下滑动cell后，textField里的字符串之前在哪个cell输入的，仍然存在于
 那个cell，没有输入过的，cell都是空的
 */
@implementation MyTableViewController
/**  沒接收前默認為空 */
-(NSMutableArray *)textSave
{
    if (!_textSave)
    {
        _textSave = [NSMutableArray arrayWithCapacity:100];
        for (int i = 0; i < 100; i++) {
            [_textSave addObject:@""];
        }
    }
    return _textSave;
}

- (NSMutableDictionary *)mutableDic {
    if( !_mutableDic) {
        _mutableDic = [NSMutableDictionary dictionary] ;
    }
    return  _mutableDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *cellID = @"cell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    /**  重新出現的cell存入之前輸入的text */
//    cell.textField.text = self.textSave[indexPath.row];
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textField.text = self.mutableDic[key];
    return cell;
}
/**  在cell要退出屏幕的時候保存text */
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *missCell = [tableView cellForRowAtIndexPath:indexPath];
//    self.textSave[indexPath.row] = missCell.textField.text;
//    NSLog(@"%ld--%@",indexPath.row, self.textSave[indexPath.row]);
    NSString *key = [NSString stringWithFormat:@"%ld",indexPath.row];
    if(missCell.textField.hasText){
      [self.mutableDic setObject:missCell.textField.text forKey:key];
        NSLog(@"%ld--%@",indexPath.row, self.mutableDic[key]);
    }

}
@end

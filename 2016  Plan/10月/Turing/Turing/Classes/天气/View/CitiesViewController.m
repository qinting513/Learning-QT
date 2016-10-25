//
//  CitiesViewController.m
//  天气预报
//
//  Created by tarena22 on 16/8/31.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "CitiesViewController.h"
#import "WeatherUtils.h"
#import "CityModel.h"
@interface CitiesViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *cities;
@property (nonatomic, strong)UISearchController *searchController;
@property (nonatomic, strong)NSMutableArray *searchResultCitys;
@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"选择的城市";
    UITableView* tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate =self;
    tableView.dataSource =self;

    
    
    

    [WeatherUtils requestCitysWithCallback:^(id obj) {
        self.cities =obj;
        [self.tableView reloadData];
    }];
     self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    //是否隐藏原来的tableView的内容  因为结果就是显示到当前页面 所以不能隐藏
    self.searchController.dimsBackgroundDuringPresentation = NO;
    //设置结果过滤器
    self.searchController.searchResultsUpdater = self;
    
    //把搜索栏添加到表头
    self.tableView.tableHeaderView = self.searchController.searchBar;
 
    
    // Do any additional setup after loading the view.
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
     self.searchResultCitys = [NSMutableArray array];
     NSString *searchInfo = searchController.searchBar.text;
    for(CityModel*c in self.cities)
    {
        if ([c.district containsString:searchInfo]) {
            //把搜索到的城市添加进去
            [self.searchResultCitys addObject:c];
               [self.tableView reloadData];
        }
        [self.tableView reloadData];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.searchController.isActive)
    {
        return 1;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.searchController.isActive) {
        return self.searchResultCitys.count;
    }
    return self.cities.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    if (self.searchController.isActive) {//如果是搜索状态
        
        CityModel *c = self.searchResultCitys[indexPath.row];
        
        cell.textLabel.text = c.district;
        
        
    }else{
        CityModel* cty = self.cities[indexPath.row];
        cell.textLabel.text = cty.district;
}
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityModel *cty = nil;
    if (self.searchController.isActive) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        cty = self.searchResultCitys[indexPath.row];
        
    }else{
       
        cty = self.cities[indexPath.row];
        
    }
   
    NSString *message = [NSString stringWithFormat:@"是否切换到 %@",cty.district];
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:cty.district forKey:CITY_NAME_KEY];
        [ud setObject:cty.city_id forKey:CITY_ID_KEY];
        [ud synchronize];
        
        //返回页面
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    
    [self presentViewController:ac animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    NSLog(@"城市列表界面释放");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

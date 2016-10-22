//
//  DetailViewController.m
//  Decoration
//
//  Created by Qinting on 2016/10/20.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "DetailViewController.h"
#import "LiveVC.h"
#import "DetailUtil.h"
#import "Detail.h"
#import "HeadView.h"
#import "TeamMemberCell.h"
#import "FirstSectionCell.h"
#import "ProgressHeadCell.h"
#import "ProgressStepCell.h"
#import "PhotoBroswerVC.h"
@interface DetailViewController ()<UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) HeadView  *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) Detail  *detail;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,strong)NSArray *photos;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initHeadView];
    [self loadData];
}

-(void)initHeadView{
     self.title = @"装修详情";
     self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    UIButton *star = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [star setImage:[UIImage imageNamed:@"star_icon"] forState:UIControlStateNormal];
    UIButton *share = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [share setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems = @[
                                                [[UIBarButtonItem alloc]initWithCustomView:share],
                                                [[UIBarButtonItem alloc]initWithCustomView:star]
                                                ];
    self.tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
    self.headView = [HeadView loadView];
    self.headView.frame = CGRectMake(0, 0, self.view.bounds.size.width,295);
    self.tableView.tableHeaderView = self.headView;
    self.headView.collectionView.dataSource = self;
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.0 - 5, 60);
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.headView.collectionView.collectionViewLayout =  fl;
    [self.headView.collectionView registerNib:[UINib nibWithNibName:@"TeamMemberCell" bundle:nil] forCellWithReuseIdentifier:@"TeamMemberCell"];
    // 禁止collectionView滚动
    self.headView.collectionView.scrollEnabled = NO;
//    self.headView.collectionView.showsHorizontalScrollIndicator = NO;
    [self.headView.liveBtn addTarget:self action:@selector(liveBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)loadData{
    // 获取数据
    self.detail = [DetailUtil parseDetail];
    self.headView.masterLabel.text = self.detail.master;
    self.headView.infoLabel.text = self.detail.info;
    [self.headView.collectionView reloadData];
    [self.tableView reloadData];
}

-(void)liveBtnClick{
    [self presentViewController:[LiveVC new] animated:YES completion:nil];
}


#pragma mark -  <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.detail.team.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeamMemberCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamMemberCell" forIndexPath:indexPath];
    
    cell.team = self.detail.team[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 2;
    }else{
        return self.detail.progress.firstObject.steps.count + self.detail.progress.lastObject.steps.count + 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //self.photos =
   
    if (indexPath.section == 0) {
        FirstSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section0"];
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:@"FirstSectionCell" owner:nil options:nil].firstObject;
        }
        if (indexPath.row == 0) {
        cell.label.text =  [NSString stringWithFormat:@"地址：%@",self.detail.address];
        }else{
            cell.label.text =  [NSString stringWithFormat:@"预算：%@ 万",self.detail.budget.stringValue] ;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }
    if(indexPath.section == 1){
//        NSLog(@"============row:%ld",indexPath.row);
        DetailProgress * progress = self.detail.progress.firstObject;
        if (indexPath.row == 0 || indexPath.row == progress.steps.count + 1 ){
        // title 行
            static NSString *cellId=@"ProgressHeadCell";
            ProgressHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell=[[NSBundle mainBundle] loadNibNamed:@"ProgressHeadCell" owner:nil options:nil].firstObject;
            }
            if(indexPath.row == progress.steps.count + 1){
                progress = self.detail.progress.lastObject;
                cell.verticalLineHeight.constant = 44.0f;
            }
            
            cell.dayCountLabel.text = progress.dayCount;
            cell.dateLabel.text = progress.date;
            
            cell.circleView.layer.cornerRadius = 8;
            cell.circleView.layer.masksToBounds = YES;
             return cell;
        }else{
            static NSString *cellId=@"ProgressStepCell";
            ProgressStepCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
              cell=[[NSBundle mainBundle] loadNibNamed:@"ProgressStepCell" owner:nil options:nil].firstObject;
            }
            DetailProgressSteps *s = progress.steps[indexPath.row - 1];
            self.photos = s.photos;
//            NSLog(@"sssss : %@",s.step);
               cell.stepLabel.text = s.step;
            if(s.photos.count > 0){
                [self createImageViews:s.photos inView:cell.containView];
            }
            if(s.progressNum.length > 0){
                [self createProgressView:s.progressNum inView:cell.containView];
                cell.containView.backgroundColor = [UIColor lightGrayColor];
            }
            
//            if (s.photos.count > 0 || s.progressNum.length > 0) {
//                cell.containView.hidden = NO;
//            }else{
//                cell.containView.hidden = YES;
//            }
            cell.containView.hidden = !(s.photos.count > 0 || s.progressNum.length > 0);
            
            cell.circleView.layer.cornerRadius = 8;
            cell.circleView.layer.masksToBounds = YES;
            return cell;
        }
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        DetailProgress * progress = self.detail.progress.firstObject;
        if ( indexPath.row > 0 && indexPath.row < progress.steps.count + 1) {
            DetailProgressSteps *s = progress.steps[indexPath.row - 1];
            if (s.progressNum.length > 0) {
                return 80;
            } else  if (s.photos.count > 0){
                return 170;
            }else{
                return 44;
            }
        }
    }
    return 44;
}

-(void)createImageViews:(NSArray *)photos inView:(UIView *)view{
    self.imageViews = [NSMutableArray array];
    for(int i = 0; i< photos.count; i++){
        UIImageView *iv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:photos[i]]];
        int row = i % 4;
        int col = i / 4;
        iv.frame = CGRectMake(row * (60+5), col*(60+5), 60,60);
        [view addSubview:iv];
        iv.tag = i;
        [self.imageViews addObject:iv];
        iv.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [iv addGestureRecognizer:tapAction];
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    UIImageView *iv = (UIImageView *)tap.view;

    [PhotoBroswerVC show:[UIApplication sharedApplication].keyWindow.rootViewController type:PhotoBroswerVCTypeZoom index:iv.tag photoModelBlock:^NSArray *{
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:self.imageViews.count];
        
        
        for (NSUInteger i = 0; i< self.imageViews.count; i++) {
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            
            //NSString *path = self.imageViews[i];
            
            //设置查看大图的时候的图片地址
            //pbModel.image_HD_U = path;
            pbModel.image = [UIImage imageNamed:self.photos[i]];
            
            //源图片的frame
            UIImageView *imageV =self.imageViews[i];
            pbModel.sourceImageView = imageV;
            [modelsM addObject:pbModel];
        }
        return modelsM;
        
    }];
    
}


-(void)createProgressView:(NSString *)progress inView:(UIView*)view{

    UIView *progressView = UIView.new;
    CGFloat width = progress.floatValue == 1.0 ? 300 : progress.floatValue * 280;
    progressView.frame = CGRectMake(0, 0, width,31);
    progressView.backgroundColor = [UIColor darkGrayColor];
    [view addSubview:progressView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 280, 32)];
    label.text = [NSString stringWithFormat:@"%.0f%%",progress.floatValue * 100];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview: label];
}

@end

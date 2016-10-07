//
//  EditProfileController.m
//  Chuye
//
//  Created by Qinting on 16/8/21.
//  Copyright © 2016年 Qinting. All rights reserved.
//

#import "EditProfileController.h"
#import "QTPlaceholderLabelTextView.h"
#import "UIImage+Compose.h"
#import "UIView+Round.h"
#import "UserInfo.h"

@interface EditProfileController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIView *signView;

@property (weak, nonatomic) IBOutlet UIButton *maleBtn;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@end

@implementation EditProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改资料";
    self.tableView.separatorColor = [UIColor darkGrayColor];
    self.tableView.backgroundColor = [UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1.0];
    self.iconImageView.layer.cornerRadius = self.iconImageView.frame.size.width * 0.5;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedHeaderImage)];
    [self.iconImageView addGestureRecognizer:tap];
    
    UserModelDataWorksUser *user = self.userModel.data.Works.lastObject.User;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.headPhoto]];
    self.nameTF.text = user.nickname;
    QTPlaceholderLabelTextView *textView = [[QTPlaceholderLabelTextView alloc]init];
    [self.signView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    textView.placeholder = @"请输入您的签名";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存"
                                                                             style:UIBarButtonItemStylePlain target:self action:@selector(saveData)];
    
    [self.maleBtn setBackgroundImage:[UIImage imageNamed:@"common_button_big_blue_disable"] forState:UIControlStateSelected];
    [self.maleBtn setBackgroundImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
    [self.femaleBtn setBackgroundImage:[UIImage imageNamed:@"cloud7_login_btn"] forState:UIControlStateSelected];
    [self.femaleBtn setBackgroundImage:[UIImage imageNamed:@"none"] forState:UIControlStateNormal];
    [self.maleBtn setSelected:YES];
    [self.maleBtn circleImageWithCornerRadius:8.0 borderWidth:0.5 borderColor:[UIColor whiteColor]];
    [self.femaleBtn circleImageWithCornerRadius:8.0 borderWidth:0.5 borderColor:[UIColor whiteColor]];
}


- (IBAction)sexBtnClick:(UIButton *)sender {
    if(sender  != self.maleBtn){
        self.maleBtn.selected = NO;
        self.femaleBtn.selected = YES;
    }else{
        self.maleBtn.selected = YES;
        self.femaleBtn.selected = NO;
    }
}



-(void)saveData{
    [UserInfo sharedUserInfo].registerName = self.nameTF.text;
    [self.navigationController popViewControllerAnimated:YES ];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)selectedHeaderImage{
    UIImagePickerController *vc = [[UIImagePickerController alloc]init];
    vc.allowsEditing  =  YES;
    vc.delegate = self;
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //    NSLog(@"--%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //    self.iconImageView.image = [self compressOriginalImage:image toSize:CGSizeMake(50, 50)];
    //    压缩图片
    self.iconImageView.image = [UIImage compressOriginalImage:image toSize:CGSizeMake(50, 50)];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/header.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/header.png"];
    UIImage *image =  [UIImage imageWithContentsOfFile:imagePath];
    if(image){
        self.iconImageView.image = image;
    }else{
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.data.Works.lastObject.User.headPhoto]];
    }
}


@end

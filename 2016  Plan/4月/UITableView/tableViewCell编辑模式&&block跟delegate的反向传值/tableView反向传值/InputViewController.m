//
//  InputViewController.m
//  tableView反向传值
//
//  Created by tarena01 on 15/11/17.
//  Copyright (c) 2015年 tarena01. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()<UIAlertViewDelegate,UITextFieldDelegate>

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加城市";
    _cityTF.delegate = self;
   
    
    _cityTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入城市名"
                            attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor] }];
    
    _populationTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"请输入人口数"
                            attributes:@{ NSForegroundColorAttributeName : [UIColor greenColor] }];
}

- (IBAction)clickSaveBtn:(UIButton *)sender
{
    City* aCity = [[City alloc]init];
 
    aCity.cityName = _cityTF.text;
    aCity.population = [_populationTF.text integerValue];
    if (aCity.population <= 0) {
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请输入正确的数字" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        return;
    }
    
    self.returnCityBlock(aCity);
//    [self.delegate inputViewOController:self didReturnCity:aCity];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)editEndOnExit:(id)sender {
    
    [_cityTF resignFirstResponder];
    [_populationTF becomeFirstResponder];
}
- (IBAction)editChange:(UITextField*)sender {
    NSLog(@"输入的内容：%@",sender.text);
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if(buttonIndex == 0){
        self.populationTF.text = [alertView textFieldAtIndex:0].text;
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

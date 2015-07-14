//
//  JWAboutViewController.m
//  JXT
//
//  Created by 1039soft on 15/7/8.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWAboutViewController.h"

@interface JWAboutViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *banbenhao;//版本号
@property (weak, nonatomic) IBOutlet UIButton *checkup;

@end

@implementation JWAboutViewController
#warning 上架之后的app网址
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa /wa/viewContentsUserReviews?type=Purple+Software&id=com.1039soft.JXT"]];
    }

}

- (IBAction)tel:(UIButton *)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.1039.cn"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"关于我们";
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    _banbenhao.text = [infoDictionary objectForKey:@"CFBundleShortVersionString"];//获取版本号
    // Do any additional setup after loading the view from its nib.
    [_checkup.layer setBorderWidth:1];
    [_checkup.layer setBorderColor:[UIColor colorWithRed:11.0/255.0 green:96.0/255.0 blue:252.0/255.0 alpha:1].CGColor];
     [_checkup.layer setCornerRadius:10]; //设置矩圆角半径
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

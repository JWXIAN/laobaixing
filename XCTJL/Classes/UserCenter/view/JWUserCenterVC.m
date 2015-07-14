//
//  JWUserCenterVC.m
//  XCTJL
//
//  Created by 1039soft on 15/7/13.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWUserCenterVC.h"
#import "JWGetUserCenter.h"
#import "JWUpDataJSON.h"
#import "MBProgressHUD+MJ.h"
#import "JWAboutViewController.h"
#import "JWHelpVC.h"
@interface JWUserCenterVC ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headview;//用户头像
@property (weak, nonatomic) IBOutlet UILabel *IDcard;//身份证号
@property (weak, nonatomic) IBOutlet UILabel *mobilephone;//电话
@property (weak, nonatomic) IBOutlet UILabel *department;//部门
@property (weak, nonatomic) IBOutlet UILabel *carclass;//科目

@property(strong,nonatomic) NSString* upurl;//更新链接

@end

@implementation JWUserCenterVC
- (IBAction)change_phone_number:(UIButton *)sender {
    
}
//更换驾校
- (IBAction)changeschool:(UIButton *)sender {
    NSLog(@"1");
}
//检查更新
- (IBAction)checkUP:(UIButton *)sender {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [JWGetUserCenter checkUP: app_Version andCallback:^(id obj) {
        JWUpDataJSON* updata=obj;
        if (![updata.note isEqualToString:@"没有新更新！"]) {
            NSString* upa=[NSString stringWithFormat:@"有新版本（%@）是否更新",updata.versionCode];
            UIAlertView* _alertView = [[UIAlertView alloc]initWithTitle:@"更新" message:upa delegate:self cancelButtonTitle:@"更新" otherButtonTitles:@"取消", nil];
            _alertView.frame = CGRectMake(50, 200, 200, 50);
            _alertView.tag=0;
            [_alertView show];
            _upurl=updata.url;
        }
        else
        {
            [MBProgressHUD showError:@"没有更新"];
        }
    }];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==0) {
        if (buttonIndex==0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa /wa/viewContentsUserReviews?type=Purple+Software&id=%@",_upurl]
                                                        ]];
        }

       }
    if (alertView.tag==1) {
        if (buttonIndex==0)
        {
            
        }

    }
    }
//帮助
- (IBAction)canhelp:(UIButton *)sender {
    JWHelpVC* help=[[JWHelpVC alloc]init];
    [self.navigationController pushViewController:help animated:YES];
}
//退出
- (IBAction)exit:(UIButton *)sender {
    UIAlertView* _alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"是否退出程序！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    _alertView.frame = CGRectMake(50, 200, 200, 50);
    [_alertView show];
    
}
//关于
- (IBAction)aboutus:(UIButton *)sender {
    JWAboutViewController* about=[[JWAboutViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"用户中心";
    
    // Do any additional setup after loading the view from its nib.
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

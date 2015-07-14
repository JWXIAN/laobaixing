//
//  JWLoginController.m
//  JXT
//
//  Created by JWX on 15/6/24.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWLoginController.h"
#import "PrefixHeader.pch"
#import "JWDLTVController.h"
#import "MBProgressHUD+MJ.h"
#import "JWTarBarController.h"
#import "JiaoLAPI.h"
#import "JWTeacherInfo.h"
//#import "JWNoticeTVController.h"

@interface JWLoginController ()<UITextFieldDelegate>


/**驾校列表*/
- (IBAction)btnDrivList:(id)sender;

/**登录btn*/
- (IBAction)btnLogin:(id)sender;

/**身份证号*/
@property (weak, nonatomic) IBOutlet UITextField *tFNo;

/**密码*/
@property (weak, nonatomic) IBOutlet UITextField *tFPassword;
/**登录btn*/
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UILabel *drive_school_label;

@end


@implementation JWLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _drive_school_label.text=[ud objectForKey:@"drivename"];
    _tFNo.text=[ud objectForKey:@"accountID"];

    
}

//收键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//登录xib
- (id)init
{
    self = [super initWithNibName:@"JWLoginVC" bundle:nil];
    if (self) {
        // Something.
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**跳回选择驾校*/
- (IBAction)btnDrivList:(id)sender {
    JWDLTVController *tb = [[JWDLTVController alloc] init];
    [self presentViewController:tb animated:YES completion:nil];
}


/**登录按钮*/
- (IBAction)btnLogin:(id)sender {
    if(self.tFNo.text.length !=0 && self.tFPassword.text.length !=0)
    {
        [self StLogin];
    }else if (self.tFNo.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入编号"];
    }else if (self.tFPassword.text.length == 0)
    {
        [MBProgressHUD showError:@"请输入密码"];
    }
    
}

/**登录响应*/
- (void)StLogin
{
    [MBProgressHUD showMessage:@"正在拼命登录中..."];
    NSString *accountID = self.tFNo.text;
    NSString *password = self.tFPassword.text;
    NSDictionary* dic=@{@"Teacherid":accountID,@"password":password};
    [JiaoLAPI requsetStuLoginByStuLogin:dic andCallback:^(id obj) {
        JWTeacherInfo* teainfo =obj;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
       

        if ([teainfo.issuccess isEqualToString:@"true"]) {
            //隐藏蒙板
            [MBProgressHUD hideHUD];
           
            [ud setBool:YES forKey:@"issuccess"];
            //加载主界面
            JWTarBarController *tb = [[JWTarBarController alloc] init];
            [self presentViewController:tb animated:YES completion:nil];
            [MBProgressHUD showSuccess:@"登录成功"];
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"信息错误！"];
            [ud setBool:NO forKey:@"issuccess"];
        }
         [ud synchronize];
    }];
}


@end

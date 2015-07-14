
//
//  JiaxiaotongAPI.m
//  jiaxiaotong
//
//  Created by 1039soft on 15/5/17.
//  Copyright (c) 2015年 1039soft. All rights reserved.
//

#import "JiaoLAPI.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
@implementation JiaoLAPI



//教练登陆
+(void)requsetStuLoginByStuLogin:(NSDictionary *)info andCallback:(MyCallback)callback{
    NSUserDefaults* uu=[NSUserDefaults standardUserDefaults];
    NSString* school_id=[uu objectForKey:@"drivecode"];
    NSString* path=[NSString stringWithFormat:@"http://xy.1039.net:12345/drivingServcie/rest/driving_json/Default.ashx?methodName=GetJLUserAndPwd&SCHOOL_ID=%@&Teacherid=%@&password=%@",school_id,info[@"Teacherid"],info[@"password"]];
    
    AFHTTPRequestOperationManager *manager= [AFHTTPRequestOperationManager manager];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        callback(dic);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [MBProgressHUD showError:@"加载数据失败"];
    }];
}







@end

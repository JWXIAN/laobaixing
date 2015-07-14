//
//  JWGetUserCenter.m
//  XCTJL
//
//  Created by 1039soft on 15/7/13.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWGetUserCenter.h"
#import "AFNetworking.h"
#import "JWUpDataJSON.h"
#import "MBProgressHUD+MJ.h"
@implementation JWGetUserCenter
//检查更新
+(void)checkUP:(NSString *)VersionCode andCallback:(MyCallback)callback
{
    NSString *path =[NSString stringWithFormat:@"http://xy.1039.net:12345/drivingServcie/rest/driving_json/Default.ashx?methodName=checkVersion&VersionCode=%@&remark=IOS",VersionCode];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    [manger setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manger GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        JWUpDataJSON *upinfo = [JWUpDataJSON parserUserInfoByDictionary:dic];
        
        callback(upinfo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"加载数据失败"];
    }];

}
//修改手机号码
+(void)requsetChangedPhoneNumByChangedPhoneNum:(NSString *)changePhoneNum andCallback:(MyCallback)callback
{
    
}
@end

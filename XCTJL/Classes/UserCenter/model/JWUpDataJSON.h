//
//  JWUserCenterJSON.h
//  XCTJL
//
//  Created by 1039soft on 15/7/13.
//  Copyright (c) 2015年 JW. All rights reserved.
//{"head": {"issuccess": "true","statecode": "2000","stateinfo": "失败"},"body": {"state": "2","versionCode": "0","url": "","note": "没有新更新！"}}

#import <Foundation/Foundation.h>

@interface JWUpDataJSON : NSObject
@property(strong,nonatomic) NSDictionary* head;//数据头
@property(strong,nonatomic) NSDictionary* body;//数据体
@property(strong,nonatomic) NSString* issuccess;//请求是否成功   true
@property(strong,nonatomic) NSString* statecode;//请求是否成功    2000
@property(strong,nonatomic) NSString* stateinfo;//请求是否成功    成功
@property(strong,nonatomic) NSString* versionCode;//版本号
@property(strong,nonatomic) NSString*  url;//更新链接
@property(strong,nonatomic) NSString* note;//更新提示信息
+(JWUpDataJSON*)parserUserInfoByDictionary:(NSDictionary*)dic;
@end

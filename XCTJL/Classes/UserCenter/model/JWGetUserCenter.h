//
//  JWGetUserCenter.h
//  XCTJL
//
//  Created by 1039soft on 15/7/13.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWGetUserCenter : NSObject
typedef void  (^MyCallback)(id obj);
//检查更新
+(void)checkUP:(NSString *)VersionCode andCallback:(MyCallback)callback;
//修改手机号码
+(void)requsetChangedPhoneNumByChangedPhoneNum:(NSString *)changePhoneNum andCallback:(MyCallback)callback;
@end

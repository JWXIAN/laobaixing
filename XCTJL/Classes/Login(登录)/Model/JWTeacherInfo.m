//
//  JWTeacherInfo.m
//  XCTJL
//
//  Created by 1039soft on 15/7/14.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWTeacherInfo.h"

@implementation JWTeacherInfo
+(JWTeacherInfo*)teacherinfo:(NSDictionary*)dic
{
    JWTeacherInfo* jw=[[JWTeacherInfo alloc]init];
    jw.head=dic[@"head"];
    jw.body=dic[@"body"];
    jw.issuccess=jw.head[@"issuccess"];
    jw.statecode=jw.head[@"statecode"];
    jw.stateinfo=jw.head[@"stateinfo"];
    jw.name=jw.body[@"name"];
    jw.password=jw.body[@"password"];
    jw.mobile=jw.body[@"mobile"];
    jw.cid=jw.body[@"cid"];
    jw.photo=jw.body[@"photo"];
    jw.type_name=jw.body[@"type_name"];
    jw.carcode=jw.body[@"carcode"];
    jw.department=jw.body[@"department"];
    return jw;
}
@end

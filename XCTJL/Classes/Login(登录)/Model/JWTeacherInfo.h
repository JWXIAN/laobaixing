//
//  JWTeacherInfo.h
//  XCTJL
//
//  Created by 1039soft on 15/7/14.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWTeacherInfo : NSObject
@property(strong,nonatomic) NSDictionary* head;
@property(strong,nonatomic) NSDictionary* body;
@property(strong,nonatomic) NSString* issuccess;
@property(strong,nonatomic) NSString*  statecode;
@property(strong,nonatomic) NSString* stateinfo;//成功信息
@property(strong,nonatomic) NSString* name;//名字
@property(strong,nonatomic) NSString* password;//密码
@property(strong,nonatomic) NSString* mobile;//手机号
@property(strong,nonatomic) NSString* cid;//身份证号
@property(strong,nonatomic) NSString* photo;//照片
@property(strong,nonatomic) NSString* type_name;//学科名字
@property(strong,nonatomic) NSString* carcode;//车号
@property(strong,nonatomic) NSString* department;//部门编号
+(JWTeacherInfo*)teacherinfo:(NSDictionary*)dic;
@end


//
//  JWTarBarController.m
//  JXT
//
//  Created by JWX on 15/6/19.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWTarBarController.h"
#import "JWTTVC.h"
#import "JWCarCodeTV.h"
#import "JWProfile.h"
#import "JWStudentTV.h"
#import "PrefixHeader.pch"
#import "JWNavController.h"
#import "JWCountVC.h"


@interface JWTarBarController ()


@end

@implementation JWTarBarController


- (void)viewDidLoad {
    [super viewDidLoad];
//    // 1.初始化子控制器
    
//    UIStoryboard *stor=[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
//    UIViewController *myinfo = [stor instantiateViewControllerWithIdentifier:@"myinfo"];
//    [self addChildVc:myinfo title:@"上车认证" image:@"xinxi" selectedImage:@"xinxi-on"];
    
    JWCarCodeTV *carCode = [[JWCarCodeTV alloc] init];
    [self addChildVc:carCode title:@"上车认证" image:@"tabbar_profile" selectedImage:nil];
    
    JWTTVC *timeTable = [[JWTTVC alloc] init];
    [self addChildVc:timeTable title:@"我的课表" image:@"tabbar_profile" selectedImage:nil];
    
    JWStudentTV *student = [[JWStudentTV alloc] init];
    [self addChildVc:student title:@"我的学员" image:@"tabbar_profile" selectedImage:nil];
    
    JWCountVC *profile = [[JWCountVC alloc] init];
    [self addChildVc:profile title:@"我的统计" image:@"tabbar_profile" selectedImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片JWColor(36, 107, 246)
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = JWColor(67, 153, 213);
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    JWNavController *nav = [[JWNavController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}
@end

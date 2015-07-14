//
//  JWNavController.m
//  JXT
//
//  Created by JWX on 15/6/19.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWNavController.h"
#import "PrefixHeader.pch"
#import "UIBarButtonItem+Extension.h"
#import "JWUserCenterVC.h"
@interface JWNavController ()

@end

@implementation JWNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = JWColor(67, 153, 213);
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.navigationBar.titleTextAttributes = textAttrs;
    self.navigationBar.tintColor = [UIColor whiteColor];
    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)initialize
{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置普通状态JWColor(36, 107, 246);
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = JWColor(36, 107, 246);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];

    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}
/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count == 0) {
        // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        //自定义navBar左右按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(notice) image:@"tabbar_message_center_selected" highImage:nil];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_pop_highlighted" highImage:nil];
//
//    }else{
//        viewController.hidesBottomBarWhenPushed = YES;
//        //设置导航栏上面的内容
//        //设置左边的返回按钮
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"navigationbar_back" highImage:nil];
//        //
        //        // 设置右边的更多按钮
        //        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
    }
    
    [super pushViewController:viewController animated:animated];
}

/**公告*/
- (void)notice
{
    
}
/**更多*/
- (void)more
{
    JWUserCenterVC* usercenter=[[JWUserCenterVC alloc]initWithNibName:@"JWUserCenterVC" bundle:nil];
    [self pushViewController:usercenter animated:YES];
}

////navbar返回
//- (void)back
//{
//    [self popViewControllerAnimated:YES];
//}
//
//- (void)more
//{
//    [self popToRootViewControllerAnimated:YES];
//}
@end


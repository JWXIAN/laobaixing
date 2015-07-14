//
//  JWCarCodeTV.m
//  XCTJL
//
//  Created by JWX on 15/7/13.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWCarCodeTV.h"
#import "JWTestVC.h"
#import "JWCarCodeCell.h"

@interface JWCarCodeTV ()

@end

@implementation JWCarCodeTV

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 150;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    JWCarCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JWCarCodeCell" owner:self options:nil] lastObject];;
    }
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWTestVC *test1 = [[JWTestVC alloc] init];
    test1.title = @"测试1控制器";
    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    //    test1.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:test1 animated:YES];
}


@end

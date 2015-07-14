//
//  JWDLTVController.m
//  JXT
//
//  Created by JWX on 15/6/21.
//  Copyright (c) 2015年 JW. All rights reserved.
//

#import "JWDLTVController.h"
#import "JiaoLAPI.h"
#import "AFNetworking.h"
#import "JWDriveBodyModel.h"
#import "JWDriveHeadModel.h"
#import "JWDLTVCell.h"
#import "JWTarBarController.h"
#import "MBProgressHUD+MJ.h"
#import "JWLoginController.h"
#import "MBProgressHUD+MJ.h"
#import "PrefixHeader.pch"

@interface JWDLTVController () <UISearchResultsUpdating>
/**存放驾校数据*/
@property (nonatomic,strong)NSMutableArray *driveHeads;

//@property (nonatomic, retain) NSMutableArray *allDataArray;                     // 存放所有数据的数组
@property (nonatomic, strong) NSMutableArray *searchResultDataArray;            // 存放搜索出结果的数组

@property (nonatomic, strong) UISearchController *searchController;             // 搜索控制器
@property (nonatomic, strong) UITableViewController *searchTVC;                 // 搜索使用的tv控制器

@end

@implementation JWDLTVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 110;
//    self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self loadViews];
    [self loadData];
}

/**当视图加载后*/
//- (void)viewWillAppear:(BOOL)animated
//{
//    [self searchBarButtonItemAction];
//}

/**tv顶部加载搜索按钮*/
- (void)loadViews
{
    // 搜索按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
//    [but setTitle:@"点击搜索驾校" forState:UIControlStateNormal];
//    [but setBackgroundImage:[UIImage imageNamed:@"SearchBar-1"] forState:UIControlStateNormal];
    [but setTitle:@"点击搜索驾校" forState:UIControlStateNormal];
    [but setTintColor:[UIColor whiteColor]];
//    [but setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    but.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);

    self.tableView.tableHeaderView = but;
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 60);
    self.tableView.tableHeaderView.backgroundColor = JWColor(88, 170, 236);
    [but addTarget:self action:@selector(searchBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
//    // 编辑按钮
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**加载驾校数据*/
- (void)loadData
{
    self.driveHeads = [NSMutableArray array];
    self.searchResultDataArray = [NSMutableArray array];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *uid = [ud objectForKey:@"driveID"];
    [JiaoLAPI requestDriveByDriveID:uid andCallback:^(id obj) {
        JWDriveHeadModel *drive = (JWDriveHeadModel *)obj;
        if (drive != nil) {
            self.driveHeads = drive.driveHeads;
            self.searchResultDataArray = drive.driveHeads;
            [self.tableView reloadData];
        }
    }];
    
}

#pragma mark 搜索按钮事件（点击搜索按钮，推出搜索控制器）
- (void)searchBarButtonItemAction
{
    // 创建出搜索使用的表示图控制器
    self.searchTVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    _searchTVC.tableView.dataSource = self;
    _searchTVC.tableView.delegate = self;
    self.searchTVC.tableView.rowHeight = 110;
    // 使用表示图控制器创建出搜索控制器
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:_searchTVC];
    // 搜索框检测代理
    //（这个需要遵守的协议是 <UISearchResultsUpdating> ，这个协议中只有一个方法，当搜索框中的值发生变化的时候，代理方法就会被调用）
    _searchController.searchResultsUpdater = self;
    _searchController.searchBar.placeholder = @"搜索驾校名称、编号或地区";
    _searchController.searchBar.prompt = @"搜索驾校信息";
    
    // 因为搜索是控制器，所以要使用模态推出（必须是模态，不可是push）
    [self presentViewController:_searchController animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (tableView == self.tableView ? self.driveHeads.count : _searchResultDataArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    JWDLTVCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell== nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JWDLTVCell" owner:self options:nil]lastObject];
    }
    if(tableView == self.tableView){
        cell.driveData = self.driveHeads[indexPath.row];
    }else{
        cell.driveData = self.searchResultDataArray[indexPath.row];
    }
    return cell;
}

//#pragma mark - UITableViewDelegate Methods
//#pragma mark 处理cell的点击事件
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 获取到点击的模型
//    Student *stu = (tableView == self.tableView ? _allDataArray[indexPath.row] : _searchResultDataArray[indexPath.row]);
//    
//    // 弹出AlertView显示
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"测试" message:[NSString stringWithFormat:@"姓名：%@ \n电话：%@ \n性别：%@", stu.name, stu.phoneNumber, stu.gender] preferredStyle:UIAlertControllerStyleAlert];
//    
//    // 添加关闭按钮
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        
//    }];
//    [alertController addAction:cancelAction];
//    
//    // 在搜索结果的tableView中，需要使用_searchTVC来推出提示框，否则使用self即可
//    UIViewController *currentVC = tableView == self.tableView ? self : _searchTVC;
//    
//    // 推出提示框
//    [currentVC presentViewController:alertController animated:YES completion:nil];
//}


#pragma mark - 设置是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - 设置编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
#pragma mark - 处理编辑情况
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 设置滑动显示出的按钮 - 备用
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 置顶按钮
//    UITableViewRowAction *layTopRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"置顶" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        NSLog(@"点击了置顶");
//        
//        [tableView setEditing:NO animated:YES];
//    }];
//    layTopRowAction.backgroundColor = [UIColor redColor];
//    
//    // 标记
//    UITableViewRowAction *markRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标记" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        NSLog(@"测试测试");
//        
//        [tableView setEditing:NO animated:YES];
//    }];
//    markRowAction.backgroundColor = [UIColor greenColor];
//    
//    
//    // 更多按钮
//    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"更多" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        
//        NSLog(@"点击更多");
//        
//        [tableView setEditing:NO animated:YES];
//    }];
//    moreRowAction.backgroundColor = [UIColor darkGrayColor];
//    
//    // 返回编辑按钮
//    return @[layTopRowAction, markRowAction, moreRowAction];
//}
#pragma mark - UISearchResultsUpdating Method
#pragma mark 监听者搜索框中的值的变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 1. 获取输入的值
    NSString *conditionStr = searchController.searchBar.text;

    // 2. 创建谓词，准备进行判断的工具
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.phoneNumber CONTAINS [CD] %@ OR self.name CONTAINS [CD] %@ OR self.gender CONTAINS [CD] %@", conditionStr, conditionStr, conditionStr];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.qyname CONTAINS [CD] %@ OR self.qyid CONTAINS [CD] %@ OR self.shengfen CONTAINS [CD] %@ OR self.shiqu CONTAINS [CD] %@", conditionStr, conditionStr, conditionStr, conditionStr];
    
    // 3. 使用工具获取匹配出的结果
    self.searchResultDataArray = [NSMutableArray arrayWithArray:[_driveHeads filteredArrayUsingPredicate:predicate]];
    
    // 4. 刷新页面，将结果显示出来
    [_searchTVC.tableView reloadData];
}

#pragma mark - 选择后跳转到登陆页面 将驾校名传到登陆页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JWLoginController *tb = [[JWLoginController alloc] init];
    JWDriveBodyModel *driveData = tableView == self.tableView ? self.driveHeads[indexPath.row] : self.searchResultDataArray[indexPath.row];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:driveData.qyid forKey:@"drivecode"];
    [ud setObject:driveData.qyname forKey:@"drivename"];
    [ud synchronize];
    tb.driveData = driveData;
    if(tableView == self.tableView){
        [self presentViewController:tb animated:YES completion:nil];
    }else{
        [_searchTVC presentViewController:tb animated:YES completion:nil];
    }
}

@end

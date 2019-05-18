//
//  SHHomeTableViewController.m
//  WeiBoDemo2
//  方案一：MVC 将请求到的数据转换为数据模型，赋值到cell中
//
//  方案二：MVVM 请求的数据转化为视图模型（计算视图的大小，并赋值）
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  TODO: BUG：1.部分text没有换行显示，2.图片显示区域没有按实际数量显示，默认占据9张图的位置。3. TabBar 文字显示在 IphoneXs 上异常。

#import "SHHomeTableViewController.h"

#import "UIBarButtonItem+SHBarButton.h"

#import "SHSubViewController.h"
#import "SHStatusFrame.h"
#import "SHStatusTool.h"
#import "SHBlogTableCell.h"

#import <MJRefresh.h>

@interface SHHomeTableViewController ()

@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation SHHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航栏
    [self setupNavigationBar];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestStatus)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
}

- (NSMutableArray *)statusFrames {
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SHBlogTableCell *cell = [SHBlogTableCell blogTableCellWithTableView:tableView];
    SHStatusFrame *frame = self.statusFrames[indexPath.row];
    cell.statusFrame = frame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SHStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHight;
}

#pragma mark - Navigation

- (void)setupNavigationBar {
    // title
    self.navigationItem.title = @"首页";
    // left
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed: @"navigationbar_friendsearch"] hightImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(searchFriend) forControllEvents:UIControlEventTouchUpInside];
    
    // right
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed: @"navigationbar_pop"] hightImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(navigationBar_pop) forControllEvents:UIControlEventTouchUpInside];
    
}

- (void)searchFriend {
    NSLog(@"-- 查询好友 -- ");
}

- (void)navigationBar_pop {
    SHSubViewController *subVC = [SHSubViewController new];
    subVC.view.backgroundColor = [UIColor orangeColor];
    //subVC.hidesBottomBarWhenPushed = NO; 未生效：TabBarController
    
    [self.navigationController pushViewController:subVC animated:YES];
}

#pragma mark - 微博数据
- (void)requestStatus {
    // 将微博数据请求抽取剥离到工具类
    // 处理微博标识
    NSString *sinceId = nil;
    if (self.statusFrames.count) {
        SHStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
    }
    
    [SHStatusTool newStatusWithSinceId:sinceId success:^(NSArray * _Nonnull statuses) {
        // 结束刷新控件
        [self.tableView.mj_header endRefreshing];
        
        // 模型转换
        NSMutableArray *statusFrame = [NSMutableArray array];
        for (SHStatus *status in statuses) {
            SHStatusFrame *sf = [SHStatusFrame new];
            sf.status = status;
            [statusFrame addObject:sf];
        }
        // 将新数据插入到最前
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusFrames insertObjects:statusFrame atIndexes:indexSet];
        
        // 刷新表格数据
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull err) {
        NSLog(@"微博数据异常");
    }];
}

- (void)loadMoreStatus {
    
}
@end

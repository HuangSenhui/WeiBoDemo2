//
//  SHHomeTableViewController.m
//  WeiBoDemo2
//  方案一：MVC 将请求到的数据转换为数据模型，赋值到cell中
//
//  方案二：MVVM 请求的数据转化为视图模型（计算视图的大小，并赋值）
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  TODO: BUG：1.部分text没有换行显示，2.图片显示区域没有按实际数量显示，默认占据9张图的位置。3. TabBar 文字显示在 IphoneXs 上异常。- 2019.05.19

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
    //[self.tableView.mj_header beginRefreshing];   // 进入页面自动刷新
    
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
    // 处理微博标识idstr 可以用来区分最是否为数据
    NSString *sinceId = nil;
    if (self.statusFrames.count) {
        SHStatus *status = [self.statusFrames[0] status];
        sinceId = status.idstr;
    }
    
    [SHStatusTool newStatusWithSinceId:sinceId success:^(NSArray * _Nonnull statuses) {
        // 结束刷新控件
        [self.tableView.mj_header endRefreshing];
        // 展示提示条
        [self showStatusCount:(int)statuses.count];
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
    } failure:^(NSError *err) {
        
        NSLog(@"服务器数据出错");
    }];
}

// 加载更多数据
- (void)loadMoreStatus {
    NSString *max_id = nil;
    if (self.statusFrames.count) {
        SHStatus *status = [[self.statusFrames lastObject] status];
        long maxid = [status.idstr longLongValue] - 1;  // 去掉请求重复数据
        max_id = [NSString stringWithFormat:@"%ld",maxid];
    }
    
    [SHStatusTool moreStatusWithMaxId:max_id success:^(NSArray *statuses) {
        // 结束上拉刷新
        [self.tableView.mj_footer endRefreshing];
        
        for (SHStatus *status in statuses) {
            SHStatusFrame *sFrame = [[SHStatusFrame alloc] init];
            sFrame.status = status;
            [self.statusFrames addObject:sFrame];
        }
        
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull err) {
        NSLog(@"服务器数据出错");
    }];
}

#pragma mark - 微博刷新提示条
-(void)showStatusCount:(int)count {
    CGFloat barH = 35;
    
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - barH;
    CGFloat w = self.view.bounds.size.width;
    CGFloat h = barH;
    
    UILabel *label = [[UILabel alloc] init];
    label.frame =  CGRectMake(x, y, w, h);
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (count) {    // 有新数据
        label.text = [NSString stringWithFormat:@"更新%d条微博",count];
    } else {        // 没有新数据
        label.font = [UIFont systemFontOfSize:12];
        label.text = [NSString stringWithFormat:@"暂时没有数据了..."];
    };
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画往下面平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, barH);
        
    } completion:^(BOOL finished) {
        // 下移动画完成后，往上面平移
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}
@end

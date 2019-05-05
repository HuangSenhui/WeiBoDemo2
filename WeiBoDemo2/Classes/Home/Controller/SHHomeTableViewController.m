//
//  SHHomeTableViewController.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHHomeTableViewController.h"

#import "UIBarButtonItem+SHBarButton.h"

#import "SHSubViewController.h"

@interface SHHomeTableViewController ()

@end

@implementation SHHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏
    [self setupNavigationBar];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


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
@end

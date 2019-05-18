//
//  SHTabBarController.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHTabBarController.h"

#import "SHHomeTableViewController.h"
#import "SHDiscoverViewController.h"
#import "SHMessageViewController.h"
#import "SHProfileViewController.h"

#import "SHNavigationController.h"
#import "SHTabBar.h"

@interface SHTabBarController ()

@property (nonatomic,weak) SHHomeTableViewController    *home;
@property (nonatomic,weak) SHMessageViewController      *message;
@property (nonatomic,weak) SHDiscoverViewController     *discover;
@property (nonatomic,weak) SHProfileViewController      *profile;

@end

@implementation SHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加子界面控制器：home、message、discover、profile
    [self setupViewControllers];
    
    // 设置TabBar
    [self setupTabBar];
}

#pragma mark - 添加子控制器
-(void) setupViewControllers {
    // 首页 tableViewController
    SHHomeTableViewController *home = [SHHomeTableViewController new];
    [self setupChildViewController:home title:@"主页" imgName:@"tabbar_home" selectedImgName:@"tabbar_home_selected"];
    _home = home;
    
    // 消息
    SHMessageViewController *message = [SHMessageViewController new];
    [self setupChildViewController:message title:@"信息" imgName:@"tabbar_message_center" selectedImgName:@"tabbar_message_center_selected"];
    _message = message;
    
    // 发现
    SHDiscoverViewController *discover = [SHDiscoverViewController new];
    [self setupChildViewController:discover title:@"发现" imgName:@"tabbar_discover" selectedImgName:@"tabbar_discover_selected"];
    _discover = discover;
    
    // 我
    SHProfileViewController *profile = [SHProfileViewController new];
    [self setupChildViewController:profile title:@"我" imgName:@"tabbar_profile" selectedImgName:@"tabbar_profile_selected"];
    _profile = profile;
}

-(void) setupChildViewController:(UIViewController *)vc title:(NSString *)title imgName:(NSString *)imageName selectedImgName:(NSString *)selectedIamgeName {
    vc.tabBarItem.title = title;
    // 使用原图显示
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedIamgeName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 去掉默认按钮颜色渲染
    NSMutableDictionary *titleAttr = [NSMutableDictionary new];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [vc.tabBarItem setTitleTextAttributes:titleAttr forState:UIControlStateSelected];
    
    SHNavigationController *navi = [[SHNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:navi];
}

#pragma mark - 设置tabBar
-(void)setupTabBar {
    SHTabBar *tabBar = [[SHTabBar alloc] initWithFrame:self.tabBar.frame];
    [self setValue:tabBar forKey:@"tabBar"];
}

@end

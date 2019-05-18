//
//  SHNavigationController.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/4.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHNavigationController.h"

#import "UIBarButtonItem+SHBarButton.h"

@interface SHNavigationController () <UINavigationControllerDelegate>

@property (nonatomic,strong) id popDelegate;

@end

@implementation SHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 遵从代理 实现手势滑动返回
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

// 去掉默认样式
+(void)initialize {
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *titleAttr = [NSMutableDictionary new];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

// 当有视图入栈时，设置器导航栏样式
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 非根视图
    if (self.childViewControllers.count) {
        // 隐藏底部tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        // left
        UIBarButtonItem *leftBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] hightImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControllEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftBtn;
        
        // right
        UIBarButtonItem *rightBtn = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] hightImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControllEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = rightBtn;
        
    }
    [super pushViewController:viewController animated:animated];
}
// 返回上一个视图
-(void)backToPre {
    [self popViewControllerAnimated:YES];
}

// 返回根视图
-(void)backToRoot {
    [self popToRootViewControllerAnimated:YES];
}

// TODO: 当前项目结构：子界面都不显示tabBarController,所以此处编码可优化
// 1. 当前：UIWindow -> TabBarController -> 多个NavigationController
// 2. 优化：UIWindow -> NavigationController -> TabBarController -> 多个ViewController
// 滑动返回手势
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    } else {
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

@end

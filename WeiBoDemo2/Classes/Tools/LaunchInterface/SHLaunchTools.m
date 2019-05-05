//
//  SHLaunchTools.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHLaunchTools.h"

#import "SHTabBarController.h"
#import "SHNewFeatrureController.h"
#import "SHOAuthController.h"
#import "SHAccountTools.h"

@implementation SHLaunchTools

+ (void)launchFirstControllerWithWindow:(UIWindow *)window {
    
    SHTabBarController *tabBarController = [SHTabBarController new];
    SHNewFeatrureController *newFeatureController = [SHNewFeatrureController new];
    
    // 验证是否为新版本
    // 获取当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 获取上个版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 校验是否已授权
        if ([SHAccountTools account]) {
            window.rootViewController = tabBarController;
        } else {
            SHOAuthController *oauthController = [[SHOAuthController alloc] init];
            window.rootViewController = oauthController;
        }
    } else {
        window.rootViewController = newFeatureController;
        // 将新版本号保存
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"CFBundleVersion"];
    }
}

@end

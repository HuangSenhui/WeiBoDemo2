//
//  SHLaunchTools.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHLaunchTools : NSObject

/**
 * 应用启动第一视图
 */
+ (void)launchFirstControllerWithWindow:(UIWindow *)window;

@end

NS_ASSUME_NONNULL_END

//
//  SHTabBar.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol SHTabBarDelegate;
@class SHTabBar;
@protocol SHTabBarDelegate <NSObject,UITabBarDelegate>

@optional
- (void)tabBar:(UITabBar *)tabBar didClickPlusButton:(UIButton *)button;    // TODO:也许还需要获取按钮本身的属性 进行一些操作。 后续优化

@end

@interface SHTabBar : UITabBar

@property (nonatomic,weak) id<SHTabBarDelegate> delegate;

@end



NS_ASSUME_NONNULL_END

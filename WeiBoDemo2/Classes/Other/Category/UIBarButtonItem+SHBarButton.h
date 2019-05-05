//
//  UIBarButtonItem+SHBarButton.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (SHBarButton)

/**
 * 初始化自定义barButtonItem,返回带自定义图片的barButtonItem
 */
+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action forControllEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END

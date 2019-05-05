//
//  UIBarButtonItem+SHBarButton.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "UIBarButtonItem+SHBarButton.h"

@implementation UIBarButtonItem (SHBarButton)

+(UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image hightImage:(UIImage *)hightImage target:(id)target action:(SEL)action forControllEvents:(UIControlEvents)controlEvents {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:hightImage forState:UIControlStateHighlighted];
    
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end

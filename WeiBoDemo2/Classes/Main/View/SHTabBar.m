//
//  SHTabBar.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHTabBar.h"

@interface SHTabBar()

@property (nonatomic,weak) UIButton *button;

@end

@implementation SHTabBar

-(UIButton *)button {
    if (_button == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateSelected];
        
        [btn sizeToFit];
        
        _button = btn;
        [self addSubview:_button];
    }
    return _button;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat supFrameW = self.bounds.size.width;
    // 适配iPhoneX
    CGFloat supFrameH = 48; // self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = supFrameW / (self.items.count + 1);
    CGFloat btnH = supFrameH;
    
    int i = 0;
    for (UIView *barButton in self.subviews) {
        if ([barButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) i = 3;
            btnX = i * btnW;
            barButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
        }
    }
    
    self.button.center = CGPointMake(supFrameW / 2, supFrameH / 2);
}

@end

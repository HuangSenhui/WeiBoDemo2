//
//  SHNewFeatureCell.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHNewFeatureCell.h"

#import "SHAccountTools.h"
#import "SHLaunchTools.h"

@interface SHNewFeatureCell()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic,weak) UIButton *startButton;
@property (nonatomic,weak) UIButton *shareButton;

@end

@implementation SHNewFeatureCell

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = _image;
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [UIImageView new];
        _imageView = imageView;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)startButton {
    if (_startButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"进入微博" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        
        [button sizeToFit];
        [button addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _startButton = button;
    }
    return _startButton;
}

- (UIButton *)shareButton {
    if (_shareButton == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"分享给大家" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button sizeToFit];
        [button addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        _shareButton = button;
    }
    return _shareButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.frame = self.bounds; // 全屏显示
    
    // 分享
    self.shareButton.center = CGPointMake(self.bounds.size.width * 0.5 - 5, self.bounds.size.height - 180);
    
    // 进入微博
    self.startButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height - 130);
}

// 进入主界面
- (void)start {
    //SHTabBarController *tabBarController = [SHTabBarController new];
   
    [SHLaunchTools launchFirstControllerWithWindow:[UIApplication sharedApplication].keyWindow];
 
    //[UIApplication sharedApplication].keyWindow.rootViewController = tabBarController;
}

// 分享   // TODO: 单选按钮应该还有更好的方法
BOOL flage = NO;
- (void)share {
    if (flage) {
        flage = NO;
        [_shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    } else {
        flage = YES;
        [_shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count {
    // 最后一页显示按钮，否则不显示
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    } else {
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

@end

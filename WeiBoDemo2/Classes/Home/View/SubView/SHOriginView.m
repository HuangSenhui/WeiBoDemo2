//
//  SHOriginView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHOriginView.h"

#import "SHStatusFrame.h"
#import "SHStatus.h"
#import "SHUser.h"
#import "SHPhotosView.h"

#import "UIImageView+WebCache.h"

@interface SHOriginView()

@property (nonatomic,weak) UIImageView *iconView;   // 头像
@property (nonatomic,weak) UILabel *nameView;       // 昵称
@property (nonatomic,weak) UIImageView *vipView;    // 等级
@property (nonatomic,weak) UILabel *timeView;       // 时间
@property (nonatomic,weak) UILabel *sourceView;     // 来源
@property (nonatomic,weak) UILabel *textView;       // 正文
@property (nonatomic,weak) SHPhotosView *photoView; // 图片

@end

@implementation SHOriginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 子控件
        [self setupSubViews];
        //
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupSubViews {
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = [UIFont systemFontOfSize:14];
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = [UIFont systemFontOfSize:12];
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = [UIFont systemFontOfSize:12];
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.numberOfLines = 0;
    //textView.adjustsFontSizeToFitWidth = YES; // 文字适应视图大小
    [self addSubview:textView];
    _textView = textView;
    
//    // 配图
    SHPhotosView *photosView = [[SHPhotosView alloc] init];
    [self addSubview:photosView];
    _photoView = photosView;
}

- (void)setStatusFrame:(SHStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    // frame
    [self setupFrame];
    // data
    [self setupData];
}
- (void)setupFrame {
    // 头像
    _iconView.frame = _statusFrame.originalIconFrame;
    
    // 昵称
    _nameView.frame = _statusFrame.originalNameFrame;
    
    // vip
    if (_statusFrame.status.user.vip) { // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    }else{
        _vipView.hidden = YES;
        
    }
    
    // 时间 每次有新的时间都需要计算时间frame
    SHStatus *status = _statusFrame.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY( _nameView.frame) + 10 * 0.5;
    CGSize timeSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _timeView.frame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + 10;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    _textView.frame = _statusFrame.originalTextFrame;
    
    // 配图
    _photoView.frame = _statusFrame.originalPhotosFrame;
}
- (void)setupData {
    SHStatus *status = _statusFrame.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
    
    // 配图
    _photoView.pic_urls = status.pic_urls;
}

@end

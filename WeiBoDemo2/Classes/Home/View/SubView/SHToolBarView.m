//
//  SHToolBarView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHToolBarView.h"

#import "SHStatus.h"

@interface SHToolBarView()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *divideVs; //分割线

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end

@implementation SHToolBarView

- (NSMutableArray *)buttons {
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)divideVs {
    if (_divideVs == nil) {
        _divideVs = [NSMutableArray array];
    }
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置子控件
        [self setupSubViews];
        // 设置view
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"timeline_card_bottom_background"];
    }
    
    return self;
}

- (void)setupSubViews {
    // 转发
    UIButton *retweet = [self setupButtonWithTitle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    // 评论
    UIButton *comment = [self setupButtonWithTitle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    // 赞
    UIButton *unlike = [self setupButtonWithTitle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
//    for (int i = 0; i < 2; i++) {
//        UIImageView *divideV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
//        [self addSubview:divideV];
//        [self.divideVs addObject:divideV];
//    }
}
- (UIButton *)setupButtonWithTitle:(NSString *)title image:(UIImage *)image {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.buttons addObject:btn];
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSUInteger count = self.buttons.count;
    
//    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width / count;
    CGFloat h = self.frame.size.height;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.buttons[i];
        btn.frame = CGRectMake(w * i, y, w, h);
    }
    
    // 设置分割线
}

- (void)setStatus:(SHStatus *)status {
    _status = status;
    // 转发
    [self setupButtonItem:_retweet title:status.reposts_count];
    // 评论
    [self setupButtonItem:_comment title:status.comments_count];
    // 点赞
    [self setupButtonItem:_unlike title:status.attitudes_count];
}

- (void)setupButtonItem:(UIButton *)button title:(int)count {
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        } else {
            title = [NSString stringWithFormat:@"%d",count];
        }
    }
    [button setTitle:title forState:UIControlStateNormal];
}

@end

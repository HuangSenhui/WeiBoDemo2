//
//  SHRetweetView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHRetweetView.h"

#import "SHStatusFrame.h"
#import "SHPhotosView.h"

@interface SHRetweetView ()

@property (nonatomic,weak) UILabel *nameView;       // 昵称
@property (nonatomic,weak) UILabel *textView;       // 正文
@property (nonatomic,weak) SHPhotosView *imgView;   // 配图

@end

@implementation SHRetweetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 添加子控件
        [self setupSubViews];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return self;
}

- (void)setupSubViews {
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.textColor = [UIColor blueColor];
    nameView.font = [UIFont systemFontOfSize:14];
    [self addSubview:nameView];
    _nameView = nameView;
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = [UIFont systemFontOfSize:14];
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    SHPhotosView *imgView = [[SHPhotosView alloc] init];
    [self addSubview:imgView];
    _imgView = imgView;
}

- (void)setStatusFrame:(SHStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    SHStatus *status = statusFrame.status;
    
    _nameView.frame = statusFrame.retweetNameFrame;
    _nameView.text = status.retweetName;
    
    _textView.frame = statusFrame.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
    
    _imgView.frame = statusFrame.retweetPhotosFrame;
    _imgView.pic_urls = status.retweeted_status.pic_urls;
}
@end

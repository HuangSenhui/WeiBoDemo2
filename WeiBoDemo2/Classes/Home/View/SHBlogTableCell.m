//
//  SHBlogTableCell.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHBlogTableCell.h"

#import "SHStatusFrame.h"
#import "SHStatus.h"

#import "SHOriginView.h"
#import "SHToolBarView.h"
#import "SHRetweetView.h"

#import <UIImageView+WebCache.h>

#define blogCellID @"blogCell"

@interface SHBlogTableCell ()

@property (nonatomic,weak) SHOriginView *originView;
@property (nonatomic,weak) SHToolBarView *toolBarView;
@property (nonatomic,weak) SHRetweetView *retweetView;


@end

@implementation SHBlogTableCell

- (void)setStatusFrame:(SHStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    // 原创
    _originView.frame = statusFrame.originalViewFrame;
    _originView.statusFrame = statusFrame;
    
    // 转发
    if (statusFrame.status.retweeted_status) {
        _retweetView.frame = statusFrame.retweetViewFrame;
        _retweetView.statusFrame = statusFrame;
        _retweetView.hidden = NO;
    } else {
        _retweetView.hidden = YES;
    }
    
    // 工具
    _toolBarView.frame = statusFrame.toolBarFrame;
    _toolBarView.status = statusFrame.status;
}

+ (instancetype) blogTableCellWithTableView:(UITableView *)tableView {
    SHBlogTableCell *cell = [tableView dequeueReusableCellWithIdentifier:blogCellID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blogCellID];
    }
    return cell;
}
// 重写构造方法 初始化自定义cell 视图
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 添加子控制器
        [self setupSubViews];
        // 设置背景色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setupSubViews {
    // 微博
    SHOriginView *originView = [[SHOriginView alloc] init];
    [self addSubview:originView];
    _originView = originView;
    
    // 转发
    SHRetweetView *retweetView = [[SHRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具
    SHToolBarView *toolBarView = [[SHToolBarView alloc] init];
    [self addSubview:toolBarView];
    _toolBarView = toolBarView;
}

@end

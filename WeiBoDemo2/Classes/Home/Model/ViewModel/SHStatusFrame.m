//
//  SHStatusFrame.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  

#import "SHStatusFrame.h"

@implementation SHStatusFrame

- (void)setStatus:(SHStatus *)status {
    _status = status;
    
    // 1. 计算原创微博frame
    [self setupOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    // 2. 转发微博frame
    if (status.retweeted_status) {
        [self setupRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 3. 工具条frame
    CGFloat toolBarW = [UIScreen mainScreen].bounds.size.width;
    _toolBarFrame = CGRectMake(0, toolBarY, toolBarW, 35);
    
    // 
    _cellHight = CGRectGetMaxY(_toolBarFrame);
}

// 1. 计算原创微博frame
- (void)setupOriginalViewFrame {
    // 头像
    CGFloat margin = 10;    // imageX = 10
    CGFloat imageY = margin;
    CGFloat imageWH = 35;
    _originalIconFrame =  CGRectMake(margin, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + margin; // 昵称的 origin = imageX + 边距
    CGFloat nameY = margin;
    CGSize nameSize = [_status.user.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _originalNameFrame =  CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    // VIP
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + margin;;
        CGFloat vipY = margin;
        CGFloat vipWH = 14;
        _originalVipFrame =  CGRectMake(vipX, vipY, vipWH, vipWH);
    }
    
    // 时间
    
    
    // 来源
    
    // 正文
    CGFloat textX = margin;
    CGFloat textY = CGRectGetMaxX(_originalIconFrame) + margin;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - margin * 2;
    
    CGSize textSize = [_status.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
//    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    CGSize textSize = [_status.user.name boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    _originalTextFrame =  CGRectMake(textX, textY, textW, textSize.height);
    
    CGFloat originalViewHight = CGRectGetMaxY(_originalTextFrame) + margin;
    
    // 配图
    if (_status.pic_urls.count) {
        CGFloat pX = margin;
        CGFloat pY = CGRectGetMaxY(_originalTextFrame) + margin;
        CGSize pSize = [self photoSizeWithCount:(int)_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){{pX,pY},pSize};
        originalViewHight = CGRectGetMaxY(_originalPhotosFrame) + margin;
    }
    
    // 原创微博cell hight
    _originalViewFrame = CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, originalViewHight);
}

- (CGSize)photoSizeWithCount:(int)count {
    
    CGFloat margin = 10;
    CGFloat photoMargin = 5;
    
    int column = (count == 4 ? 2 : 3);  // 4张图时，显示2列，其他均为显示3列
    int row = (count - 1) / column + 1; // 行数 = 总数 / 列数 + 1
    
    // 图片显示尺寸
    CGFloat photoSize = ([UIScreen mainScreen].bounds.size.width - 2 * margin - 2 * photoMargin) / 3;
    
    // 配图显示的size
    CGFloat pW = column * photoSize + (column - 1) * photoMargin;    // 图片宽度 * 数量 + 总间距
    CGFloat pH = row * photoSize + (row - 1) * photoMargin;
    
    return CGSizeMake(pW, pH);
}

- (void)setupRetweetViewFrame {
    CGFloat margin = 10;
    // 昵称
    CGFloat nameX = margin;
    CGFloat nameY = margin;
    CGSize nameSize = [_status.retweetName sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = margin;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + margin;
    CGFloat textW = [UIScreen mainScreen].bounds.size.width - margin * 2;
    CGSize textSize = [_status.retweeted_status.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _retweetTextFrame = CGRectMake(textX, textY, textW, textSize.height);
    
    CGFloat retweetViewX = 0;
    CGFloat retweetViewY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat retweetViewH = CGRectGetMaxY(_retweetTextFrame) + margin;
    
    // 配图
    int count = (int)_status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photoX = margin;
        CGFloat photoY = CGRectGetMaxY(_retweetTextFrame) + margin;
        CGSize photoSize = [self photoSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photoX,photoY},photoSize};
        
        retweetViewH = CGRectGetMaxY(_retweetPhotosFrame) + margin;
    }
    
    // 转发微博的大小
    _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
}

@end

//
//  SHPhotosView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHPhotosView.h"

#import "SHPhotoView.h"

@implementation SHPhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
        
        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)setupSubViews {
    for (int i = 0; i < 9; i++) {
        SHPhotoView *imgView = [[SHPhotoView alloc] init];
        imgView.tag = i;
        
        // 添加手势 ...
        
        [self addSubview:imgView];
    }
}

- (void)setPic_urls:(NSArray *)pic_urls {
    _pic_urls = pic_urls;
    int count = (int)self.subviews.count;
    
    for (int i = 0; i < count; i++) {
        SHPhotoView *photoView = self.subviews[i];
        if (i < _pic_urls.count) {
            SHPhoto *photo = _pic_urls[i];
            photoView.photo = photo;
            photoView.hidden = NO;
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 80;
    CGFloat h = 80;
    
    CGFloat margin = 5;
    
    int photoCount = (int)_pic_urls.count;
    int column = 0;
    int row = 0;
    
    int actualColumn = photoCount == 4 ? 2 : 3;
    
    for (int i = 0; i < photoCount; i++) {
        column = i % actualColumn;
        row = i / actualColumn;
        
        UIImageView *imgView = self.subviews[i];
        x = column * (w + margin);
        y = row * (h + margin);
        
        imgView.frame = CGRectMake(x, y, w, h);
    }
}

@end

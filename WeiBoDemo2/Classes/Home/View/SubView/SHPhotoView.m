//
//  SHPhotoView.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  获取图片

#import "SHPhotoView.h"

#import "SHPhoto.h"

#import "UIImageView+WebCache.h"

@interface SHPhotoView()

@property (nonatomic,weak) UIImageView *gifView;

@end

@implementation SHPhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

-(void)setPhoto:(SHPhoto *)photo {
    _photo = photo;
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // gif
    NSString *urlString = photo.thumbnail_pic.absoluteString;
    if ([urlString hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
    
}

// gif
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize photoViewSize = self.frame.size;
    CGSize gifViewSize = self.gifView.frame.size;
    
    self.gifView.frame = CGRectMake(photoViewSize.width - gifViewSize.width, photoViewSize.height - gifViewSize.height, self.gifView.bounds.size.width, self.gifView.bounds.size.height);
}

@end

//
//  SHNewFeatureCell.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHNewFeatureCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;

// 设置最后一页，显示按钮
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end

NS_ASSUME_NONNULL_END

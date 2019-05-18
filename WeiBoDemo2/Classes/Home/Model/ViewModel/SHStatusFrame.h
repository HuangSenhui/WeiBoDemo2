//
//  SHStatusFrame.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SHStatusFrame.h"
#import "SHStatus.h"
#import "SHUser.h"

NS_ASSUME_NONNULL_BEGIN
@class SHStatus;
@interface SHStatusFrame : NSObject

/**
 *  微博数据
 */
@property (nonatomic,strong) SHStatus *status;

/**
 *  原创微博frame
 */
@property (nonatomic,assign,readonly) CGRect originalViewFrame;
/**
 *  用户头像frame
 */
@property (nonatomic,assign,readonly) CGRect originalIconFrame;
/**
 *  用户昵称frame
 */
@property (nonatomic,assign,readonly) CGRect originalNameFrame;
/**
 *  微博VIPframe
 */
@property (nonatomic,assign,readonly) CGRect originalVipFrame;
/**
 *  微博时间frame
 */
@property (nonatomic,assign,readonly) CGRect originalTimeFrame;
/**
 *  微博来源frame
 */
@property (nonatomic,assign,readonly) CGRect originalSourceFrame;
/**
 *  微博正文frame
 */
@property (nonatomic,assign,readonly) CGRect originalTextFrame;
/**
 *  微博图片frame
 */
@property (nonatomic,assign,readonly) CGRect originalPhotosFrame;

/* -- 转发微博的控件 --*/

/**
 *  转发微博frame
 */
@property (nonatomic,assign,readonly) CGRect retweetViewFrame;
/**
 *  转发微博用户昵称frame
 */
@property (nonatomic,assign,readonly) CGRect retweetNameFrame;
/**
 *  转发微博正文frame
 */
@property (nonatomic,assign,readonly) CGRect retweetTextFrame;
/**
 *  转发微博配图frame
 */
@property (nonatomic,assign,readonly) CGRect retweetPhotosFrame;

/**
 *  微博工具条frame
 */
@property (nonatomic,assign,readonly) CGRect toolBarFrame;

/**
 *  微博 cell 高度
 */
@property (nonatomic,assign,readonly) CGFloat cellHight;

@end

NS_ASSUME_NONNULL_END

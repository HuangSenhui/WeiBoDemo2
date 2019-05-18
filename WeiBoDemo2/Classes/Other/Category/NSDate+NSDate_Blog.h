//
//  NSDate+NSDate_Blog.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (NSDate_Blog)
/**
 * 是否为今天
 */
- (BOOL)isToday;
/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;
/**
 * 是否为今天
 */
- (NSDate *)dataWithYYYYMMDD;
/**
 * 获取当前时间查
 */
- (NSDateComponents *)farFormNow;


@end

NS_ASSUME_NONNULL_END

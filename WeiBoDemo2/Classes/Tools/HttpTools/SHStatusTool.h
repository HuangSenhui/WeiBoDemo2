//
//  SHStatusTool.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  微博API文档：https://open.weibo.com/wiki/2/statuses/home_timeline

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHStatusTool : NSObject

/**
 *  请求最新的微博数据
 */
+ (void) newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *err))failure;

/**
 *  请求更多旧微博数据
 */
+ (void) moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *err))failure;

@end

NS_ASSUME_NONNULL_END

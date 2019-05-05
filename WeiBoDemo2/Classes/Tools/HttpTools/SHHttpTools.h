//
//  SHHttpTools.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/6.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHHttpTools : NSObject

/*
 * GET
 */
+ (void )GET:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;

/*
 * POST
 */
+ (void)POST:(NSString *)URLString parameters:(nullable id)parameters success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure;


@end

NS_ASSUME_NONNULL_END

//
//  SHSendBlog.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class SHStatus;
@interface SHSendBlog : NSObject

// 发送文字微博
+ (void)sendBlogWithText:(NSString *)text success:(void(^)(SHStatus *status))seccess failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

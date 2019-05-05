//
//  SHAccountTools.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/6.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHUserAccount.h"

NS_ASSUME_NONNULL_BEGIN

@class SHUserAccount;
@interface SHAccountTools : NSObject

+ (void)saveAccount:(SHUserAccount *)account;
+ (SHUserAccount *)account;

+ (void)getTokenWithCode:(NSString *)code success:(void (^)(void))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

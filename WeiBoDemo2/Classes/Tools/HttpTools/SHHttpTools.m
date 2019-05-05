//
//  SHHttpTools.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/6.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHHttpTools.h"

@implementation SHHttpTools

+ (void )GET:(NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(id _Nullable responseObject))success failure:(nullable void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
     success:(nullable void (^)(id _Nullable responseObject))success
     failure:(nullable void (^)(NSError *error))failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end

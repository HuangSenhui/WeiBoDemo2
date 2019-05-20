//
//  SHSendBlog.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHSendBlog.h"

#import "SHHttpTools.h"
#import "SHAccountTools.h"
#import "SHStatus.h"

#import <MJExtension.h>

@implementation SHSendBlog

// 发送文字 微博发送接口不可用
+ (void)sendBlogWithText:(NSString *)text success:(void(^)(SHStatus *status))success failure:(void(^)(NSError *error))failure {
    
    NSString *uploadText = [NSString stringWithFormat:@"%@ http://www.baidu.com/",text];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SHAccountTools account].access_token;
    params[@"status"] = uploadText; //[uploadText stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLUserAllowedCharacterSet]];
    //NSLog(@"%@",params);
    NSString *url = @"https://api.weibo.com/2/statuses/share.json";
    [SHHttpTools POST:url parameters:params success:^(id responseObject) {
        
        SHStatus *status = [SHStatus mj_objectWithKeyValues:responseObject];
        if (success) {
            success(status);
        }
        
    } failure:^(NSError * error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 发送图文

@end

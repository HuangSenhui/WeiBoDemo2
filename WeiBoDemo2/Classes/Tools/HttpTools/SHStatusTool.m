//
//  SHStatusTool.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHStatusTool.h"

#import "SHHttpTools.h"
#import "SHAccountTools.h"
#import "SHStatus.h"

#import "SHSqliteDBTools.h"

#import <MJExtension.h>

@implementation SHStatusTool

/**
 *  请求最新的微博数据
 */
+ (void) newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *err))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SHAccountTools account].access_token;
    if (sinceId) {
        params[@"since_id"] = sinceId;
    }
    
    // 从数据库读取微博数据，更具参数来判断来取数据
    NSArray *statues = [SHSqliteDBTools readStatusWithParam:params];
    if (statues.count) {
        if (success) success(statues);
        return;
    }
    
    NSString *homeurl = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [SHHttpTools GET:homeurl parameters:params success:^(id responseObject) {
        NSArray *dicArr = responseObject[@"statuses"];
        NSArray *statuses = [SHStatus mj_objectArrayWithKeyValuesArray:dicArr];
        if (success) {
            success(statuses);
        }
        // 将新的数据保存到数据库
        [SHSqliteDBTools saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

/**
 *  请求更多旧微博数据
 */
+ (void) moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *err))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [SHAccountTools account].access_token;
    if (maxId) {
        params[@"max_id"] = maxId;
    }
    
    // 从数据库读取数据
    NSArray *statues = [SHSqliteDBTools readStatusWithParam:params];
    if (statues.count) {
        if (success) success(statues);
        return;
    }
    
    NSString *homeurl = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [SHHttpTools GET:homeurl parameters:params success:^(id responseObject) {
        NSArray *dicArr = responseObject[@"statuses"];
        NSArray *statuses = [SHStatus mj_objectArrayWithKeyValuesArray:dicArr];
        if (success) {
            success(statuses);
        }
        
        // 保存到数据库
        [SHSqliteDBTools saveWithStatuses:responseObject[@"statuses"]];
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

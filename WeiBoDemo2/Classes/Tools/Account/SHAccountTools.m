//
//  SHAccountTools.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/6.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHAccountTools.h"

#import "SHHttpTools.h"

#define SHbaseURL          @"https://api.weibo.com/oauth2/authorize"
#define SHClient_id        @"3399930463"
#define SHClient_secret    @"0761ec0064f8c8c5216251702f94cde1"
#define SHRedirect_uri     @"https://www.baidu.com"

#define ACCOUNT_file [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingString:@"/account.data"]

@implementation SHAccountTools

static SHUserAccount *_account;

// 归档保存
+ (void)saveAccount:(SHUserAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_file];
}

// 归档读取
+ (SHUserAccount *)account {
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_file];
        // 授权过期设置
        NSInteger isExpires = 0;
        if(isExpires){
            _account = nil;
        }
    }
    return _account;
}

+(void)getTokenWithCode:(NSString *)code success:(void (^)(void))success failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"]        = SHClient_id;
    params[@"client_secret"]    = SHClient_secret;
    params[@"grant_type"]       = @"authorization_code";
    params[@"code"]             = code;
    params[@"redirect_uri"]     = SHRedirect_uri;
    
    NSString *accessTokenUrl = @"https://api.weibo.com/oauth2/access_token";
    
    [SHHttpTools POST:accessTokenUrl parameters:params success:^(id responseObject) {
        
        SHUserAccount *account = [SHUserAccount userAccountWithDictionary:responseObject];
        [SHAccountTools saveAccount:account];
        
        if(success) success();
        
    } failure:^(NSError *error) {
        NSLog(@"%@",@"登录授权失败");
        if(failure) failure(error);
    }];
}
@end

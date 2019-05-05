//
//  SHUserAccount.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHUserAccount : NSObject <NSCoding>

@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,copy) NSString *expires_in;
@property (nonatomic,copy) NSString *isRealName;
@property (nonatomic,copy) NSString *remind_in;
@property (nonatomic,copy) NSString *uid;

+ (instancetype)userAccountWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

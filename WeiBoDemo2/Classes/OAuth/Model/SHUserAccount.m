//
//  SHUserAccount.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/5.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHUserAccount.h"

@implementation SHUserAccount

+ (instancetype)userAccountWithDictionary:(NSDictionary *)dictionary {
    SHUserAccount *account = [self new];
    [account setValuesForKeysWithDictionary:dictionary];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_access_token forKey:@"token"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_expires_in forKey:@"expires"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"token"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires"];
    }
    return self;
}

@end

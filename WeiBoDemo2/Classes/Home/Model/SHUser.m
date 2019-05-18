//
//  SHUser.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "SHUser.h"

@implementation SHUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end

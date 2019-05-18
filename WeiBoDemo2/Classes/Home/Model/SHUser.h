//
//  SHUser.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic,strong) NSURL *profile_image_url;
/**
 *  微博会员
 */
@property (nonatomic,assign) int mbtype;
/**
 *  微博等级
 */
@property (nonatomic,assign) int mbrank;
/**
 *  微博VIP
 */
@property (nonatomic,assign,getter=isVip) BOOL vip;

@end

NS_ASSUME_NONNULL_END

//
//  SHStatus.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SHUser.h"
#import "SHPhoto.h"

#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHStatus : NSObject <MJKeyValue>
/**
 *  用户
 */
@property (nonatomic,strong) SHUser *user;
/**
 *  转发微博
 */
@property (nonatomic,strong) SHStatus *retweeted_status;
/**
 *  转发昵称
 */
@property (nonatomic,copy) NSString *retweetName;
/**
 *  微博创建时间
 */
@property (nonatomic,copy) NSString *created_at;
/**
 *  微博id
 */
@property (nonatomic,copy) NSString *idstr;
/**
 *  微博内容
 */
@property (nonatomic,copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic,copy) NSString *source;
/**
 *  微博转发数量
 */
@property (nonatomic,assign) int reposts_count;
/**
 *  微博评论数量
 */
@property (nonatomic,assign) int comments_count;
/**
 *  微博点赞数量
 */
@property (nonatomic,assign) int attitudes_count;
/**
 *  微博内容图片
 */
@property (nonatomic,strong) NSArray *pic_urls;


@end

NS_ASSUME_NONNULL_END

//
//  SHSqliteDBTools.h
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/20.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SHStatusFrame;
@interface SHSqliteDBTools : NSObject

// 保存
+ (void)saveWithStatuses:(NSArray *)statuses;
// 读取
+ (NSArray *)readStatusWithParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END

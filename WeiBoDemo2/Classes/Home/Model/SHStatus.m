//
//  SHStatus.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/8.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//  微博 dataTemplate

#import "SHStatus.h"

#import "NSDate+NSDate_Blog.h"

@implementation SHStatus

// 从数组中字典转化对应模型
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"pic_urls":[SHPhoto class]};
}

// 时间格式化    weibo时间格式：Sat May 18 22:00:11 +0800 2019
/* 需求：
 * 往年：yyyy-MM-dd HH:mm、
 * 年内：xx月xx日 HH:mm、
 * 日内：HH小时之前、
 * 一小时内：MM分钟之前、
 * 1分钟之前：刚刚
 */
- (NSString *)created_at {
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    if ([createDate isThisYear]) {                                                  // 今年
        
        if ([createDate isToday]) {                                                 // 今天
            NSDateComponents *cmps = [createDate farFormNow];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmps.hour];
            } else if (cmps.minute > 1) {
                return [NSString stringWithFormat:@"%ld分钟之前",cmps.minute];
            } else {
                return @"刚刚";
            }
        } else if ([createDate isYesterday]) {                                      // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else {                                                                    // 其它
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else {                                                                        // 往年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    
    return _created_at;
}

- (void)setSource:(NSString *)source {
    if (source.length == 0) return;
    
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    
    _source = source;
}

- (void)setRetweeted_status:(SHStatus *)retweeted_status {
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

@end

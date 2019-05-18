//
//  NSDate+NSDate_Blog.m
//  WeiBoDemo2
//
//  Created by HuangSenhui on 2019/5/18.
//  Copyright © 2019 HuangSenhui. All rights reserved.
//

#import "NSDate+NSDate_Blog.h"

@implementation NSDate (NSDate_Blog)

- (BOOL)isToday {
    NSCalendar *calender = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calender components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calender components:unit fromDate:self];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

- (BOOL)isYesterday {
    NSDate *nowDate = [[NSDate date] dataWithYYYYMMDD];
    NSDate *selfDate = [self dataWithYYYYMMDD];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDate *)dataWithYYYYMMDD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *str = [fmt stringFromDate:self];
    return [fmt dateFromString:str];
}

- (NSDateComponents *)farFormNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end

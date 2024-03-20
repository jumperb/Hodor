//
//  NSArray+ext.m
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "NSDate+ext.h"

@implementation NSDate (ext)


+ (NSDate *)dateWithString:(NSString *)dateStr
{
    return [self dateWithString:dateStr style:0];
}
+ (NSDate *)dateWithString:(NSString *)dateStr style:(int)style
{
    if(dateStr)
    {
        NSDateFormatter *dateFormatter = [self formatterWithStyle:style];
        NSDate *date = [dateFormatter dateFromString:dateStr];
        return date;
    }
    else return nil;
}

- (NSString *)displayDesc
{
    return [self displayDescWithStyle:0];
}
- (NSString *)displayDescWithStyle:(int)style
{
    NSDateFormatter *formatter = [NSDate formatterWithStyle:style];
    return [formatter stringFromDate:self];
}

+ (NSDateFormatter *)formatterWithStyle:(int)style {
    int styleMax = 5;
    if (style > styleMax) style = styleMax;
    static dispatch_once_t pred;
    static NSMutableArray *cache = nil;
    dispatch_once(&pred, ^{
        cache = [NSMutableArray new];
        for (int i = 0; i < styleMax; i ++) {
            [cache addObject:[NSNull null]];
        }
    });
    //search
    id obj = cache[style - 1];
    if ([obj isKindOfClass:[NSDateFormatter class]]) {
        return obj;
    }
    else {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSString *format = nil;
        switch (style) {
            case 1:
                format = @"yyyy-MM-dd";
                break;
            case 2:
                format = @"yyyy-MM-dd HH:mm:ss";
                break;
            case 3:
                format = @"MM-dd";
                break;
            case 4:
                format = @"yyyy-MM-dd HH:mm:ss+SSS";
                break;
            default:
                format = @"yyyy-MM-dd HH:mm:ss";
                break;
        }
        [formatter setDateFormat:format];
        [formatter setLocale:[NSLocale systemLocale]];
        cache[style - 1] = formatter;
        return formatter;
    }
}

+ (long)timeAfterNDays:(int)n orignal:(long)time
{
    return time + n * 86400;
}

+ (long)timeAfterNMonth:(int)n orignal:(long)time
{
    //TODO check initWithCalendarIdentifier
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:n];
    [adcomps setDay:0];
    NSDate *dayBegin = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    return [dayBegin timeIntervalSince1970];
}
@end

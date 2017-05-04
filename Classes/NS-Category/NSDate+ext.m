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
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSString *format = nil;
        switch (style) {
            case 1:
                format = @"yyyy-MM-dd";
                break;
            default:
                format = @"yyyy-MM-dd HH:mm:ss";
                break;
        }
        [dateFormatter setDateFormat:format];
        [dateFormatter setLocale:[NSLocale systemLocale]];
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
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
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
        default:
            format = @"yyyy-MM-dd HH:mm:ss";
            break;
    }
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale systemLocale]];
    return [formatter stringFromDate:self];
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

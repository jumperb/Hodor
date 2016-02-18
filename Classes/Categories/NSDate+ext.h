//
//  NSArray+ext.h
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>


#define secOfDay (60*60*24)
#define secOfWeek (7 * secOfDay)
#define minMonthSec (28 * secOfDay)
#define maxMonthSec (31 * secOfDay)

@interface NSDate (ext)

+ (NSDate *)dateWithString:(NSString *)dateStr;

+ (NSDate *)dateWithString:(NSString *)dateStr style:(int)style;

- (NSString *)displayDesc;

- (NSString *)displayDescWithStyle:(int)style;

/**
 *  time after n days
 *
 *  @param n
 *  @param time start time
 *
 *  @return time after n days
 */
+ (long)timeAfterNDays:(int)n orignal:(long)time;

/**
 *  time after n monthes
 *
 *  @param n
 *  @param time start time
 *
 *  @return time after n monthes
 */
+ (long)timeAfterNMonth:(int)n orignal:(long)time;
@end

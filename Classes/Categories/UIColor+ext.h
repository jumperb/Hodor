//
//  UIColor+ext.h
//  HFramework
//
//  Created by zhangchutian on 14-6-5.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ext)

- (UIColor *)revertColor;

//formate : @"#f6ee34" or @"0x45fed2"
+ (UIColor *)colorWithString:(NSString *)colorStr alpha:(float)alpha;
+ (UIColor *)colorWithString:(NSString *)colorStr;

//formate : 0x9875a3
+ (UIColor *)colorWithHex:(int)hex alpha:(float)alpha;
+ (UIColor *)colorWithHex:(int)hex;

+ (UIColor *)random;
@end

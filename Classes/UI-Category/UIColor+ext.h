//
//  UIColor+ext.h
//  HFramework
//
//  Created by zhangchutian on 14-6-5.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ext)

- (UIColor *)h_revertColor;

//formate : @"#f6ee34" or @"0x45fed2"
+ (UIColor *)h_colorWithString:(NSString *)colorStr alpha:(float)alpha;
+ (UIColor *)h_colorWithString:(NSString *)colorStr;

//formate : 0x9875a3
+ (UIColor *)h_colorWithHex:(int)hex alpha:(float)alpha;
+ (UIColor *)h_colorWithHex:(int)hex;

+ (UIColor *)h_random;
@end

//
//  UILabel+ext.h
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15-1-5.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ext)

- (void)hSetColor:(UIColor *)color font:(UIFont *)font text:(NSString *)title;
/**
 *  set text and line space
 *
 *  @param text
 *  @param lineSpace
 */
- (void)hSetText:(NSString *)text lineSpace:(CGFloat)lineSpace;

/**
 *  compute height of a text with line height
 *
 *  @param text
 *  @param font
 *  @param lineSpace
 *  @param width
 *
 *  @return
 */
+ (CGFloat)hGetTextHeightWith:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace width:(CGFloat)width;
@end

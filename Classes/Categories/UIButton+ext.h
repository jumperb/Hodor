//
//  UIButton+ext.h
//  Hodor
//
//  Created by zhangchutian on 15/6/29.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ext)
- (void)hSetTitle:(NSString *)title;
- (void)hSetTitleColor:(UIColor *)color;
- (void)hSetFont:(UIFont *)font;
- (void)hSetColor:(UIColor *)color font:(UIFont *)font title:(NSString *)title;
- (void)hSetImage:(UIImage *)image;
- (void)hAddTarget:(id)target action:(SEL)action;
@end

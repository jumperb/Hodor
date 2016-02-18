//
//  UIButton+ext.m
//  Hodor
//
//  Created by zhangchutian on 15/6/29.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIButton+ext.h"

@implementation UIButton (ext)
- (void)hSetTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
- (void)hSetTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
- (void)hSetFont:(UIFont *)font
{
    [self.titleLabel setFont:font];
}
- (void)hSetColor:(UIColor *)color font:(UIFont *)font title:(NSString *)title
{
    [self hSetTitle:title];
    [self hSetTitleColor:color];
    [self hSetFont:font];
}
- (void)hSetImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}

- (void)hAddTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

//let the min respond area is 44*44
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect bounds = self.bounds;
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}
@end

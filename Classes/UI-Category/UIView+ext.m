//
//  UIView+ext.m
//  HFramework
//
//  Created by zhangchutian on 13-12-18.
//  Copyright (c) 2013年 zhangchutian. All rights reserved.
//

#import "UIView+ext.h"
#import <objc/runtime.h>


@implementation UIView (ext)
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;
@dynamic xmax;
@dynamic ymax;
@dynamic userInfo;
@dynamic innerWidth;
@dynamic innerHeight;

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)width
{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)xmax
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setXmax:(CGFloat)xmax
{
    CGRect frame = self.frame;
    frame.origin.x = xmax - frame.size.width;
    self.frame = frame;
}
- (CGFloat)ymax
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setYmax:(CGFloat)ymax
{
    CGRect frame = self.frame;
    frame.origin.y = ymax - frame.size.height;
    self.frame = frame;
}
- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}







- (CGFloat)innerHeight
{
    return self.bounds.origin.y + self.bounds.size.height;
}

- (CGFloat)innerWidth
{
    return self.bounds.origin.x + self.bounds.size.width;
}

static const void *userInfoAddress = &userInfoAddress;
- (id)userInfo
 {
    return objc_getAssociatedObject(self, userInfoAddress);
 }

- (void)setUserInfo:(id)userInfo
 {
    objc_setAssociatedObject(self, userInfoAddress, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
 }

- (void)removeAllSubViews
{
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
}
@end

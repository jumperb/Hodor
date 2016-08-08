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

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)innerHeight
{
    return self.bounds.origin.y + self.frame.size.height;
}

- (CGFloat)innerWidth
{
    return self.bounds.origin.x + self.frame.size.width;
}

- (CGFloat)xmax
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)ymax
{
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setXmax:(CGFloat)xmax
{
    CGRect frame = self.frame;
    frame.origin.x = xmax - frame.size.width;
    self.frame = frame;
}

- (void)setYmax:(CGFloat)ymax
{
    CGRect frame = self.frame;
    frame.origin.y = ymax - frame.size.height;
    self.frame = frame;
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

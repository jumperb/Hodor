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

static const void *userInfoAddress = &userInfoAddress;

#ifndef HodorDisableShotMethod
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
#endif


@dynamic h_x;
@dynamic h_y;
@dynamic h_width;
@dynamic h_height;
@dynamic h_xmax;
@dynamic h_ymax;
@dynamic h_userInfo;
@dynamic h_innerWidth;
@dynamic h_innerHeight;

- (CGFloat)h_x
{
    return self.frame.origin.x;
}

- (void)setH_x:(CGFloat)h_x
{
    CGRect frame = self.frame;
    frame.origin.x = h_x;
    self.frame = frame;
}

- (CGFloat)h_y
{
    return self.frame.origin.y;
}
- (void)setH_y:(CGFloat)h_y
{
    CGRect frame = self.frame;
    frame.origin.y = h_y;
    self.frame = frame;
}
- (CGFloat)h_width
{
    return self.frame.size.width;
}
- (void)setH_width:(CGFloat)h_width
{
    CGRect frame = self.frame;
    frame.size.width = h_width;
    self.frame = frame;
}

- (CGFloat)h_height
{
    return self.frame.size.height;
}

- (void)setH_height:(CGFloat)h_height
{
    CGRect frame = self.frame;
    frame.size.height = h_height;
    self.frame = frame;
}

- (CGFloat)h_xmax
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setH_xmax:(CGFloat)h_xmax
{
    CGRect frame = self.frame;
    frame.origin.x = h_xmax - frame.size.width;
    self.frame = frame;
}
- (CGFloat)h_ymax
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setH_ymax:(CGFloat)h_ymax
{
    CGRect frame = self.frame;
    frame.origin.y = h_ymax - frame.size.height;
    self.frame = frame;
}
- (CGPoint)h_origin
{
    return self.frame.origin;
}
- (void)setH_origin:(CGPoint)h_origin
{
    CGRect frame = self.frame;
    frame.origin = h_origin;
    self.frame = frame;
}

- (CGSize)h_size
{
    return self.frame.size;
}
- (void)setH_size:(CGSize)h_size
{
    CGRect frame = self.frame;
    frame.size = h_size;
    self.frame = frame;
}

- (CGFloat)h_centerX
{
    return self.center.x;
}
- (void)setH_centerX:(CGFloat)h_centerX
{
    self.center = CGPointMake(h_centerX, self.center.y);
}
- (CGFloat)h_centerY
{
    return self.center.y;
}
- (void)setH_centerY:(CGFloat)h_centerY
{
    self.center = CGPointMake(self.center.x, h_centerY);
}







- (CGFloat)h_innerHeight
{
    return self.bounds.origin.y + self.bounds.size.height;
}

- (CGFloat)h_innerWidth
{
    return self.bounds.origin.x + self.bounds.size.width;
}

- (id)h_userInfo
{
    return objc_getAssociatedObject(self, userInfoAddress);
}

- (void)setH_userInfo:(id)h_userInfo
{
    objc_setAssociatedObject(self, userInfoAddress, h_userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)h_removeAllSubViews
{
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
}

@end

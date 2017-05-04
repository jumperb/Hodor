//
//  UIView+BadBackgroundBehavior.m
//  SelfieCamera
//
//  Created by HeLin on 16/8/15.
//  Copyright © 2016年 Pinguo. All rights reserved.
//

#import "UIView+BadBackgroundBehavior.h"
#import <objc/runtime.h>

#ifdef DEBUG

@implementation UIView (BadBackgroundBehavior)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(object_getClass(self), @selector(setAnimationsEnabled:)),
                                   class_getInstanceMethod(object_getClass(self), @selector(h_setAnimationsEnabled:)));
    
    method_exchangeImplementations(class_getInstanceMethod(object_getClass(self), @selector(setNeedsLayout)),
                                   class_getInstanceMethod(object_getClass(self), @selector(h_setNeedsLayout)));
    
    method_exchangeImplementations(class_getInstanceMethod(object_getClass(self), @selector(setNeedsDisplay)),
                                   class_getInstanceMethod(object_getClass(self), @selector(h_setNeedsDisplay)));
    
    method_exchangeImplementations(class_getInstanceMethod(object_getClass(self), @selector(setNeedsDisplayInRect:)),
                                   class_getInstanceMethod(object_getClass(self), @selector(h_setNeedsDisplayInRect:)));
}

+ (void)h_setAnimationsEnabled:(BOOL)enabled
{
    if (![NSThread isMainThread])
    {
        NSAssert(NO,
                 @"UIKit interface called on secondary thread, and that behavior will lead to all animation not work in your app!!! Please put a Breakpoint here and check all threads call stack!!!");
    }
    [self h_setAnimationsEnabled:enabled];
}

- (void)h_setNeedsDisplay
{
    if (![NSThread isMainThread])
    {
        NSAssert(NO,
                 @"-[UIView setNeedsDisplay] called on secondary thread,  Please put a Breakpoint here and check all threads' call stack!!!");
    }
    [self h_setNeedsDisplay];
}

- (void)h_setNeedsLayout
{
    if (![NSThread isMainThread])
    {
        NSAssert(NO,
                 @"-[UIView setNeedsLayout] called on secondary thread, Please put a Breakpoint here and check all threads' call stack!!!");
    }
    [self h_setNeedsLayout];
}

- (void)h_setNeedsDisplayInRect:(CGRect)rect
{
    if (![NSThread isMainThread])
    {
        NSAssert(NO,
                 @"-[UIView setNeedsDisplayInRect:] called on secondary thread, Please put a Breakpoint here and check all threads' call stack!!!");
    }
    [self h_setNeedsDisplayInRect:rect];
}

@end

#endif

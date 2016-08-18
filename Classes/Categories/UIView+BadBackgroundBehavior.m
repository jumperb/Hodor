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
                                   class_getInstanceMethod(object_getClass(self), @selector(sc_setAnimationsEnabled:)));
}

+ (void)sc_setAnimationsEnabled:(BOOL)enabled
{
    if (![NSThread isMainThread])
    {
        NSAssert(NO,
                 @"UIKit interface called on secondary thread, and that behavior will lead to all animation not work in your app!!! Please put a Breakpoint here and check all thread call stack!!!");
    }
    [self sc_setAnimationsEnabled:enabled];
}

@end

#endif

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
        NSAssert(NO, @"后台有地方调用了UIKit框架的接口，这种行为可能导致应用整体动画失效及其它不可预测的问题！！！如发现此断言，请在UIView+BadBackgroundBehavior类的-sc_setAnimationsEnabled:方法处打断点，查看线程调用情况！");
    }
    [self sc_setAnimationsEnabled:enabled];
}

@end

#endif

//
//  UIApplication+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIApplication+ext.h"

@implementation UIApplication (ext)

- (UIWindow *)getKeyWindow
{
    UIWindow *window = self.windows[0];
    return window;
}

- (UIViewController *)getKeyWindowRootController
{
    UIWindow *keyWindow = [self getKeyWindow];
    return keyWindow.rootViewController;
}

@end

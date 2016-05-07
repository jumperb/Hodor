//
//  UIApplication+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIApplication+ext.h"

@implementation UIApplication (ext)

+ (UIWindow *)getKeyWindow
{
    return [[UIApplication sharedApplication] getKeyWindow];
}
- (UIWindow *)getKeyWindow
{
    UIWindow *window = self.windows[0];
    return window;
}
+ (UIViewController *)getKeyWindowRootController
{
    return [[UIApplication sharedApplication] getKeyWindowRootController];
}
- (UIViewController *)getKeyWindowRootController
{
    UIWindow *keyWindow = [self getKeyWindow];
    return keyWindow.rootViewController;
}

//get root navigation controller
+ (UINavigationController *)navi
{
    UIViewController *navi = [self getKeyWindowRootController];
    if ([navi isKindOfClass:[UINavigationController class]])
    {
        return (UINavigationController *)navi;
    }
    else return nil;
}

//get root navigation controller top
+ (UIViewController *)naviTop
{
    UIViewController *navi = [self getKeyWindowRootController];
    if ([navi isKindOfClass:[UINavigationController class]])
    {
        return [(UINavigationController *)navi topViewController];
    }
    else return nil;
}

//get root tabbar vc
+ (UITabBarController *)tabbarVC
{
    UIViewController *tabVC = [self getKeyWindowRootController];
    if ([tabVC isKindOfClass:[UITabBarController class]])
    {
        return (UITabBarController *)tabVC;
    }
    else return nil;
}
@end

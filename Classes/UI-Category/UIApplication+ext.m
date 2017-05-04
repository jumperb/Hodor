//
//  UIApplication+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIApplication+ext.h"
#if __has_include("HClassManager.h")
#import "HClassManager.h"
#endif

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
#if __has_include("HClassManager.h")
//open url in application
- (BOOL)openURLInApp:(NSURL *)url
{
    //only the url confirmed to http(s) protocal can goto a inner webview
    if ([url scheme] && ([[url scheme] compare:@"http" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
                         [[url scheme] compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame))
    {
        id<HAppOpenURLProtocal> obj = [HClassManager getObjectOfProtocal:@protocol(HAppOpenURLProtocal)];
        NSAssert(obj, @"can not find a imp of HAppOpenURLProtocal");
        if (obj)
        {
            UIViewController *webVC = [obj createWebVCWithUrl:url];
            [[UIApplication navi] pushViewController:webVC animated:YES];
        }
        else
        {
            [self openURL:url];
        }
    }
    else
    {
        return [self openURL:url];
    }
    return YES;
}
#endif
@end

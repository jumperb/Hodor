//
//  UIApplication+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIApplication+ext.h"
#import "HClassManager.h"

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

//open url in application
- (BOOL)openURLInApp:(NSURL *)url
{
    //do nothing when application is in UIApplicationStateBackground state
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive)
    {
        return NO;
    }
    
    //only the url confirmed to http(s) protocal can goto a inner webview
    if ([url scheme] && ([[url scheme] compare:@"http" options:NSCaseInsensitiveSearch] == NSOrderedSame ||
                         [[url scheme] compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame))
    {
        for (NSInteger i = self.windows.count - 1; i >= 0; i--)
        {
            UIWindow *window = self.windows[i];
            
            if ([window.rootViewController isKindOfClass:[UINavigationController class]])
            {
                UINavigationController *navi = nil;
                UIViewController *enumvc = window.rootViewController;
                while (YES)
                {
                    if (enumvc.presentedViewController)
                    {
                        enumvc = enumvc.presentedViewController;
                    }
                    else if ([enumvc isKindOfClass:[UINavigationController class]])
                    {
                        UINavigationController *_navi = (UINavigationController *)enumvc;
                        enumvc = _navi.topViewController;
                    }
                    else
                    {
                        break;
                    }
                }
                navi = enumvc.navigationController;
                id<HAppOpenURLProtocal> obj = [HClassManager getObjectOfProtocal:@protocol(HAppOpenURLProtocal)];
                NSAssert(obj, @"can not find a imp of HAppOpenURLProtocal");
                UIViewController *webVC = [obj createWebVCWithUrl:url];
                [navi pushViewController:webVC animated:YES];
                break;
            }
        }
    }
    else
    {
        return [self openURL:url];
    }
    return YES;
}
@end

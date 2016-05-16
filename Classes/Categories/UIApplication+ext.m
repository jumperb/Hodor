//
//  UIApplication+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UIApplication+ext.h"
#import "HClassManager.h"
#import "HOpenURLDelegate.h"

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

- (BOOL)openURLInApp:(NSURL *)url
{
    //在后台不执行
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)
    {
        return NO;
    }
    
    //只有http(s)协议的url才被定向到内部webview
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
                [HClassManager scanClassForKey:HOpenURLDelegateRegKey fetchblock:^(__unsafe_unretained Class aclass, id userInfo) {
                    id obj = [[aclass alloc] init];
                    if ([obj conformsToProtocol:@protocol(HOpenURLDelegate)])
                    {
                        if ([obj respondsToSelector:@selector(webVCWithUrl:)])
                        {
                            UIViewController *vc = [obj webVCWithUrl:url];
                            [navi pushViewController:vc animated:YES];
                        }
                    }
                }];
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

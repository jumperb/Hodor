//
//  UIApplication+ext.h
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15/4/2.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (ext)

//get Window 0
+ (UIWindow *)getKeyWindow;

//get Window 0
- (UIWindow *)getKeyWindow;

//get root VC of window 0
+ (UIViewController *)getKeyWindowRootController;

//get root VC of window 0
- (UIViewController *)getKeyWindowRootController;

//get root navigation controller
+ (UINavigationController *)navi;

//get root navigation controller top
+ (UIViewController *)naviTop;

//get root tabbar vc
+ (UITabBarController *)tabbarVC;

//open url in application
- (BOOL)openURLInApp:(NSURL *)url;
@end

@protocol HAppOpenURLProtocal <NSObject>
- (UIViewController *)createWebVCWithUrl:(NSURL *)url;
@end

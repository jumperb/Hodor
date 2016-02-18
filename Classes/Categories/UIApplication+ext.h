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
- (UIWindow *)getKeyWindow;

//get root VC of window 0
- (UIViewController *)getKeyWindowRootController;
@end

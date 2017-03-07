//
//  AppDelegate.m
//  Hodor
//
//  Created by zhangchutian on 14-9-16.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuVC.h"
#import "NSObject+ext.h"
@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    MenuVC *vc = [MenuVC new];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    
    //EDI
    H_ExtendInvoke3(&application,&launchOptions);

    [AppDelegate someClassMethod];
    return YES;
}
+ (void)someClassMethod
{
    H_ExtendInvoke4
}
@end

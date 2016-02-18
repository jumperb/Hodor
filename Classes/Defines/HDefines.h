//
//  HDefines.h
//  Camera360
//
//  Created by zhangchutian on 14-8-8.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define ID_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IOS5_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_IOS6_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_IOS7_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS8_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_IOS9_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IS_568h  ([UIScreen mainScreen].bounds.size.height > 567)

//redefine 'NSLog'
#ifndef NSLog
#if defined(DEBUG)
#define NSLog(format, ...) do {\
(NSLog)((format), ##__VA_ARGS__);\
} while (0)
#else
#define NSLog(format, ...) do{}while(0)
#endif
#endif


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
#define IS_IOS10_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IS_IOS11_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#define IS_IOS12_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 12.0)
#define IS_IOS13_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0)
#define IS_568h  ([UIScreen mainScreen].bounds.size.height > 567)
#define IS_IPHONEX ([UIScreen mainScreen].bounds.size.width == 375.f && [UIScreen mainScreen].bounds.size.height == 812.f ? YES : NO)

// If project include PGL-Core, then use PGL-Core to handle NSAssert for online Assertion Logging
#if __has_include("PGL-Core.h") || __has_include(<PGL-Core.h>) || __has_include(<PGL-Core/PGL-Core.h>)
#import "PGL-Core.h"
#else

//redefine 'NSLog'
#ifndef NSLog
#if defined(DEBUG)
#define NSLog(FORMAT, ...) fprintf(stderr,"%.0f-[%s:%d]\t%s\n", [NSDate date].timeIntervalSince1970 * 1000, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

#else
#define NSLog(format, ...) do{}while(0)
#endif
#endif


/** make one object weak reference in name of object_weak_ */
#ifndef weakify
#if DEBUG
#define weakify(object) _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") _Pragma("clang diagnostic ignored \"-Wshadow\"") autoreleasepool{} __weak __typeof__(object) object##_##weak_ = object; _Pragma("clang diagnostic pop")
#else
#define weakify(object) _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") _Pragma("clang diagnostic ignored \"-Wshadow\"") try{} @finally{} {} __weak __typeof__(object) object##_##weak_ = object; _Pragma("clang diagnostic pop")
#endif
#endif

/** make one weak reference object as strong reference in name of object */
#ifndef strongify
#if DEBUG
#define strongify(object) _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") _Pragma("clang diagnostic ignored \"-Wshadow\"") autoreleasepool{} __typeof__(object) object = object##_##weak_; _Pragma("clang diagnostic pop")
#else
#define strongify(object) _Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunused-variable\"") _Pragma("clang diagnostic ignored \"-Wshadow\"") try{} @finally{} __typeof__(object) object = object##_##weak_; _Pragma("clang diagnostic pop")
#endif
#endif

#endif




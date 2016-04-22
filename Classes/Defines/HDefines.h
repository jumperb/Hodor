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




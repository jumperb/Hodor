//
//  HCommonBlock.h
//  HFramework
//
//  Created by zhangchutian on 14-6-5.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#ifndef HFramework_HCommonBlock_h
#define HFramework_HCommonBlock_h

#import <Foundation/Foundation.h>

// universal block define

typedef void (^min_callback)();

typedef void (^callback)(id sender, id data);

typedef void (^callback2)(id sender, id data, id data2);

typedef void (^simple_callback)(id sender);

typedef void (^fail_callback)(id sender, NSError *error);

typedef id (^returnback)(id sender, id data);

typedef void (^finish_callback)(id sender, id data, NSError *error);


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


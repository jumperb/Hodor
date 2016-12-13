//
//  NSObject+annotation.m
//  Hodor
//
//  Created by zhangchutian on 16/1/17.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "NSObject+annotation.h"
#import <objc/runtime.h>
#import "NSObject+ext.h"

@implementation NSObject (annotation)
+ (NSArray *)annotations:(NSString *)key
{
    NSArray *formats = nil;
    NSString *funName = [NSString stringWithFormat:@"annotion_support_%@", key];
    SEL selector = NSSelectorFromString(funName);
    if ([self respondsToSelector:selector])
    {
        SuppressPerformSelectorLeakWarning(
                                           formats = [self performSelector:selector withObject:nil];
                                           );
    }
    return formats;
}

+ (NSArray *)hInstanceMethodNames:(Class)klass
{
    NSMutableArray *methodNames = [NSMutableArray new];
    unsigned int outCount;
    Method *methods = class_copyMethodList(klass, &outCount);
    NSSet *propertySet = [NSSet setWithArray:[NSObject ppListOfClass:klass]];
    for (int i = 0; i < outCount; i++) {
        NSString *methodDescription = NSStringFromSelector(method_getName(methods[i]));
        //filter property getter
        if ([propertySet containsObject:methodDescription]) continue;
        [methodNames addObject:methodDescription];
    }
    free(methods);
    return methodNames;
}

+ (NSArray *)hClassMethodNames:(Class)klass
{
    Class metaKlass = objc_getMetaClass([NSStringFromClass(klass) cStringUsingEncoding:NSUTF8StringEncoding]);
    NSMutableArray *methodNames = [NSMutableArray new];
    unsigned int outCount;
    Method *methods = class_copyMethodList(metaKlass, &outCount);
    for (int i = 0; i < outCount; i++) {
        NSString *methodDescription = NSStringFromSelector(method_getName(methods[i]));
        [methodNames addObject:methodDescription];
    }
    free(methods);
    return methodNames;
}

@end

NSString *hFormateAnnotationName(NSString *functionName)
{
    return [functionName stringByReplacingOccurrencesOfString:@":" withString:@"_"];
}

//
//  HClassManager.m
//  HFramework
//
//  Created by 火辣先生 on 12-12-21.
//  Copyright (c) 2012年 iTotemStudio. All rights reserved.
//

#import "HClassManager.h"
#import "NSObject+ext.h"

#define HClassCreatorKey @"HClassCreatorKey"

@interface HClassManager ()
@property (nonatomic, strong) NSMutableDictionary *classIndex;
@end

@implementation HClassManager

#pragma mark - 初始化
+ (instancetype)sharedKit
{
    static dispatch_once_t pred;
    static HClassManager *o = nil;

    dispatch_once(&pred, ^{ o = [[self alloc] init]; });
    return o;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _classIndex = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - 静态方法
+ (void)registerClass:(Class)aclass forkey:(NSString *)key
{
    [[self sharedKit] registerClass:aclass forkey:key];
}

+ (void)registerClass:(Class)aclass forkey:(NSString *)key userInfo:(id)userInfo
{
    [[self sharedKit] registerClass:aclass forkey:key userInfo:userInfo];
}
+ (void)registerClass:(Class)aclass forProtocal:(Protocol *)protocal
{
    NSString *key = [NSString stringWithFormat:@"%@RegKey", NSStringFromProtocol(protocal)];
    [[self sharedKit] registerClass:aclass forkey:key];
}
+ (void)registerClass:(Class)aclass forProtocal:(Protocol *)protocal creator:(NSString *)creator
{
    NSString *key = [NSString stringWithFormat:@"%@RegKey", NSStringFromProtocol(protocal)];
    [[self sharedKit] registerClass:aclass forkey:key userInfo:@{HClassCreatorKey:creator}];
}
+ (void)scanClassNameForKey:(NSString *)key fetchblock:(HClassNameFetchBlock)block
{
    NSSet *targetClasses = [[self sharedKit] getClassesForKey:key];
    [targetClasses enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isKindOfClass:[HClassContainner class]])
        {
            HClassContainner *contanner = (HClassContainner *)obj;
            if (block)
            {
                block(contanner.containClassName,contanner.userInfo);
            }
        }
        else if([obj isKindOfClass:[NSString class]])
        {
            if (block)
            {
                block(obj,nil);
            }
        }
    }];
}
+ (void)scanClassForKey:(NSString *)key fetchblock:(HClassFetchBlock)block
{
    [self scanClassNameForKey:key fetchblock:^(NSString *aclassName, id userInfo) {
        block(NSClassFromString(aclassName), userInfo);
    }];
}
+ (NSString *)getClassNameForKey:(NSString *)key
{
    __block NSString *className = nil;
    NSSet *targetClasses = [[self sharedKit] getClassesForKey:key];
    NSAssert(targetClasses.count <= 1, ([NSString stringWithFormat:@"exsit one more %@", key]));
    [targetClasses enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isKindOfClass:[HClassContainner class]])
        {
            HClassContainner *contanner = (HClassContainner *)obj;
            className = contanner.containClassName;
            *stop = YES;
        }
        else if([obj isKindOfClass:[NSString class]])
        {
            className = obj;
            *stop = YES;
        }
    }];
    return className;
}
+ (id)getObjectOfProtocal:(Protocol *)protocal
{
    NSString *key = [NSString stringWithFormat:@"%@RegKey", NSStringFromProtocol(protocal)];

    __block NSString *className = nil;
    __block NSString *creator = nil;

    NSSet *targetClasses = [[self sharedKit] getClassesForKey:key];
    NSAssert(targetClasses.count <= 1, ([NSString stringWithFormat:@"exsit one more %@", key]));
    [targetClasses enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        if ([obj isKindOfClass:[HClassContainner class]])
        {
            HClassContainner *contanner = (HClassContainner *)obj;
            className = contanner.containClassName;
            creator = contanner.userInfo[HClassCreatorKey];
            *stop = YES;
        }
        else if([obj isKindOfClass:[NSString class]])
        {
            className = obj;
            *stop = YES;
        }
    }];

    if (!className) return nil;
    Class class = NSClassFromString(className);
    if (!class) return nil;

    id obj = nil;
    if (!creator)
    {
        obj = [class new];
    }
    else
    {
        SuppressPerformSelectorLeakWarning(
        obj = [class performSelector:NSSelectorFromString(@"shareInstance")];
        );

    }
    if (![obj conformsToProtocol:protocal]) return nil;
    return obj;
}
+ (void)removeClassForKey:(NSString *)key
{
    [[self sharedKit] removeClassForKey:key];
}

#pragma mark - 逻辑
- (void)registerClass:(Class)aclass forkey:(NSString *)key
{
    if(!key || !aclass || key.length == 0) return;
    NSMutableSet *classKeySet = [_classIndex objectForKey:key];
    if(!classKeySet) classKeySet = [[NSMutableSet alloc] init];
    if (![classKeySet containsObject:aclass])
    {
        [classKeySet addObject:NSStringFromClass(aclass)];
    }
    [_classIndex setObject:classKeySet forKey:key];
}

- (void)registerClass:(Class)aclass forkey:(NSString *)key userInfo:(id)userInfo
{
    if(!key || !aclass || key.length == 0) return;
    NSMutableSet *classKeySet = [_classIndex objectForKey:key];
    if(!classKeySet) classKeySet = [[NSMutableSet alloc] init];
    if (![classKeySet containsObject:aclass])
    {
        if(userInfo)
        {
            HClassContainner *contanner = [HClassContainner new];
            contanner.containClassName = NSStringFromClass(aclass);
            contanner.userInfo = userInfo;
            [classKeySet addObject:contanner];
        }
        else
        {
            [classKeySet addObject:NSStringFromClass(aclass)];
        }
    }
    [_classIndex setObject:classKeySet forKey:key];
}

- (NSSet *)getClassesForKey:(NSString *)key
{
    if (key == nil) return nil;
    return [_classIndex objectForKey:key];
}

- (void)removeClassForKey:(NSString *)key
{
    [_classIndex removeObjectForKey:key];
}

@end


@implementation HClassContainner

@end

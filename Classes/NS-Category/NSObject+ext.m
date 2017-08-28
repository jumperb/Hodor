//
//  NSObject+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-4-21.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSObject+ext.h"
#import <objc/runtime.h>

@interface NSString (DLIntrospection)

+ (NSString *)decodeType:(const char *)cString;

@end

@implementation NSString (DLIntrospection)

//https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
+ (NSString *)decodeType:(const char *)cString {
    if (!strcmp(cString, @encode(id))) return @"id";
    if (!strcmp(cString, @encode(void))) return @"void";
    if (!strcmp(cString, @encode(float))) return @"float";
    if (!strcmp(cString, @encode(int))) return @"int";
    if (!strcmp(cString, @encode(BOOL))) return @"BOOL";
    if (!strcmp(cString, @encode(char *))) return @"char *";
    if (!strcmp(cString, @encode(double))) return @"double";
    if (!strcmp(cString, @encode(Class))) return @"class";
    if (!strcmp(cString, @encode(SEL))) return @"SEL";
    if (!strcmp(cString, @encode(unsigned int))) return @"unsigned int";
    
    //@TODO: do handle bitmasks
    NSString *result = [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
    if ([[result substringToIndex:1] isEqualToString:@"@"] && [result rangeOfString:@"?"].location == NSNotFound) {
        result = [[result substringWithRange:NSMakeRange(2, result.length - 3)] stringByAppendingString:@""];
    } else
        if ([[result substringToIndex:1] isEqualToString:@"^"]) {
            result = [NSString stringWithFormat:@"%@ *",
                      [NSString decodeType:[[result substringFromIndex:1] cStringUsingEncoding:NSUTF8StringEncoding]]];
        }
    return result;
}

@end


@implementation NSObject (ext)


- (id)serialization
{
    if([NSObject isSerializationObject:self]) return self;
    NSArray *properties = [NSObject depPPListOfClass:self.class];
    if (properties.count)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (NSString *key in properties)
        {
            id value = [self valueForKey:key];
            if (value && value != [NSNull null])
            {
                if([NSObject isSerializationObject:value])
                {
                    [dict setValue:value forKey:key];
                }
                else
                {
                    [dict setValue:[value serialization] forKey:key];
                }
            }
        }
        return dict;
    }
    else return NSStringFromClass([self class]);
}

+ (BOOL)isSerializationObject:(id)object
{
    if([object isKindOfClass:[NSString class]])
    {
        return YES;
    }
    else if([object isKindOfClass:[NSNumber class]])
    {
        return YES;
    }
    else if([object isKindOfClass:[NSArray class]])
    {
        return YES;
    }
    else if([object isKindOfClass:[NSDictionary class]])
    {
        return YES;
    }
    else if([object isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else return NO;
}

- (NSArray *)ppList
{
    return [NSObject ppListOfClass:self.class];
}

+ (NSArray *)ppListOfClass:(Class)theClass
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    unsigned int count, i;
    objc_property_t *properties = class_copyPropertyList(theClass, &count);
    if (count)
    {
        for (i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([key isEqualToString:@"hash"]) continue;
            else if ([key isEqualToString:@"superclass"]) continue;
            else if ([key isEqualToString:@"description"]) continue;
            else if ([key isEqualToString:@"debugDescription"]) continue;
            [list addObject:key];
        }
    }
    free(properties);
    return list;
}

+ (NSArray *)depPPListOfClass:(Class)theClass
{
    NSMutableArray *depPPlist = [NSMutableArray new];
    while (theClass != [NSObject class]) {
        NSArray *pplist = [NSObject ppListOfClass:theClass];
        [depPPlist addObjectsFromArray:pplist];
        theClass = class_getSuperclass(theClass);
    }
    return depPPlist;
}

- (NSString *)jsonString
{
    return [[self serialization] jsonString];
}

- (instancetype)initWithSerializedData:(id)data
{
    self = [self init];
    if (self)
    {
        setObjectWithSerializedData(self, data);
    }
    return self;
}

+ (void)methodSwizzleWithClass:(Class)c origSEL:(SEL)origSEL overrideSEL:(SEL)overrideSEL
{
    Method origMethod = class_getInstanceMethod(c, origSEL);
    Method overrideMethod= class_getInstanceMethod(c, overrideSEL);
    if(class_addMethod(c, origSEL, method_getImplementation(overrideMethod),method_getTypeEncoding(overrideMethod)))
    {
        class_replaceMethod(c,overrideSEL, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    }
    else
    {
        method_exchangeImplementations(origMethod,overrideMethod);
    }
}


- (void)extendInvoke:(NSString *)invokeString withPre:(NSString *)preTag withMethodArgments:(void *)firstParameter, ...
{
    //deal the type and function name
    NSArray * clsArr = [invokeString componentsSeparatedByString:@" "];
    BOOL isClassMethod = [[invokeString substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"+"];
    NSString * clsStr = [clsArr[0] substringFromIndex:2];
    NSString * methodString = clsArr[1];
    NSString * methodName = [clsArr[1] substringToIndex:methodString.length-1];
    NSUInteger kuohaoLocation = [clsStr rangeOfString:@"("].location;
    if (kuohaoLocation != NSNotFound)
    {
        clsStr = [clsStr substringToIndex:kuohaoLocation];
    }
    Class cls = NSClassFromString(clsStr);
    if (isClassMethod)
    {
        cls = objc_getMetaClass([clsStr cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    unsigned int count = 0;
    Method *methods = class_copyMethodList(cls, &count);
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        NSString * nMethodName = [NSString stringWithFormat:@"_%@",methodName];
        
        if ([name hasSuffix:nMethodName])
        {
            NSMethodSignature * sig = [cls instanceMethodSignatureForSelector:selector];
            NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:sig];
            [invocation setTarget:self];
            [invocation setSelector:selector];
            //if it has params
            if (sig.numberOfArguments > 2)
            {
                [invocation setArgument:firstParameter atIndex:2];
                va_list arg_ptr;
                va_start(arg_ptr, firstParameter);
                for (NSUInteger i = 3; i < sig.numberOfArguments; i++)
                {
                    void * parameter = va_arg(arg_ptr, void *);
                    [invocation setArgument:parameter atIndex:i];
                }
                va_end(arg_ptr);
            }
            [invocation invoke];
        }
    }
    
    free(methods);
}



@end

void setObjectWithSerializedData(NSObject *object ,id data)
{
    if ([data isKindOfClass:[NSDictionary class]])
    {
        unsigned int outCount, i;
        objc_property_t *properties = class_copyPropertyList([object class], &outCount);
        for (i = 0; i < outCount; i++)
        {
            objc_property_t property = properties[i];
            NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if ([key isEqualToString:@"hash"]) continue;
            else if ([key isEqualToString:@"superclass"]) continue;
            else if ([key isEqualToString:@"description"]) continue;
            else if ([key isEqualToString:@"debugDescription"]) continue;
            id value = data[key];
            if (value)
            {
                [object setValue:value forKey:key];
            }
        }
    }
}

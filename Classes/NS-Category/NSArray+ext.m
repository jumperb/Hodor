//
//  NSArray+ext.m
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "NSArray+ext.h"
#import "NSObject+ext.h"

@implementation NSArray (ext)

- (id)objectForKey:(id)aKey
{
    return nil;
}
// cann't open this function, because it will cause a crash on coredata
//- (id)valueForKey:(NSString *)key
// {
//    return [NSNull null];
// }
- (id)serialization
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id value in self)
    {
        if (value && value != [NSNull null])
        {
            [arr addObject:[value serialization]];
        }
    }
    return arr;
}
- (NSString *)h_jsonString
{
    if([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:0
                                                             error:&error];

        if ([jsonData length] > 0 && error == nil)
        {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        NSArray *arr2 = [self serialization];
        if([NSJSONSerialization isValidJSONObject:arr2]) {
            return [arr2 h_jsonString];
        }
        else {
            NSAssert(NO, @"json encode fail");
            return nil;
        }
    }
}
@end

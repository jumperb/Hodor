//
//  NSDictionary+ext.m
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "NSDictionary+ext.h"
#import "NSObject+ext.h"
#import "NSString+ext.h"

@implementation NSDictionary (ext)
- (id)objectAtIndex:(NSUInteger)idx
{
    return nil;
}
- (id)serialization
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *key in self)
    {
        id value = [self objectForKey:key];
        if (value && value != [NSNull null])
        {
            if([NSObject isSerializationObject:value])
            {
                [dict setValue:value forKey:[key stringValue]];
            }
            else
            {
                [dict setValue:[value serialization] forKey:[key stringValue]];
            }
        }
    }
    return dict;
}
- (NSString *)jsonString
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
        NSDictionary *dict2 = [self serialization];
        if([NSJSONSerialization isValidJSONObject:dict2]) {
            return [dict2 jsonString];
        }
        else {
            NSAssert(NO, @"json encode fail");
            return nil;
        }
    }
}
@end

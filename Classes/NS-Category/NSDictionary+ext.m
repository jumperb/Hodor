//
//  NSDictionary+ext.m
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "NSDictionary+ext.h"
#import "NSObject+ext.h"

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
        NSMutableString *str = [[NSMutableString alloc] init];
        [str appendString:@"{"];
        int index = 0;
        for(id key in self)
        {
            id obj = [self objectForKey:key];
            if([NSJSONSerialization isValidJSONObject:obj])
            {
                NSError *error = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                                   options:0
                                                                     error:&error];
                [str appendFormat:@"\"%@\":%@",key,[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            }
            else if([obj isKindOfClass:[NSString class]])
            {
                [str appendFormat:@"\"%@\":\"%@\"",key,obj];
            }
            else if([obj isKindOfClass:[NSNumber class]])
            {
                if (strcmp([obj objCType], @encode(float)) == 0)
                {
                    [str appendFormat:@"\"%@\":%f",key,[obj floatValue]];
                }
                else if (strcmp([obj objCType], @encode(double)) == 0)
                {
                    [str appendFormat:@"\"%@\":%f",key,[obj doubleValue]];
                }
                else if (strcmp([obj objCType], @encode(long)) == 0)
                {
                    [str appendFormat:@"\"%@\":%ld",key,[obj longValue]];
                }
                else
                {
                    [str appendFormat:@"\"%@\":%d",key,[obj intValue]];
                }
            }
            else if([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])
            {
                [str appendFormat:@"\"%@\":%@",key,[obj jsonString]];
            }
            else if([obj isKindOfClass:[NSData class]])
            {
                //ignore
            }
            else [str appendFormat:@"\"%@\":%@",key,[[[self objectForKey:key] serialization] jsonString]];
            if(index != self.count - 1)[str appendString:@","];
            index ++;
        }
        [str appendString:@"}"];
        return str;
    }
}
@end

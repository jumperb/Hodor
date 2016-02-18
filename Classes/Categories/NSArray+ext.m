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

- (NSString *)jsonString
{
    if([NSJSONSerialization isValidJSONObject:self])
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                           options:NSJSONWritingPrettyPrinted
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
        [str appendString:@"["];
        int index = 0;
        for(id obj in self)
        {
            if([NSJSONSerialization isValidJSONObject:obj])
            {
                NSError *error = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj
                                                                   options:NSJSONWritingPrettyPrinted
                                                                     error:&error];
                [str appendString:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
            }
            else if([obj isKindOfClass:[NSString class]])
            {
                [str appendFormat:@"\"%@\"",obj];
            }
            else if([obj isKindOfClass:[NSNumber class]])
            {
                [str appendFormat:@"%d",[obj intValue]];
            }
            else if([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])
            {
                [str appendString:[obj jsonString]];
            }
            else if([obj isKindOfClass:[NSData class]])
            {
                //ignore
            }
            else [str appendString:[[obj serialization] jsonString]];
            if(index != self.count - 1)[str appendString:@","];
            index ++;
        }
        [str appendString:@"]"];
        return str;
    }
}
@end

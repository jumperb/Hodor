//
//  NSNull+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-4-22.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSNull+ext.h"

@implementation NSNull (ext)
- (NSInteger)intValue
{
    return 0;
}

- (long)longValue
{
    return 0;
}
- (long)longLongValue
{
    return 0;
}
- (CGFloat)floatValue
{
    return 0;
}

- (NSString *)stringValue
{
    return @"";
}

- (BOOL)boolValue
{
    return NO;
}
- (char)charValue
{
    return 0;
}
- (NSInteger)count
{
    return 0;
}

- (id)objectAtIndex:(NSInteger)index
{
    return nil;
}

- (NSInteger)length
{
    return 0;
}

- (id)objectForKey:(id)aKey
{
    return nil;
}

- (id)valueForKey:(id)aKey
{
    return nil;
}

- (NSString *)description
{
    return @"NSNull";
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len
{
    return 0;
}

- (NSString *)jsonString
{
    return @"null";
}
@end

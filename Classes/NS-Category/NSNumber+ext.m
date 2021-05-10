//
//  NSNumber+ext.m
//  HFramework
//
//  Created by zhangchutian on 14-6-7.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import "NSNumber+ext.h"

@implementation NSNumber (ext)
- (NSString *)h_jsonString
{
    return [self stringValue];
}
- (id)serialization {
    return self;
}
@end

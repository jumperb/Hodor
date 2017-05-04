//
//  NSError+ext.m
//  SinaShuCheng
//
//  Created by 火辣先生 on 13-6-5.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import "NSError+ext.h"

const int kCodeOK = 200;
const int kInnerErrorCode = -1023;
const int kCancelCode = -1022;
const int kDataFormatErrorCode = -1024;
const int kNetWorkErrorCode = -1025;
const int kLogicErrorCode = -1026;
const int kNoDataErrorCode = -1027;
const int kAsyncCanelErrorCode = -1029;

@implementation NSError (ext)

+ (instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code
{
    domain = domain ?: @"";
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}


+ (instancetype)errorWithDomain:(NSString *)domain code:(NSInteger)code description:(NSString *)description
{
    domain = domain ?: @"";
    description = description ?: @"";
    return [NSError errorWithDomain:domain code:code userInfo:@{NSLocalizedDescriptionKey : description}];
}


+ (instancetype)errorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason
{
    domain = domain ?: @"";
    description = description ?: @"";
    reason = reason ?: @"";
    NSDictionary *dict = @{NSLocalizedDescriptionKey : description, NSLocalizedFailureReasonErrorKey : reason};
    return [NSError errorWithDomain:domain
                               code:code
                           userInfo:dict];
}
@end

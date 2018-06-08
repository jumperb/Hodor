//
//  NSURL+ext.m
//  Hodor
//
//  Created by zct on 2018/6/8.
//  Copyright © 2018年 zhangchutian. All rights reserved.
//

#import "NSURL+ext.h"
#import "NSString+ext.h"

@implementation NSURL (ext)

- (NSDictionary *)parameterMap
{
    NSString *paramsString = self.parameterString;
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSArray *segments = [paramsString componentsSeparatedByString:@"&"];
    for(NSString *segment in segments)
    {
        NSArray *kv = [segment componentsSeparatedByString:@"="];
        if (kv.count >= 2)
        {
            NSString *key = [kv[0] decode];
            NSString *value = [kv[1] decode];
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}
@end

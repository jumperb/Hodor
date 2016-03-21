//
//  TestObj.m
//  Hodor
//
//  Created by zhangchutian on 16/1/28.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "TestObj.h"
#import "HCommon.h"

@implementation AClass
- (void)dealloc
{
    NSLog(@"A Dealloc");
}
@end


@implementation BClass
- (void)dealloc
{
    NSLog(@"B Dealloc");
}
@end
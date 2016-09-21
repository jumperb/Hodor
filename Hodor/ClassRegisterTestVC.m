//
//  ClassRegisterTestVC.m
//  Hodor
//
//  Created by zhangchutian on 16/2/18.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "ClassRegisterTestVC.h"
#import "HClassManager.h"

@implementation ClassRegisterTestVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Class Register";
        [self addMenu:@"search all subClass" callback:^(id sender, id data) {
            [HClassManager scanClassForKey:AClassRegKey fetchblock:^(__unsafe_unretained Class aclass, id userInfo) {
                NSLog(@"get sub class: %@, userInfo:%@", NSStringFromClass(aclass), userInfo);
            }];
        }];
        
        [self addMenu:@"search all protocal implement" callback:^(id sender, id data) {
            [HClassManager scanClassNameForKey:TestProRegKey fetchblock:^(NSString *aclassName, id userInfo) {
                NSLog(@"get implement class: %@, userInfo:%@", aclassName, userInfo);
            }];
        }];

        [self addMenu:@"search singleton implement" callback:^(id sender, id data) {
            id<TestPro2> obj = [HClassManager getObjectOfProtocal:@protocol(TestPro2)];
            NSLog(@"direct invoke shareInstance : %@", [E shareInstance]);
            NSLog(@"searched obj : %@", obj);

        }];
    }
    return self;
}
@end

@implementation A

@end

@implementation B
HReg3(AClassRegKey, HRegInfo(TestProRegKey, @"some attr"))
@end

@implementation C
HReg2(AClassRegKey, @{@"attr":@"value"})
@end

@implementation D
HReg(TestProRegKey)
@end


@implementation E

HRegForProtocalAsSingleton(@protocol(TestPro2), @"shareInstance")

+ (instancetype)shareInstance
{
    static dispatch_once_t pred;
    static E *o = nil;

    dispatch_once(&pred, ^{ o = [[self alloc] init]; });
    return o;
}


@end
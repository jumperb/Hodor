//
//  ClassRegisterTestVC.m
//  Hodor
//
//  Created by zhangchutian on 16/2/18.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "ClassRegisterTestVC.h"
#import "HClassManager.h"
#import "NSObject+ext.h"
#import "HDefines.h"


@implementation ClassRegisterTestVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Class Register";
        [self addMenu:@"search all subClass" callback:^(id sender, id data) {
            [HClassManager scanClassForKey:ClassARegKey fetchblock:^(__unsafe_unretained Class aclass, id userInfo) {
                NSLog(@"get sub class: %@, userInfo:%@", NSStringFromClass(aclass), userInfo);
            }];
        }];
        
        [self addMenu:@"search all subClass contain key" callback:^(id sender, id data) {
            [HClassManager scanClassContainKey:@"ACla" fetchblock:^(__unsafe_unretained Class aclass, id userInfo) {
                NSLog(@"get sub class: %@, userInfo:%@", NSStringFromClass(aclass), userInfo);
            }];
        }];
        
        [self addMenu:@"search all protocal implement" callback:^(id sender, id data) {
            //get a key of a protocol, if your protocal has only one imp, you can directly use "getObjectOfProtocal" or "HProtocalInstance"
            NSString *key = HProtocalRegKey(XProtocol);
            [HClassManager scanClassNameForKey:key fetchblock:^(NSString *aclassName, id userInfo) {
                NSLog(@"get implement class: %@, userInfo:%@", aclassName, userInfo);
            }];
        }];

        [self addMenu:@"search singleton implement" callback:^(id sender, id data) {
            NSLog(@"direct invoke shareInstance : %@", [ClassE shareInstance]);
            NSLog(@"searched obj : %@", HProtocalInstance(YProtocol));
            [HProtocalInstance(YProtocol) testFun];
        }];
        
        [self addMenu:@"auto dependence inset" callback:^(id sender, id data) {
            ClassG *gObj = [ClassG new];
            
            /*
            ClassA *aObj = [ClassA new];
            
            ClassE *eObj = [ClassE new];
            
            ClassF *fObj = [ClassF new];
            fObj.py = eObj;
            fObj.pw = aObj;
            
            gObj.pz = fObj;
            */
            
            [gObj dependenceInset]; //this function can replace the codes above
            NSLog(@"%@", [gObj h_jsonString]);
        }];
    }
    return self;
}
@end

@implementation ClassA
//tell HClassManager Im a IMP of WProtocol
HRegForProtocal(WProtocal)
@end

@implementation ClassB
//tell HClassManager Im a sub class of ClassA, and im a IMP of  XProtocol, then I has some other property
HReg3(ClassARegKey, HProtocalRegKey(XProtocol), HRegInfo(@"somekey", @"userinfo"))
@end

@implementation ClassC
HReg2(ClassARegKey, @{@"attr":@"value"})
@end

@implementation ClassD
HRegForProtocal(XProtocol)
@end


@implementation ClassE
//tell HClassManager Im a IMP of YProtocol, and use "shareInstance" to get an object
HRegForProtocalAsSingleton(YProtocol, @"shareInstance")

+ (instancetype)shareInstance
{
    static dispatch_once_t pred;
    static ClassE *o = nil;
    dispatch_once(&pred, ^{ o = [[self alloc] init]; });
    return o;
}

- (void)testFun
{
    NSLog(@"testFun");
}
@end


@implementation ClassF
HRegForProtocal(ZProtocal)
@end

@implementation ClassG
@end

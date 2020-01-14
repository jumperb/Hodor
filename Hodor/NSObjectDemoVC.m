//
//  NSObjectDemoVC.m
//  Hodor
//
//  Created by xmx on 16/1/4.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "NSObjectDemoVC.h"
#import "NSObject+ext.h"
#import "AppDelegate.h"
#import "TestObj.h"

@interface NSObjectDemoVC ()

@end

@implementation NSObjectDemoVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"NSObject + ext";
        [self addMenu:@"extend dispatch invoke" callback:^(id sender, id data) {
            NSLog(@"see -[appDelegate:didFinishLaunchingWithOptions:],  the invoke has dispatch to some modules");
        }];
        [self addMenu:@"serialization test" callback:^(id sender, id data) {
            CClass *c = [CClass new];
            c.pBool = YES;
            c.pStr = @"ccc";
            c.pNumber = @(5);
            NSLog(@"%@", [c serialization]);
        }];
        
        [self addMenu:@"serialization test2 NSURL" callback:^(id sender, id data) {
            NSLog(@"%@", [[NSURL new] serialization]);
        }];
        
        [self addMenu:@"json string test" callback:^(id sender, id data) {
            CClass *c = [CClass new];
            c.pBool = YES;
            c.pStr = @"cc%c\",123)";
            c.pNumber = @(5);
            NSLog(@"%@", [c jsonString]);
        }];
        
        [self addMenu:@"json string test2" callback:^(id sender, id data) {
            CClass *c = [CClass new];
            c.pBool = YES;
            c.pStr = @"cc%c\",123)";
            c.pNumber = @(5);
            NSDictionary *dict = @{@(6): [AClass new]};
            c.dict = dict;
            NSLog(@"%@", [c jsonString]);
        }];
        
        [self addMenu:@"@weakify test" callback:^(id sender, id data) {
            AClass *a  = [AClass new];
            BClass *b = [BClass new];
            b.a = a;
            @weakify(b);
            a.ablock = ^(id sender, id data){
                @strongify(b);
                NSLog(@"%@", b);
            };
        }];
    }
    return self;
}

@end



@implementation AppDelegate (moduleA)

- (BOOL)moduleA_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"## moduleA extend 'someClassMethod'");
    return YES;
}

+ (void)moduleA_someClassMethod
{
    NSLog(@"## moduleA extend 'someClassMethod'");
}
@end


@implementation AppDelegate (moduleB)

- (BOOL)moduleB_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"## moduleB extent 'didFinishLaunchingWithOptions'");
    return YES;
}
+ (void)moduleB_someClassMethod
{
    NSLog(@"## moduleB extend 'someClassMethod'");
}
@end




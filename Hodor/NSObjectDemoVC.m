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
    NSLog(@"## moduleA extend 'didFinishLaunchingWithOptions'");
    return YES;
}
@end


@implementation AppDelegate (moduleB)

- (BOOL)moduleB_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"## moduleB extent 'didFinishLaunchingWithOptions'");
    return YES;
}
@end


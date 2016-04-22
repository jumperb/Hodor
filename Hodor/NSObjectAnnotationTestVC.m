//
//  NSObjectAnnotationTestVC.m
//  Hodor
//
//  Created by zhangchutian on 16/2/17.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "NSObjectAnnotationTestVC.h"
#import "NSObject+annotation.h"
#import "NSObject+ext.h"
#import <objc/runtime.h>

@implementation NSObjectAnnotationTestVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Annotation Test";
        [self addMenu:@"Get Class Annotation" callback:^(id sender, id data) {
            NSLog(@"just use protocal as the annotation, haha");
        }];
        
        [self addMenu:@"Get Property Annotation" callback:^(id sender, id data) {
            
            Class theClass = [AnnotationTestObj class];
            while (theClass != [NSObject class]) {
                NSArray *ppList = [NSObject ppListOfClass:theClass];
                for (NSString *ppName in ppList)
                {
                    NSArray *ants = [theClass annotations:ppName];
                    if (ants) NSLog(@"property:%@ annotations:%@", ppName, ants);
                }
                theClass = class_getSuperclass(theClass);

                NSArray *instanceMethods = [NSObject hInstanceMethodNames:theClass];
                NSArray *classMethods = [NSObject hClassMethodNames:theClass];
                NSArray *methods = [instanceMethods arrayByAddingObjectsFromArray:classMethods];
                for (NSString *name in methods)
                {
                    NSArray *ants = [theClass annotations:hFormateAnnotationName(name)];
                    if (ants) NSLog(@"function:%@ annotations:%@", name, ants);
                }
                theClass = class_getSuperclass(theClass);
            }
            
        }];
        
        [self addMenu:@"Get function Annotation" callback:^(id sender, id data) {
            
            Class theClass = [AnnotationTestObj class];
            while (theClass != [NSObject class]) {
                NSArray *instanceMethods = [NSObject hInstanceMethodNames:theClass];
                NSArray *classMethods = [NSObject hClassMethodNames:theClass];
                NSArray *methods = [instanceMethods arrayByAddingObjectsFromArray:classMethods];
                for (NSString *name in methods)
                {
                    NSArray *ants = [theClass annotations:hFormateAnnotationName(name)];
                    if (ants) NSLog(@"function:%@ annotations:%@", name, ants);
                }
                theClass = class_getSuperclass(theClass);
            }
            
        }];
    }
    return self;
}

@end



@implementation AnnotationTestObj

ppx(str, @"a", @(1), @[@"c",@"d"], @{@"e":@(2)})
ppx(ID, @"f")
ppx(c, @"g")
ppx(p,@(2))

ppx(func1, @[@"h",@"i"])
- (void)func1
{
    
}

ppx(func2_withb_, @{@"j":@"k"})
- (void)func2:(int)a withb:(NSString *)b;
{
    
}

ppx(func3, @(5))
+ (void)func3
{
    
}

- (void)func4
{
    
}
@end


@implementation AnnotationTestObj2
ppx(str2, @"t");


ppx(func5, @"s");
- (void)func5
{
    
}
@end
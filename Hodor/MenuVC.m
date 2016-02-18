//
//  MuenVC.m
//  Hodor
//
//  Created by zhangchutian on 14/12/2.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import "MenuVC.h"
#import "UIImageDemoVC.h"
#import "UILabelDemoVC.h"
#import "HGCDExtTestVC.h"
#import "NSObjectDemoVC.h"
#import "NSObjectAnnotationTestVC.h"
#import "ClassRegisterTestVC.h"

@implementation MenuVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"MENU";
        @weakify(self);
        
        [self addMenu:@"Class Register test" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[ClassRegisterTestVC new] animated:YES];
        }];
        
        [self addMenu:@"Annotation test" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[NSObjectAnnotationTestVC new] animated:YES];
        }];
        
        [self addMenu:@"GCD Ext test" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[HGCDextTestVC new] animated:YES];
        }];
        
        [self addMenu:@"NSObject+ext test" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[NSObjectDemoVC new] animated:YES];
        }];
        [self addMenu:@"UIImage+ext test" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[UIImageDemoVC new] animated:YES];
        }];
        [self addMenu:@"UILabel+ext" callback:^(id sender, id data) {
            @strongify(self);
            [self.navigationController pushViewController:[UILabelDemoVC new] animated:YES];
        }];
        
        
        
        
        
    }
    return self;
}


@end

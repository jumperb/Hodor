//
//  NSObjectAnnotationTestVC.h
//  Hodor
//
//  Created by zhangchutian on 16/2/17.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "HTestVC.h"

@interface NSObjectAnnotationTestVC : HTestVC

@end


@interface AnnotationTestObj : NSNumber
@property (nonatomic) NSString *str;
@property (nonatomic) id ID;
@property (nonatomic) char c;
@property (nonatomic) int *p;
@property (nonatomic) BOOL b;

- (void)func1;
- (void)func2:(int)a withb:(NSString *)b;
+ (void)func3;
- (void)func4;
@end


@interface AnnotationTestObj2 : AnnotationTestObj
@property (nonatomic) NSString *str2;
@end
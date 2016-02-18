//
//  NSObject+annotation.h
//  Hodor
//
//  Created by zhangchutian on 16/1/17.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ppx(n, ...) \
+ (NSArray *)ppx_support_##n\
{\
return @[__VA_ARGS__];\
}


/**
 *  annotation support
 *  if your set a annotation to a function like 'func:a:b:'
 *  you need change it to func_a_b_ by hFormateAnnotationName , and use it as annotation name
 *  like this ppx(func_a_b_, *, *, *)
 */
@interface NSObject (annotation)

//get annotation data， it is rude data , you need formate it yourself before use it
+ (NSArray *)annotations:(NSString *)key;

//get all instance method names, you need deal the inheritance relationships by yourself
+ (NSArray *)hInstanceMethodNames:(Class)klass;

//get all class method names, you need deal the inheritance relationships by yourself
+ (NSArray *)hClassMethodNames:(Class)klass;

@end

//convert function name to valide annotation name by replace ':' to '_'
NSString *hFormateAnnotationName(NSString *functionName);


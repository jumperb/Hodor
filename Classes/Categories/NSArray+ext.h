//
//  NSArray+ext.h
//  SinaShuCheng
//
//  Created by leikun on 13-7-16.
//  Copyright (c) 2013年 iTotemStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ext)
- (id)objectForKey:(id)aKey;
// cann't open this function, because it will cause a crash on coredata
//- (id)valueForKey:(NSString *)key;
@end

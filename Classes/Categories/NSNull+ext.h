//
//  NSNull+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-4-22.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// is null 
#define isNull(object) (object == nil || (id)object == [NSNull null])

@interface NSNull (ext)
- (NSInteger)intValue;
- (long)longValue;
- (long)longLongValue;
- (CGFloat)floatValue;
- (NSString *)stringValue;
- (BOOL)boolValue;
- (char)charValue;
- (NSInteger)count;
- (id)objectAtIndex:(NSInteger)index;
- (NSInteger)length;
- (id)objectForKey:(id)aKey;
- (id)valueForKey:(id)aKey;
- (NSString *)description;
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)stackbuf count:(NSUInteger)len;
@end

//
//  NSObject+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-4-21.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>

// prevent performSelector warning
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/** 
* extend dispatch invoke
* batch invoke methods of some pattern, these methods always in some categorys in some module
* @param invokeString stringfromSelector，like -[className funcName]，we use '__func__'
* @param preTag       preTag.  default is '_'
*                     eg: faction '-init', and the preTag is 'abc',  then the function like - ***abcinit will invoked。
* @param arguments
*/
#define H_ExtendInvoke1(preTag, args...) \
{ \
NSString * methodName = [NSString stringWithFormat:@"%s", __func__]; \
[self extendInvoke:methodName withPre:preTag withMethodArgments:args];\
}
#define H_ExtendInvoke2(preTag) H_ExtendInvoke1(preTag, nil)
#define H_ExtendInvoke3(args...) H_ExtendInvoke1(@"_", args)
#define H_ExtendInvoke4 H_ExtendInvoke1(@"_", nil)


//TODO will delete
// safe copy
#define safecp(arg,value,_class) arg = value;\
if (![arg isKindOfClass:[_class class]])\
{arg = nil;}

@interface NSObject (ext)

// deserializtion
// the data is always dictionary , it will map all value to the property if the key is equal to property name
- (instancetype)initWithSerializedData:(id)data;

// serialization
// the return is always dictionary
- (id)serialization;
+ (BOOL)isSerializationObject:(id)object;

// property list
- (NSArray *)ppList;

// property list of some class
+ (NSArray *)ppListOfClass:(Class)theClass;

// property list of some class , it will iterate search
+ (NSArray *)depPPListOfClass:(Class)theClass;

// get json string
- (NSString *)jsonString;

// swap two SEL and IMP
//if origSel isn't defined, you need call respondToSelector to check if selector is exsit
+ (void)methodSwizzleWithClass:(Class)c origSEL:(SEL)origSEL overrideSEL:(SEL)overrideSEL;

/**
 *  batch invoke methods of some pattern
 *  these methods always in some categorys in some module
 *  note：the invoke sequence is ambiguous
 *
 *  @param invokeString stringfromSelector，like -[className funcName]，we use '__func__'
 *  @param preTag       preTag. default is '_'
 *                      eg: faction '-init', and the preTag is 'abc',  then the function like - ***abcinit will invoked。
 *  @param firstParameter arguments
 */
- (void)extendInvoke:(NSString *)invokeString withPre:(NSString *)preTag withMethodArgments:(void *)firstParameter, ...;

@end

/**
 *  deserializtion
 *  set the data to the object, map all value to the property if the property is equal to key
 *
 *  @param object some object
 *  @param data   data
 */
void setObjectWithSerializedData(NSObject *object ,id data);



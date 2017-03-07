//
//  NSString+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-4-1.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ext)

- (id)JSONValue;

- (NSString *)stringValue;

/**
 *  delete blank and \n at head or tail
 *
 *  @return string
 */
- (NSString *)trim;

/**
 *  MD5
 *
 *  @return md5
 */
- (NSString *)md5;

/**
 *  safe URL encode
 *  wapping CFURLCreateStringByAddingPercentEscapes
 *
 *  @return
 */
- (NSString *)encode;


/**
 *  safe URLDecode
 *
 *  @return decode
 */
- (NSString *)decode;

/**
 *  wapping boundingRectWithSize，
 *  compute text size on IOS7 is complex
 *
 *  @param font
 *  @param size
 *
 *  @return size
 */
- (CGSize)hSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)hSizeWithFont:(UIFont *)font;

/**
 *  String contains Emoji
 *
 *  @return YES/NO
 */
- (BOOL)stringContainsEmoji;

@end

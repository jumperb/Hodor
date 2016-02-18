//
//  NSData+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-4-1.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ext)

- (id)JSONValue;
/**
 *  gen CRC32 string
 *  @return string
 */
- (NSString *)crc32;

/**
 *  gen MD5
 *
 *  @return md5
 */
- (NSString *)md5;


/**
 *  hex string
 *  @return string
 */
- (NSString *)hexString;
@end

//
//  NSString+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-4-1.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSString+ext.h"
#import <CommonCrypto/CommonDigest.h>
#import "HDefines.h"

@implementation NSString (ext)

- (id)JSONValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonAnalysisError = nil;
    id res = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&jsonAnalysisError];
    if (jsonAnalysisError)
    {
        return nil;
    }
    else
    {
        return res;
    }
}


- (NSString *)stringValue
{
    return self;
}
- (long)longValue
{
    return (long)[self longLongValue];
}
- (char)charValue
{
    return [self intValue];
}
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)jsonString
{
    return self;
}

- (id)serialization
{
    return self;
}

- (NSString *)md5
{
    const char *concat_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
}

- (NSString *)encode
{
    NSString *outputStr =
    (NSString *) CFBridgingRelease(
                                   CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (__bridge CFStringRef)self,
                                                                           NULL,
                                                                           (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                           kCFStringEncodingUTF8)
                                   );
    return outputStr;
}

- (NSString *)decode
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];

    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (CGSize)hSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    if (IS_IOS7_OR_HIGHER)
    {
        return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        return [self sizeWithFont:font constrainedToSize:size];
#pragma clang diagnostic pop
    }
}
- (CGSize)hSizeWithFont:(UIFont *)font
{
    if (IS_IOS7_OR_HIGHER)
    {
        return [self sizeWithAttributes:@{NSFontAttributeName:font}];
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
        return [self sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

//判断是否有emoji
- (BOOL)stringContainsEmoji
{
    __block BOOL returnValue = NO;

    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];

                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;

                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }

                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

@end

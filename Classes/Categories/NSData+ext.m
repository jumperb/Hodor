//
//  NSData+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-4-1.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSData+ext.h"
#import "zlib.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (ext)

- (id)JSONValue
{
    NSError *jsonAnalysisError = nil;
    id res = [NSJSONSerialization JSONObjectWithData:self
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

- (NSString *)crc32
{
    uLong crc = crc32(0, NULL, 0);
    unsigned long creValue = crc32(crc, (const Bytef*)[self bytes], (uInt)[self length]);
//    char buf[16] = {0};
//    sprintf(buf, "%x", creValue);
    NSString *crctring = [[NSString alloc] initWithFormat:@"%lx", creValue];
    return crctring;
}

- (NSString *)md5
{
    const char *concat_str = self.bytes;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, (CC_LONG)strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return hash;
}

- (NSString *)hexString
{
    Byte *bytes=(Byte*)[self bytes];

    NSString *hexStr=@"";

    for(int i=0;i<[self length];i++)

    {

        NSString *newHexStr=[NSString stringWithFormat:@"%x",bytes[i]&0xff];

        if([newHexStr length]==1)

            hexStr=[NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];

        else

            hexStr=[NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        
    }
    return hexStr;
}
@end

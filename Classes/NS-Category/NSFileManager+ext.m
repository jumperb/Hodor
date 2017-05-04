//
//  NSFileManager+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-8-5.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "NSFileManager+ext.h"
#import <UIKit/UIKit.h>

#define IS_IOS8_OR_HIGHER  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@implementation NSFileManager (ext)

+ (NSString *)documentPath:(NSString *)subPath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (subPath)
        return [dir stringByAppendingFormat:@"/%@",subPath];
    else return dir;
}

+ (NSString *)cachePath:(NSString *)subPath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (subPath) return [dir stringByAppendingFormat:@"/%@",subPath];
    else return dir;
}

+ (NSString *)libPath:(NSString *)subPath
{
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (subPath) return [dir stringByAppendingFormat:@"/%@",subPath];
    else return dir;
}
+ (NSString *)tempPath:(NSString *)subPath
{
    NSString *dir = NSTemporaryDirectory();
    if (subPath) return [dir stringByAppendingFormat:@"%@",subPath];
    else return dir;
}


+ (NSString *)sharePath:(NSString *)subPath appGroup:(NSString *)appGroup
{
    if (IS_IOS8_OR_HIGHER)
    {
        static NSURL *dirURL = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            dirURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:appGroup];
        });
        NSString *dir = dirURL.path;


        if (dir)
        {
            if (subPath)
            {
                return [dir stringByAppendingFormat:@"/%@", subPath];
            }
            else
            {
                return dir;
            }
        }
        else
        {
            return [self libPath:subPath];
        }
    }
    else
    {
        return [self libPath:subPath];
    }
}


- (BOOL)copyItemAtPath:(NSString *)srcPath
                toPath:(NSString *)dstPath
            atomically:(BOOL)atomically
           isOverwrite:(BOOL)overwrite
                 error:(NSError **)error
{
    if (!srcPath || !dstPath)
    {
        return NO;
    }

    if (!atomically)
    {
        return [self copyItemAtPath:srcPath toPath:dstPath error:error];
    }
    NSString *dstPathTemp = [dstPath stringByAppendingString:@".temp"];
    //1.delete tmp file/dir
    [self removeItemAtPath:dstPathTemp error:nil];
    //2.copy to tmp file/dir
    BOOL res = [self copyItemAtPath:srcPath toPath:dstPathTemp error:error];
    if (!res)
    {
        //copy error，remove tmp file/dir
        [self removeItemAtPath:dstPathTemp error:nil];
        return res;
    }
    //3.rename
    if (overwrite)
    {
        if ([self fileExistsAtPath:dstPath])
        {
            [self removeItemAtPath:dstPath error:nil];
        }
    }
    return [self moveItemAtPath:dstPathTemp toPath:dstPath error:error];
}


- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath atomically:(BOOL)atomically error:(NSError **)error
{
    if (!atomically)
    {
        return [self copyItemAtPath:srcPath toPath:dstPath error:error];
    }
    NSString *dstPathTemp = [dstPath stringByAppendingString:@".temp"];
    //1.delete tmp file/dir
    [self removeItemAtPath:dstPathTemp error:nil];
    //2.copy to tmp file/dir
    BOOL res = [self copyItemAtPath:srcPath toPath:dstPathTemp error:error];
    if (!res)
    {
        //copy error，remove tmp file/dir
        [self removeItemAtPath:dstPathTemp error:nil];
        return res;
    }
    //3.rename
    return [self moveItemAtPath:dstPathTemp toPath:dstPath error:error];
}

- (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL atomically:(BOOL)atomically error:(NSError **)error
{
    if (!atomically)
    {
        return [self copyItemAtURL:srcURL toURL:dstURL error:error];
    }
    NSURL *dstURLTemp = [dstURL URLByAppendingPathExtension:@".temp"];
    //1.delete tmp file/dir
    [self removeItemAtURL:dstURLTemp error:nil];
    //2.copy to tmp file/dir
    BOOL res = [self copyItemAtURL:srcURL toURL:dstURLTemp error:error];
    if (!res)
    {
        //copy error，remove tmp file/dir
        [self removeItemAtURL:dstURLTemp error:nil];
        return res;
    }
    //3.rename
    return [self moveItemAtURL:dstURLTemp toURL:dstURL error:error];
}

- (BOOL)skipBackupAttributeToItemAtFilePath:(NSString *)filePath
{
    if (filePath == nil ||  filePath.length == 0)
    {
        NSAssert(NO, nil);
        return NO;
    }
    NSURL *URL;
    if ([filePath hasPrefix:@"file://"])
    {
        URL = [NSURL URLWithString:filePath];
    }
    else
    {
        URL = [NSURL fileURLWithPath:filePath];
    }
    const BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:[URL path]];
    if (isExist)
    {
        NSError *error = nil;
        BOOL success = [URL setResourceValue: @YES
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if (error)
        {
            NSLog(@"error_happened %@", error);
        }

        return success;
    }
    else
    {
        NSAssert(isExist, nil);
        NSLog(@"没有找到文件:%@", filePath);
        return NO;
    }
}


@end

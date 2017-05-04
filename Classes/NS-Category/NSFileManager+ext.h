//
//  NSFileManager+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-8-5.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ext)
// sandbox path /Documents/
+ (NSString *)documentPath:(NSString *)subPath;
// sandbox path /Library/Caches/
+ (NSString *)cachePath:(NSString *)subPath;
// sandbox path /Library/
+ (NSString *)libPath:(NSString *)subPath;
// sandbox path /tmp/
+ (NSString *)tempPath:(NSString *)subPath;
// group path
+ (NSString *)sharePath:(NSString *)subPath appGroup:(NSString *)appGroup;

//atomistic copy
- (BOOL)copyItemAtPath:(NSString *)srcPath
                toPath:(NSString *)dstPath
            atomically:(BOOL)atomically
           isOverwrite:(BOOL)overwrite
                 error:(NSError **)error;

//atomistic copy
- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath atomically:(BOOL)atomically error:(NSError **)error;

//atomistic copy
- (BOOL)copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL atomically:(BOOL)atomically error:(NSError **)error;

//don't backup this file
- (BOOL)skipBackupAttributeToItemAtFilePath:(NSString *)filePath;
@end

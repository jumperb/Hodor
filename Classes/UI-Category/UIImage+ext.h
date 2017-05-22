//
//  UIImage+ext.h
//  Camera360
//
//  Created by zhangchutian on 14-5-26.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

//TODO 减少去掉不常用的

#define img(imageName) [UIImage imageNamed:imageName]

@interface UIImage (ext)

+ (UIImage *)imageFromView:(UIView *)theView;
+ (UIImage *)imageFromView:(UIView *)theView frame:(CGRect)frame;

//the image size is 1X1
+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;

//the image size is 1X1
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;


- (UIImage *)roundImageForRadius:(float)radius;

- (UIImage *)roundImageForRadius:(float)radius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth;

- (UIImage *)thumbnailWithWidth:(float)width;

//width = screen width / 4
- (UIImage *)thumbnail;

- (UIImage *)scaleTo:(float)scaleValue;

//blur 0~1
- (UIImage *)blurImage:(CGFloat)blur;

//blur 0~1
- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor;

//blur 0~1
- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor count:(int)count;

@end


@interface CIContext (HodorImage)
+ (instancetype)hodorImageContext;
+ (instancetype)hodorImageContextForSimulator;
@end

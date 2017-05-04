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

/**
 *  gen round image
 *  @param radius
 *  @return
 */
- (UIImage *)roundImageForRadius:(float)radius;

/**
 *  gen circle image and has border
 *
 *  @param radius
 *  @param borderColor
 *  @param borderWidth
 *
 *  @return
 */
- (UIImage *)roundImageForRadius:(float)radius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth;

/**
 *  gen square thumbnail image
 *
 *  @param width
 *
 *  @return
 */
- (UIImage *)thumbnailWithWidth:(float)width;
/**
 *  gen square thumbnail image
 *
 *  width = screen width / 4
 *
 *  @return
 */
- (UIImage *)thumbnail;
/**
 *  scale image
 *
 *  @param scaleValue
 *
 *  @return
 */
- (UIImage *)scaleTo:(float)scaleValue;

/**
 *  blur image use Core Image
 *
 *  @param blur 0~1
 *
 *  @return
 */
- (UIImage *)blurImage:(CGFloat)blur;

/**
 *  blur image use Accelerate
 *
 *  @param blur      0~1
 *  @param tintColor blend color
 *
 *  @return
 */
- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor;

/**
 *  blur image use Accelerate
 *
 *  @param blur      0~1
 *  @param tintColor blend color
 *  @param count
 *
 *  @return
 */
- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor count:(int)count;

@end


@interface CIContext (HodorImage)
+ (instancetype)hodorImageContext;
+ (instancetype)hodorImageContextForSimulator;
@end

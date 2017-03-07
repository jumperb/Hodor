//
//  UIImage+ext.m
//  Camera360
//
//  Created by zhangchutian on 14-5-26.
//  Copyright (c) 2014年 Pinguo. All rights reserved.
//

#import "UIImage+ext.h"
#import <Accelerate/Accelerate.h>
#import <OpenGLES/ES2/gl.h>

@implementation UIImage (ext)

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}

+ (UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext: context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)imageFromView:(UIView *)theView frame:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
    [theView.layer renderInContext: context];
    CGContextTranslateCTM(context, frame.origin.x, frame.origin.y);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *) imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius {
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    roundedRect.lineWidth = 0;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [roundedRect fill];
    [roundedRect stroke];
    [roundedRect addClip];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)roundImageForRadius:(float)radius
{
    return [self roundImageForRadius:radius borderColor:[UIColor whiteColor] borderWidth:0];
}
- (UIImage *)roundImageForRadius:(float)radius borderColor:(UIColor *)borderColor borderWidth:(float)borderWidth
{
    UIGraphicsBeginImageContext(CGSizeMake(radius * 2, radius * 2));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);

    float minWidth = self.size.width;
    if (minWidth > self.size.height) minWidth = self.size.height;

    float scale = radius * 2 / minWidth;
    float scaledWidth = self.size.width * scale;
    float scaledHeight = self.size.height * scale;
    CGRect drawRect = CGRectMake(radius - scaledWidth / 2, radius - scaledHeight / 2, scaledWidth, scaledHeight);
    [self drawInRect:drawRect];
    CGContextAddEllipseInRect(context, UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, 0, 0, 0)));
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
- (UIImage *)thumbnailWithWidth:(float)width
{
    UIGraphicsBeginImageContext(CGSizeMake(width, width));
    float minWidth = self.size.width;
    if (minWidth > self.size.height) minWidth = self.size.height;

    float scale = width / minWidth;
    float scaledWidth = self.size.width * scale;
    float scaledHeight = self.size.height * scale;
    CGRect drawRect = CGRectMake(width/2 - scaledWidth / 2, width/2 - scaledHeight / 2, scaledWidth, scaledHeight);
    [self drawInRect:drawRect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}
- (UIImage *)thumbnail
{
    float w = [UIScreen mainScreen].bounds.size.width * [UIScreen mainScreen].scale / 4;
    if (self.size.width * self.scale > w)
    {
        return [self thumbnailWithWidth:w];
    }
    else
    {
        return self;
    }
}
- (UIImage *)scaleTo:(float)scaleValue
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleValue, self.size.height * scaleValue));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleValue, self.size.height * scaleValue)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)blurImage:(CGFloat)blur
{
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) return nil;
#if TARGET_IPHONE_SIMULATOR
    CIContext *context = [CIContext hodorImageContextForSimulator];
#else
    CIContext *context = [CIContext hodorImageContext];
#endif
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:self];
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGSize imageSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:ciImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];

    ciImage = affineClampFilter.outputImage;
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:boxSize] forKey:@"inputRadius"];
    ciImage = filter.outputImage;

    CGRect cutRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    CGImageRef cgImage = [context createCGImage:ciImage fromRect:cutRect];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}


- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor
{
    return [self blurImage:blur tintColor:tintColor count:1];
}

- (UIImage *)blurImage:(CGFloat)blur tintColor:(UIColor*)tintColor count:(int)count
{
    NSData *imageData = UIImageJPEGRepresentation(self, 0.001);
    UIImage *downSampledImage = [UIImage imageWithData:imageData];
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = downSampledImage.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    count = count < 1 ? 1 : count;
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    for(int i=0; i<count; i++)
    {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        if (error) break;
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    }
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    if (tintColor)
    {
        CGRect imageRect = {CGPointZero, downSampledImage.size};
        
        // Add in color tint.
        if (tintColor) {
            CGContextSaveGState(ctx);
            CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
            CGContextFillRect(ctx, imageRect);
            CGContextRestoreGState(ctx);
        }
    }
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    //free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}
@end


@implementation CIContext (HodorImage)

+ (instancetype)hodorImageContext
{
    static dispatch_once_t pred;
    static CIContext *o = nil;
    
    dispatch_once(&pred, ^{
        EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        o = [self contextWithEAGLContext:eaglContext];
    });
    return o;
}

+ (instancetype)hodorImageContextForSimulator
{
    static dispatch_once_t pred;
    static CIContext *o = nil;
    
    dispatch_once(&pred, ^{
        o = [self contextWithOptions:nil];
    });
    return o;
}
@end

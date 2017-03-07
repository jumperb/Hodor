//
//  UIScreen+ext.m
//  Hodor
//
//  Created by zhangchutian on 2016/12/30.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "UIScreen+ext.h"

@implementation UIScreen (ext)
+ (CGSize)size
{
    return [UIScreen mainScreen].bounds.size;
}
+ (float)height
{
    return [UIScreen mainScreen].bounds.size.height;
}
+ (float)width
{
    return [UIScreen mainScreen].bounds.size.width;
}
@end

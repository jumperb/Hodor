//
//  UILabel+ext.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15-1-5.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UILabel+ext.h"

@implementation UILabel (ext)

- (void)hSetColor:(UIColor *)color font:(UIFont *)font text:(NSString *)text
{
    self.text = text;
    self.textColor = color;
    self.font = font;
}


- (void)hSetText:(NSString *)text lineSpace:(CGFloat)lineSpace
{
    NSMutableAttributedString *attributedString = [UILabel getAttributedStringWithText:text font:self.font lineSpace:lineSpace];
    if(attributedString == nil)
    {
        return;
    }
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByCharWrapping;
    self.attributedText = attributedString;
    CGSize size = [UILabel getSizeWithAttributedString:attributedString width:self.frame.size.width];
    CGRect frame = self.frame;
    frame.size.height = size.height;
    self.frame = frame;
}

+ (CGFloat)hGetTextHeightWith:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace width:(CGFloat)width
{
    NSMutableAttributedString *attributedString = [UILabel getAttributedStringWithText:text font:font lineSpace:lineSpace];
    if(attributedString == nil)
    {
        return 0.f;
    }
    CGSize size = [UILabel getSizeWithAttributedString:attributedString width:width];
    return size.height;
}

#pragma mark - private
+ (NSMutableAttributedString *)getAttributedStringWithText:(NSString *)text
                                                      font:(UIFont *)font
                                                 lineSpace:(CGFloat)lineSpace

{
    if(text == nil)
    {
        return nil;
    }
    lineSpace = lineSpace < 0 ? 0 : lineSpace;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
    return attributedString;
}

+ (CGSize)getSizeWithAttributedString:(NSMutableAttributedString *)attributedString width:(CGFloat)width
{
    CGRect frame = [attributedString boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return frame.size;
}

@end

//
//  UIView+ext.h
//  HFramework
//
//  Created by zhangchutian on 13-12-18.
//  Copyright (c) 2013年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ext)

#pragma mark - position

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

// self.bounds.origin.y + self.frame.size.height
@property (nonatomic, assign) CGFloat innerHeight;
// self.bounds.origin.x + self.frame.size.width
@property (nonatomic, assign) CGFloat innerWidth;

// self.frame.origin.x + self.frame.size.width
@property (nonatomic, assign) CGFloat xmax;
// self.frame.origin.y + self.frame.size.height
@property (nonatomic, assign) CGFloat ymax;

#pragma mark - other

@property (nonatomic, strong) id userInfo;

- (void)removeAllSubViews;
@end



#pragma mark - autoresize easy

#define ALWAYS_FULL(view) view.autoresizingMask = (UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)
#define ALWAYS_BOTTOM(view) view.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin)
#define ALWAYS_RIGHT(view) view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin)
#define ALWAYS_CENTER(view) view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin)
#define ALWAYS_BW(view) view.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth)


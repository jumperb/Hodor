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


#ifndef HodorDisableShotMethod
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;



// self.frame.origin.x + self.frame.size.width
@property (nonatomic) CGFloat xmax;
// self.frame.origin.y + self.frame.size.height
@property (nonatomic) CGFloat ymax;
// self.center.x
@property (nonatomic) CGFloat centerX;
// self.center.y
@property (nonatomic) CGFloat centerY;
// self.bounds.origin.y + self.bounds.size.height
@property (nonatomic, readonly) CGFloat innerHeight;
// self.bounds.origin.x + self.bounds.size.width
@property (nonatomic, readonly) CGFloat innerWidth;
#pragma mark - other

@property (nonatomic, strong) id userInfo;

- (void)removeAllSubViews;

#endif


@property (nonatomic) CGFloat h_x;
@property (nonatomic) CGFloat h_y;
@property (nonatomic) CGFloat h_width;
@property (nonatomic) CGFloat h_height;
@property (nonatomic) CGPoint h_origin;
@property (nonatomic) CGSize h_size;



// self.frame.origin.x + self.frame.size.width
@property (nonatomic) CGFloat h_xmax;
// self.frame.origin.y + self.frame.size.height
@property (nonatomic) CGFloat h_ymax;
// self.center.x
@property (nonatomic) CGFloat h_centerX;
// self.center.y
@property (nonatomic) CGFloat h_centerY;
// self.bounds.origin.y + self.bounds.size.height
@property (nonatomic, readonly) CGFloat h_innerHeight;
// self.bounds.origin.x + self.bounds.size.width
@property (nonatomic, readonly) CGFloat h_innerWidth;
#pragma mark - other

@property (nonatomic, strong) id h_userInfo;

- (void)h_removeAllSubViews;


@end



#pragma mark - autoresize easy

#define ALWAYS_FULL(view) view.autoresizingMask = (UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth)
#define ALWAYS_BOTTOM(view) view.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin)
#define ALWAYS_RIGHT(view) view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin)
#define ALWAYS_CENTER(view) view.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin)
#define ALWAYS_BW(view) view.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth)



//
//  UIViewController+ext.h
//  Hodor
//
//  Created by pengpingguo on 16/5/13.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ext)
- (BOOL)hPopToViewControllerClass:(Class)klass animated:(BOOL)animated;
- (BOOL)hPopToViewControllerName:(NSString *)className animated:(BOOL)animated;

@end

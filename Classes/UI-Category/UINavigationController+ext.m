//
//  UIViewController+ext.m
//  Hodor
//
//  Created by pengpingguo on 16/5/13.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "UINavigationController+ext.h"

@implementation  UINavigationController(ext)

- (BOOL)hPopToViewControllerOfClass:(Class)klass animated:(BOOL)animated
{
    BOOL success = NO;
    if (klass != NULL)
    {
        for (UIViewController *vc in self.viewControllers)
        {
            if ([vc isKindOfClass:klass])
            {
                success = YES;
                [self popToViewController:vc animated:animated];
                break;
            }
        }
    }
    return success;
}


- (void)hReplaceTopViewController:(UIViewController *)vc animated:(BOOL)animated
{
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.viewControllers];
    if (vcs.count > 0)
    {
        [vcs removeLastObject];
        [vcs addObject:vc];
    }
    [self setViewControllers:vcs animated:animated];
}
@end

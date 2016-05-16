//
//  HOpenURLDelegate.h
//  Hodor
//
//  Created by pp_panda on 16/5/16.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define HOpenURLDelegateRegKey (@"HOpenURLDelegateRegKey")
@protocol HOpenURLDelegate <NSObject>

- (UIViewController *)webVCWithUrl:(NSURL *)url;

@end

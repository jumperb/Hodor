//
//  HTestVC.h
//  Baby360
//
//  Created by zhangchutian on 15/4/29.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^HTestCallback)(id sender, id data);

@interface HTestVC : UIViewController
@property (nonatomic, strong) UITableView *tableView;


- (void)addMenu:(NSString *)title callback:(HTestCallback)callback;

- (void)addMenu:(NSString *)title subTitle:(NSString *)subTitle callback:(HTestCallback)callback;
@end

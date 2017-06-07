//
//  UILabelDemoVC.m
//  Hodor
//
//  Created by JeremyLyu_PinGuo on 15-1-5.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "UILabelDemoVC.h"
#import "UILabel+ext.h"

static NSString * const text = @"Tesla gained experience in telephony and electrical engineering before emigrating to the United States in 1884 to work for Thomas Edison in New York City.";

@interface UILabelDemoVC ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, strong) UILabel *lineSpaceLabel;
@end

@implementation UILabelDemoVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"UILabel + ext";
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"swap" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 260, 20)];
    _label.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label];
    [_label hSetText:text lineSpace:6];
    
    self.desc = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 20, CGRectGetWidth(self.view.frame), 20)];
    [self.view addSubview:_desc];
    
    self.lineSpaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 60, CGRectGetWidth(self.view.frame), 20)];
    [self.view addSubview:_lineSpaceLabel];
}

- (void)rightBarButtonPressed
{
    static int i = 0;
    i++;
    float space = 0.f;
    switch (i%4) {
        case 0:
            space = 1.f;
            break;
        case 1:
            space = 4.f;
            break;
        case 2:
            space = 10.f;
            break;
        case 3:
            space = 14.f;
            break;
        case 4:
            space = 20.f;
            break;
        default:
            break;
    }
    [_label hSetText:text lineSpace:space];
    
    CGFloat cosHeight = [UILabel hGetTextHeightWith:text font:_label.font lineSpace:space width:_label.frame.size.width];
    NSString *descString = [NSString stringWithFormat:@"label height：%.0f, compute height:%.0f", _label.frame.size.height, cosHeight];
    self.desc.text = descString;
    self.lineSpaceLabel.text = [NSString stringWithFormat:@"line space：%0.f", space];
}
@end

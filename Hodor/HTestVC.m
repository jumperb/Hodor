//
//  HTestVC.m
//  Baby360
//
//  Created by zhangchutian on 15/4/29.
//  Copyright (c) 2015年 zhangchutian. All rights reserved.
//

#import "HTestVC.h"


@interface BDebugMenuItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) HTestCallback callback;
@end

@implementation BDebugMenuItem
@end

@interface HTestVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *menuData;
@end

@implementation HTestVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"MENU";
        _menuData = [NSMutableArray new];
    }
    return self;
}

- (void)addMenu:(NSString *)title callback:(HTestCallback)callback
{
    [self addMenu:title subTitle:nil callback:callback];
}

- (void)addMenu:(NSString *)title subTitle:(NSString *)subTitle callback:(HTestCallback)callback
{
    BDebugMenuItem *item = [BDebugMenuItem new];
    item.title = title;
    item.subTitle = subTitle;
    item.callback = callback;
    [_menuData addObject:item];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    BDebugMenuItem *item = [_menuData objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text= item.subTitle;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BDebugMenuItem *item = [_menuData objectAtIndex:indexPath.row];
    if (item.callback) item.callback(item, indexPath);
}
@end

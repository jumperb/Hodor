//
//  UIImageDemoVC.m
//  Hodor
//
//  Created by zhangchutian on 14/12/2.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#import "UIImageDemoVC.h"

@implementation UIImageDemoVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"UIImage + ext";
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = imageView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [UIView new];
        cell.backgroundView.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"Round image";
            cell.detailTextLabel.text = @"with border";
            cell.accessoryView = [[UIImageView alloc] initWithImage: [[UIImage imageNamed:@"bg.jpg"] roundImageForRadius:80 borderColor:[UIColor lightGrayColor] borderWidth:4]];
            cell.accessoryView.backgroundColor = [UIColor clearColor];
            cell.accessoryView.frame = CGRectMake(0, 0, 80, 80);
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"square thumbnai image";
            cell.detailTextLabel.text = @"with border";
            cell.accessoryView = [[UIImageView alloc] initWithImage: [[UIImage imageNamed:@"bg.jpg"] thumbnailWithWidth:160]];
            cell.accessoryView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            cell.accessoryView.layer.borderWidth = 1;
            cell.accessoryView.backgroundColor = [UIColor clearColor];
            cell.accessoryView.frame = CGRectMake(0, 0, 80, 80);
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"blur effect";
            break;
        }
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {

        case 2:
        {
            UIImage *image = [UIImage imageFromView:[UIApplication sharedApplication].keyWindow];
            UIImage *blurImage = [image blurImage:0.8];
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            button.backgroundColor = [UIColor blueColor];
            [button setImage:blurImage forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            button.alpha = 0;
            [[UIApplication sharedApplication].keyWindow addSubview:button];
            [UIView animateWithDuration:0.5 animations:^{
                button.alpha = 1;
            } completion:^(BOOL finished) {
            }];
            break;
        }
        default:
            break;
    }
}

- (void)buttonPressed:(UIButton *)button
{
    [UIView animateWithDuration:0.5 animations:^{
        button.alpha = 0;
    } completion:^(BOOL finished) {
        [button removeFromSuperview];
    }];
}
@end

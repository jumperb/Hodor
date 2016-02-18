//
//  HGCDTest.m
//  Hodor
//
//  Created by zhangchutian on 15/12/31.
//  Copyright © 2015年 zhangchutian. All rights reserved.
//

#import "HGCDextTestVC.h"
#import "HGCDext.h"

@interface HGCDextTestBiz ()
@property (nonatomic) dispatch_queue_t queue;
@property (nonatomic) NSMutableArray *data;
@end

const void *HImageVideoProcessQueueKey = &HImageVideoProcessQueueKey;

@implementation HGCDextTestBiz
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray new];
        self.queue = [self createQueue:"testqueue" attr:0];
    }
    return self;
}
- (dispatch_queue_t)createQueue:(char *)name attr:(dispatch_queue_attr_t)attr
{
    dispatch_queue_t queue = dispatch_queue_create(name, attr);
    dispatch_queue_set_specific(queue, (__bridge void *)queue, (__bridge void *)queue, nil);
    return queue;
}

- (id)objectAtIndex:(int)index
{
    __block id res = 0;
    syncAtQueue(self.queue , ^{
        sleep(1);
        res = self.data[index];
    });
    return res;
}

- (void)addObject:(id)obj
{
    syncAtQueue(self.queue , ^{
        sleep(2);
        [self.data addObject:obj];
    });
}


@end



@interface HGCDextTestVC ()

@end

@implementation HGCDextTestVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"GCD EXT TEST";
        HGCDextTestBiz *biz = [HGCDextTestBiz new];
        [self addMenu:@"test syncAtQueue on main thread" callback:^(id sender, id data) {
            NSLog(@"willAdd");
            [biz addObject:@"1"];
            NSLog(@"addFinish");
        }];
        
        [self addMenu:@"test syncAtQueue on same queue" callback:^(id sender, id data) {
            dispatch_async(biz.queue, ^{
                NSLog(@"willAdd");
                [biz addObject:@(2)];
                NSLog(@"addFinish");
            });
        }];
        
        [self addMenu:@"test syncAtMain" callback:^(id sender, id data) {
            syncAtMain(^{
                sleep(1);
                NSLog(@"3");
            });
        }];
        
        [self addMenu:@"test syncAtMain" callback:^(id sender, id data) {
            dispatch_async(biz.queue, ^{
                syncAtMain(^{
                    sleep(1);
                    NSLog(@"4");
                });
            });
        }];
    }
    return self;
}

@end




//
//  HGCDext.m
//  Hodor
//
//  Created by zhangchutian on 15/12/31.
//  Copyright © 2015年 zhangchutian. All rights reserved.
//

#import "HGCDext.h"

dispatch_queue_t hCreateQueue(char *name, dispatch_queue_attr_t attr)
{
    dispatch_queue_t queue = dispatch_queue_create(name, attr);
    dispatch_queue_set_specific(queue, (__bridge void *)queue, (__bridge void *)queue, nil);
    return queue;
}

void syncAtQueue(dispatch_queue_t queue, void (^action)(void))
{
    if (!action) return;
    if (dispatch_get_specific((__bridge void *)queue)) action();
    else dispatch_sync(queue, action);
}

void syncAtMain(void (^action)(void))
{
    if (!action) return;
    if ([NSThread isMainThread]) action();
    else dispatch_sync(dispatch_get_main_queue(), action);
}

void dispatchAfter(float sec, void (^action)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sec * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (action) action();
    });
}

void asyncAtMain(void (^action)(void))
{
    if (!action) return;
    dispatch_async(dispatch_get_main_queue(), action);
}


void asyncAtQueue(dispatch_queue_t queue, void (^action)(void))
{
    if (!action) return;
    dispatch_async(queue, action);
}
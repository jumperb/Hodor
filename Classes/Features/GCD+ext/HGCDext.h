//
//  HGCDext.h
//  Hodor
//
//  Created by zhangchutian on 15/12/31.
//  Copyright © 2015年 zhangchutian. All rights reserved.
//

#import <Foundation/Foundation.h>

//gen a gcd queue, there is an addtional queue tag
dispatch_queue_t hCreateQueue(char *name, dispatch_queue_attr_t attr);

//safe dispatch_sync ,⚠️ note: only use on serail queue
void syncAtQueue(dispatch_queue_t queue, void (^action)(void));

//safe dispathch_sync on main queue
void syncAtMain(void (^action)(void));

//shorter aync dispatch
void asyncAtMain(void (^action)(void));

//shorter aync dispatch
void asyncAtQueue(dispatch_queue_t queue, void (^action)(void));

//wapping dispatch_after
void dispatchAfter(float sec, void (^action)(void));

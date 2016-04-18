//
//  HCommonBlock.h
//  HFramework
//
//  Created by zhangchutian on 14-6-5.
//  Copyright (c) 2014年 zhangchutian. All rights reserved.
//

#ifndef HFramework_HCommonBlock_h
#define HFramework_HCommonBlock_h

#import <Foundation/Foundation.h>

// universal block define

typedef void (^min_callback)();

typedef void (^callback)(id sender, id data);

typedef void (^callback2)(id sender, id data, id data2);

typedef void (^simple_callback)(id sender);

typedef void (^fail_callback)(id sender, NSError *error);

typedef id (^returnback)(id sender, id data);

typedef void (^finish_callback)(id sender, id data, NSError *error);



#endif


//
//  TestObj.h
//  Hodor
//
//  Created by zhangchutian on 16/1/28.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCommon.h"

@interface AClass: NSObject
@property (nonatomic, strong) callback ablock;
@end

@interface BClass : NSObject
@property (nonatomic) AClass *a;
@end
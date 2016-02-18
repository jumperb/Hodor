//
//  TestObj.h
//  Hodor
//
//  Created by zhangchutian on 16/1/28.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AClass: NSObject
@property (nonatomic, strong) callback ablock;
@end

@interface BClass : NSObject
@property (nonatomic) AClass *a;
@end
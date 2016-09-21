//
//  ClassRegisterTestVC.h
//  Hodor
//
//  Created by zhangchutian on 16/2/18.
//  Copyright © 2016年 zhangchutian. All rights reserved.
//

#import "HTestVC.h"

@interface ClassRegisterTestVC : HTestVC

@end


#define TestProRegKey @"TestProRegKey"

@protocol TestPro <NSObject>

@end
@protocol TestPro2 <NSObject>

@end

#define AClassRegKey @"AClassRegKey"
@interface A : NSObject

@end

@interface B : A

@end

@interface C : A

@end

@interface D : A

@end

@interface E : A <TestPro2>
+ (instancetype)shareInstance;
@end
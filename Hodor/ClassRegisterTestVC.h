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

@protocol WProtocal <NSObject>
@end

@protocol XProtocol <NSObject>

@end
@protocol YProtocol <NSObject>
- (void)testFun;
@end

@protocol ZProtocal <NSObject>

@end




#define ClassARegKey @"AClassRegKey"
@interface ClassA : NSObject <WProtocal>

@end

@interface ClassB : ClassA <XProtocol>

@end

@interface ClassC : ClassA

@end

@interface ClassD : ClassA <XProtocol>

@end

@interface ClassE : ClassA <YProtocol>
+ (instancetype)shareInstance;
@end

@interface ClassF : NSObject <ZProtocal>
@property (nonatomic) id<WProtocal> pw;
@property (nonatomic) id<YProtocol> py;

@end


@interface ClassG : NSObject
@property (nonatomic) id<ZProtocal> pz;
@end

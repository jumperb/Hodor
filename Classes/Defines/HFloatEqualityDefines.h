//
//  HFloatEqualityDefines.h
//  Hodor
//
//  Created by jtang on 15/10/23.
//  Copyright © 2015年 zhangchutian. All rights reserved.
//

#ifndef HFloatEqualityDefines_h
#define HFloatEqualityDefines_h


#define F_EQUAL(a,b) ((fabs((a) - (b))) < FLT_EPSILON)
#define F_NOT_EQUAL(a,b) ((fabs((a) - (b))) > FLT_EPSILON)
#define F_EQUAL_ZERO(a) (fabs(a) < FLT_EPSILON)
#define F_NOT_EQUAL_ZERO(a) (fabs(a) > FLT_EPSILON)
#define F_LESS_THAN(a,b) (fabs(a) < (fabs(b)+FLT_EPSILON))
#define F_LESS_OR_EQUAL_THAN(a,b) ((fabs(a) < (fabs(b)+FLT_EPSILON)) || (fabs((a) - (b)) < FLT_EPSILON))
#define F_GREATER_THAN(a,b) (fabs(a) > (fabs(b)+FLT_EPSILON))
#define F_GREATER_OR_EQUAL_THAN(a,b) ((fabs(a) > fabs(b)+FLT_EPSILON) || ((fabs((a) - (b)) < FLT_EPSILON)))

#endif /* HFloatEqualityDefines_h */

//
//  HFloatEqualityDefines.h
//  Hodor
//
//  Created by jtang on 15/10/23.
//  Copyright © 2015年 zhangchutian. All rights reserved.
//

#ifndef HFloatEqualityDefines_h
#define HFloatEqualityDefines_h


#ifndef F_EQUAL
#define F_EQUAL(a,b) ((fabs((a) - (b))) < FLT_EPSILON)
#endif

#ifndef F_NOT_EQUAL
#define F_NOT_EQUAL(a,b) (!(F_EQUAL(a,b)))
#endif

#ifndef F_EQUAL_ZERO
#define F_EQUAL_ZERO(a) (fabs(a) < FLT_EPSILON)
#endif

#ifndef F_NOT_EQUAL_ZERO
#define F_NOT_EQUAL_ZERO(a) (!(F_EQUAL_ZERO(a)))
#endif

#ifndef F_LESS_THAN
#define F_LESS_THAN(a,b) ((a - b) < FLT_EPSILON && F_NOT_EQUAL(a, b))
#endif

#ifndef F_LESS_OR_EQUAL_THAN
#define F_LESS_OR_EQUAL_THAN(a,b) (F_LESS_THAN(a,b) || F_EQUAL(a,b))
#endif

#ifndef F_GREATER_THAN
#define F_GREATER_THAN(a,b) ((a - b) > FLT_EPSILON && F_NOT_EQUAL(a, b))
#endif

#ifndef F_GREATER_OR_EQUAL_THAN
#define F_GREATER_OR_EQUAL_THAN(a,b) (F_GREATER_THAN(a,b) || F_EQUAL(a,b))
#endif


#endif /* HFloatEqualityDefines_h */

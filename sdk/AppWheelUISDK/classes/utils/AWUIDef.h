//
//  AWUIDef.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/24.
//

#import <Foundation/Foundation.h>

    
#define IS_IPHONE_4_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE_5_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_PLUS_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
//刘海屏
#define IS_IPHONE_X_SERIES ( (int)([UIScreen mainScreen].bounds.size.height) > 736 )
#define IS_IPHONE_4_OR_5_SERIES (IS_IPHONE_5_SERIES || IS_IPHONE_4_SERIES)

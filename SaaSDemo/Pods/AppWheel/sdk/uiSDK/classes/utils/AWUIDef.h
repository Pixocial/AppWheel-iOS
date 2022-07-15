//
//  AWUIDef.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

///屏幕宽度
#define ScreenWidth            [UIScreen mainScreen].bounds.size.width
/// 屏幕高度
#define ScreenHeight           [UIScreen mainScreen].bounds.size.height
    
#define IS_IPHONE_4_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPHONE_5_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_6_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )667 ) < DBL_EPSILON )
// 8
#define IS_IPHONE_PLUS_SERIES ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )736 ) < DBL_EPSILON )
//刘海屏
#define IS_IPHONE_X_SERIES ( (int)([UIScreen mainScreen].bounds.size.height) > 736 )
#define IS_IPHONE_4_OR_5_SERIES (IS_IPHONE_5_SERIES || IS_IPHONE_4_SERIES)
///12
#define IS_IPHONE_12_SIZE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )844 ) < DBL_EPSILON )
///12max
#define IS_IPHONE_12_MAX_SIZE ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )926 ) < DBL_EPSILON )
/// 底部的margin
#define iPhoneXSeriesSafeAreaBottom ( (IS_IPHONE_X_SERIES) ? 34 : 0 )


//#import "AppDelegate.h"
//CG_INLINE UIEdgeInsets safeArea() {
//    if (!IS_IPHONE_X_SERIES) {
//        return UIEdgeInsetsZero;
//    }
    //此种用法需要删除sessionDelegate
//    if (@available(iOS 11.0, *)) {
//        AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
//        UIWindow *window = delegate.window;
//        if (window != nil) {
//            return UIEdgeInsetsMake(window.safeAreaInsets.top, 0, window.safeAreaInsets.bottom, 0);
//        } else {
//            NSCAssert(false, @"SafeArea的获取必须在UIWindow创建之后");
//        }
//    }
    //此种方法，因为keyWindow会发生改变，所以可能获取不到正确的值
//    if (@available(iOS 11.0, *)) {
//        UIWindow *window = UIApplication.sharedApplication.keyWindow;
//        if (window != nil) {
//            return UIEdgeInsetsMake(window.safeAreaInsets.top, 0, window.safeAreaInsets.bottom, 0);
//        } else {
//            NSCAssert(false, @"SafeArea的获取必须在UIWindow创建之后");
//        }
//    }
//    return UIEdgeInsetsZero;
//}
//#define iPhoneXSeriesSafeAreaTop ( safeArea().top )
#define iPhoneXSeriesSafeAreaBottom ( (IS_IPHONE_X_SERIES) ? 34 : 0 )
///获取状态栏高度
///刘海屏以下为20，以上11为48，12为47
static inline CGFloat getNavibarHeight() {
    if (IS_IPHONE_12_SIZE) {
        return 47;
    } else if (IS_IPHONE_X_SERIES) {
        return 48;
    } else if (IS_IPHONE_PLUS_SERIES) {
        return 20;
    } else {
        return 2;
    }
}


#define IS_EMPTY_STRING(str) (str == nil || [str isEqual:[NSNull null]] || [str isEqualToString:@""])

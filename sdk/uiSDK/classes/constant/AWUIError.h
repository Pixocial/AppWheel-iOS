//
//  AWUIError.h
//  AWUI
//
//  Created by yikunHuang on 2021/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWUIErrorType) {
    ///网络请求失败
    AWUIErrorTypeNetFailed = 40000,
    ///找不到页面 ID
    AWUIErrorTypePageIdNotFound = 40001,
    ///Sku 配置错误
    AWUIErrorTypeSkuConfigError = 40002,
    ///请求不到订阅商品数据
    AWUIErrorTypeRequestSkuError = 40003,
};

FOUNDATION_EXPORT NSString * const AWUIErrorTypeNetFailedMsg;
FOUNDATION_EXPORT NSString * const AWUIErrorTypePageIdNotFoundMsg;
FOUNDATION_EXPORT NSString * const AWUIErrorTypeSkuConfigErrorMsg;
FOUNDATION_EXPORT NSString * const AWUIErrorTypeRequestSkuErrorMsg;


@interface AWUIError : NSObject

@end

NS_ASSUME_NONNULL_END

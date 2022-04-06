//
//  AWComponentNames.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/28.
//
/// 定义对应的组件的名称 ////

#import <Foundation/Foundation.h>
#import "AWBaseComponentModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 样式1的组件名称   ///
/// 标题父控件
FOUNDATION_EXPORT NSString * const awPage1Title;
///     主标题
FOUNDATION_EXPORT NSString * const awPage1MainTitle;
///     副标题
FOUNDATION_EXPORT NSString * const awPage1TitleMessage;
///     topBanner
FOUNDATION_EXPORT NSString * const awPage1TopBanner;
/// 滚轮父控件
FOUNDATION_EXPORT NSString * const awPage1Scrolling;
/// 订阅按钮父控件
FOUNDATION_EXPORT NSString * const awPage1skuOfferings;
/// 订阅按钮：日
FOUNDATION_EXPORT NSString * const awPage1skuOfferingsTypeDay;
/// 订阅按钮：周
FOUNDATION_EXPORT NSString * const awPage1skuOfferingsTypeWeekly;
/// 订阅按钮：月
FOUNDATION_EXPORT NSString * const awPage1skuOfferingsTypeMonth;
/// 订阅按钮：年
FOUNDATION_EXPORT NSString * const awPage1skuOfferingsTypeYear;
/// 订阅按钮：左上角
FOUNDATION_EXPORT NSString * const awPage1skuPopularHint;
/// 订阅按钮：右上角
FOUNDATION_EXPORT NSString * const awPage1skuDiscountHint;
/// 订阅按钮：10/每月、1/每天
FOUNDATION_EXPORT NSString * const awPage1skuConversionHint;
/// 订阅按钮：总价
FOUNDATION_EXPORT NSString * const awPage1skuPrice;
/// 订阅按钮：周期
FOUNDATION_EXPORT NSString * const awPage1skuDuration;


/// 提交按钮父控件
FOUNDATION_EXPORT NSString * const awPage1ActionButton;
///     提交按钮主标题
FOUNDATION_EXPORT NSString * const awPage1ActionButtonSubHint;
///     提交按钮副标题
FOUNDATION_EXPORT NSString * const awPage1ActionButtonSubMessage;
/// 协议父控件
FOUNDATION_EXPORT NSString * const awPage1TermsColumn;
/// 协议---恢复购买
FOUNDATION_EXPORT NSString * const awPage1TermsRestore;
/// 协议---用户协议
FOUNDATION_EXPORT NSString * const awPage1TermsProtocol;
/// 协议---隐私政策
FOUNDATION_EXPORT NSString * const awPage1TermsPrivacy;

@interface AWComponentNames : NSObject

+ (AWBaseComponentModel *)findModelInComponents:(NSArray<AWBaseComponentModel *> *)components
                                       withName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

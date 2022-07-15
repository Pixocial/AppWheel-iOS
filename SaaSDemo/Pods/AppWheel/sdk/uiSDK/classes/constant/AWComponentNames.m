//
//  AWComponentNames.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/28.
//

#import "AWComponentNames.h"

/// 样式1的组件名称   ///
/// 标题父控件
NSString * const awPage1Title = @"title";
///     主标题
NSString * const awPage1MainTitle = @"mainTitle";
///     副标题
NSString * const awPage1TitleMessage = @"titleMessage";
///     topBanner
NSString * const awPage1TopBanner = @"topBanner";
/// 滚轮父控件
NSString * const awPage1Scrolling = @"scrolling";
/// 订阅按钮父控件
NSString * const awPage1skuOfferings = @"skuOfferings";
/// 订阅按钮：日
NSString * const awPage1skuOfferingsTypeDay = @"day";
/// 订阅按钮：周
NSString * const awPage1skuOfferingsTypeWeekly = @"weekly";
/// 订阅按钮：月
NSString * const awPage1skuOfferingsTypeMonth = @"month";
/// 订阅按钮：年
NSString * const awPage1skuOfferingsTypeYear = @"year";
/// 订阅按钮：左上角
NSString * const awPage1skuPopularHint = @"badge1";
/// 订阅按钮：右上角
NSString * const awPage1skuDiscountHint = @"badge2";
/// 订阅按钮：每月、每天
NSString * const awPage1skuConversionHint = @"conversionHint";
/// 订阅按钮：总价
NSString * const awPage1skuPrice = @"price";
/// 订阅按钮：周期
NSString * const awPage1skuDuration = @"duration";

/// 提交按钮父控件
NSString * const awPage1ActionButton = @"actionButton";
///提交按钮的文案：放在了订阅按钮的子控件下面
NSString * const awPage1ActionText = @"actionButtonText";
///     提交按钮主标题
NSString * const awPage1ActionButtonSubHint = @"subHint";
///     提交按钮副标题
NSString * const awPage1ActionButtonSubMessage = @"subMessage";
/// 协议父控件
NSString * const awPage1TermsColumn = @"termsColumn";
/// 协议---恢复购买
NSString * const awPage1TermsRestore = @"restore";
/// 协议---用户协议
NSString * const awPage1TermsProtocol = @"protocol";
/// 协议---隐私政策
NSString * const awPage1TermsPrivacy = @"privacy";


@implementation AWComponentNames

#pragma mark:- 处理数据
/// 通过递归查找到对应的components
+ (AWBaseComponentModel *)findModelInComponents:(NSArray<AWBaseComponentModel *> *)components
                   withName:(NSString *)name {

    for (AWBaseComponentModel *component in components) {
        if ([component.name isEqualToString:name]) {
            return component;
        }
        if (component.components && component.components.count > 0) {
            AWBaseComponentModel *findModel = [self findModelInComponents:component.components withName:name];
            if (findModel) {
                return findModel;
            }
        }
    }
    return nil;
}


@end

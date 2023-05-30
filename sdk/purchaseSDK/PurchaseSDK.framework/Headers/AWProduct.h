//
//  AWProduct.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SubscriptionUnitType) {
    SubscriptionUnitTypeDay = 0,
    SubscriptionUnitTypeWeek,
    SubscriptionUnitTypeMonth,
    SubscriptionUnitTypeYear
};

typedef NS_ENUM(NSInteger, DiscountPaymentMode) {
    DiscountPaymentModeNone = 0,
    DiscountPaymentModePayAsYouGo,
    DiscountPaymentModePayUpFront,
    DiscountPaymentModeFreeTrial
};

typedef NS_ENUM(NSInteger, DiscountType) {
    DiscountTypeNone = 0,
    DiscountTypeIntroductoryPrice,
    DiscountTypeSubscriptionOffer
};

typedef NS_ENUM(NSInteger, AWProductType) {
    AWProductTypeConsumable = 0,
    AWProductTypeNonConsumable = 1,
    AWProductTypeAutoRenewable = 2,
    AWProductTypeNonRenewable = 3
};


@interface SubscriptionPeriod : NSObject

@property (nonatomic, assign) NSInteger numberOfDiscountUnits;

@property (nonatomic, assign) SubscriptionUnitType unitType;

@end

@interface ProductDiscount : NSObject
///优惠ID，推介促销为空
@property (nonatomic, strong, nullable) NSString * discountIdentifier;
///价格，数字类型
@property (nonatomic, strong) NSDecimalNumber * discountPrice;
///本地化价格
@property (nonatomic, strong, nullable) NSLocale * discountPriceLocale;
///本地化价格，带货币符号：¥8
@property (nonatomic, strong) NSString * discountLocalizedPrice;
///paymentMode
@property (nonatomic, assign) DiscountPaymentMode discountPaymentMode;
///优惠类型：促销优惠、普通优惠
@property (nonatomic, assign) DiscountType discountType;
///优惠周期
@property (nonatomic, strong) SubscriptionPeriod * discountPeriod;
///优惠持续次数
@property (nonatomic, assign) NSInteger numberOfDiscountPeriod;

@end

@interface AWProduct : NSObject
///商品id
@property (nonatomic, strong) NSString * productIdentifier;
///数字价格
@property (nonatomic, strong) NSDecimalNumber * price;
///本地化价格，带货币符号：$
@property (nonatomic, strong) NSLocale * priceLocale;
///本地化价格，带货币符号：¥8
@property (nonatomic, strong) NSString * localizedPrice;
///本地化描述
@property (nonatomic, strong) NSString * localizedDescription;
///本地化标题
@property (nonatomic, strong) NSString * localizedTitle;
///订阅周期
@property (nonatomic, strong, nullable) SubscriptionPeriod * subscriptionPeriod;
///推介促销优惠,API>=11.2
@property (nonatomic, strong, nullable) ProductDiscount * introductoryPrice;
///优惠,API>=12.2
@property (nonatomic, strong, nullable) NSArray<ProductDiscount *> * discounts;
/// 是否支持家庭共享
@property (nonatomic, assign) BOOL  isFamilyShareable;

@property (nonatomic, assign) NSInteger quantity;
///商品类型[👀注意这个商品类型需要app开发者自己设置]
@property (nonatomic, assign) AWProductType productType;
///订阅群组ID
@property (nonatomic, strong, nullable) NSString *subscriptionGroupIdentifier;

- (instancetype)initWithSKProduct:(SKProduct *)skProduct;

- (NSString *)getSubscriptionPeriod;

@end

NS_ASSUME_NONNULL_END

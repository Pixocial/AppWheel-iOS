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

@interface SubscriptionPeriod : NSObject

@property (nonatomic, assign) NSInteger numberOfDiscountUnits;

@property (nonatomic, assign) SubscriptionUnitType unitType;

@end

@interface ProductDiscount : NSObject

@property (nonatomic, strong, nullable) NSString * discountIdentifier;

@property (nonatomic, strong) NSDecimalNumber * discountPrice;

@property (nonatomic, strong, nullable) NSLocale * discountPriceLocale;

@property (nonatomic, strong) NSString * discountLocalizedPrice;

@property (nonatomic, assign) DiscountPaymentMode discountPaymentMode;

@property (nonatomic, assign) DiscountType discountType;

@property (nonatomic, strong) SubscriptionPeriod * discountPeriod;

@property (nonatomic, assign) NSInteger numberOfDiscountPeriod;

@end

@interface AWProduct : NSObject

@property (nonatomic, strong) NSString * productIdentifier;

@property (nonatomic, strong) NSDecimalNumber * price;

@property (nonatomic, strong) NSLocale * priceLocale;

@property (nonatomic, strong) NSString * localizedPrice;

@property (nonatomic, strong) NSString * localizedDescription;

@property (nonatomic, strong) NSString * localizedTitle;

@property (nonatomic, strong, nullable) SubscriptionPeriod * subscriptionPeriod;

@property (nonatomic, strong, nullable) ProductDiscount * introductoryPrice;

@property (nonatomic, strong) NSArray<ProductDiscount *> * discounts;

@property (nonatomic, assign) BOOL  isFamilyShareable;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, assign) NSInteger productType;

@property (nonnull, strong) NSString *subscriptionGroupIdentifier;

- (instancetype)initWithSKProduct:(SKProduct *)skProduct;

@end

NS_ASSUME_NONNULL_END

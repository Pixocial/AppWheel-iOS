//
//  AWLatestSubscriptionInfo.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LatestSubscriptionInfo : NSObject
///商品ID
@property (nonatomic, strong) NSString * productIdentifier;
///是否免费试用
@property (nonatomic, assign) BOOL isTrialPeriod;
///是否处于推介促销优惠
@property (nonatomic, assign) BOOL isInIntroPeriod;
///是否处于续订
@property (nonatomic, assign) BOOL autoRenewStatus;
///优惠ID
@property (nonatomic, strong, nullable) NSString * promotionalIdentifier;
///原始订单ID，因为是2020年6月30日才添加的字段，所以还是有可能为空的
@property (nonatomic, strong, nullable) NSString * originalTransactionId;
///订单ID
@property (nonatomic, strong, nullable) NSString * transactionId;
/// 当前订单的原始购买时间
@property (nonatomic, strong, nullable) NSDate * originalPurchaseTime;
///当前订单的购买时间
@property (nonatomic, strong, nullable) NSDate * purchaseTime;
/// 过期时间
@property (nonatomic, strong, nullable) NSDate * subscriptionExpiredTime;
///宽限期，如果没有处于宽限期，该字断为空
@property (nonatomic, strong, nullable) NSDate * subscriptionGracePeriodExpiredTime;
///购买来自自己还是家庭共享，PURCHASED：自己购买；FAMILY_SHARED：来自家庭共享
@property (nonatomic, strong, nullable) NSString * inAppOwnershipType;
///兑换码
@property (nonatomic, strong, nullable) NSString * offerCodeRefName;
///商品类型
@property (nonatomic, strong, nullable) NSString * productType;
/// 状态 订单状态：0 未付款 1 付款正常使用 2 过期 3 宽限期 4 暂停 5 保留期'
@property (nonatomic, assign) NSInteger status;
/// groupId
@property (nonatomic, strong, nullable) NSString * subscriptionGroupIdentifier;

- (instancetype)initWithSubscriptionInfo:(NSDictionary *)subscriptionInfo;

@end

NS_ASSUME_NONNULL_END

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

@property (nonatomic, strong) NSString * productIdentifier;

@property (nonatomic, assign) BOOL isTrialPeriod;

@property (nonatomic, assign) BOOL isInIntroPeriod;

@property (nonatomic, strong, nullable) NSString * promotionalIdentifier;
///因为是2020年6月30日才添加的字段，所以还是有可能为空的
@property (nonatomic, strong, nullable) NSString * originalTransactionId;

@property (nonatomic, strong, nullable) NSString * transactionId;
/// 当前订单的原始购买时间
@property (nonatomic, strong, nullable) NSDate * originalPurchaseTime;
///当前订单的购买时间
@property (nonatomic, strong, nullable) NSDate * purchaseTime;

@property (nonatomic, strong, nullable) NSDate * subscriptionExpiredTime;

@property (nonatomic, strong, nullable) NSDate * subscriptionGracePeriodExpiredTime;

@property (nonatomic, strong, nullable) NSString * inAppOwnershipType;
///兑换码
@property (nonatomic, strong, nullable) NSString * offerCodeRefName;

@property (nonatomic, strong, nullable) NSString * productType;

- (instancetype)initWithSubscriptionInfo:(NSDictionary *)subscriptionInfo;

@end

NS_ASSUME_NONNULL_END

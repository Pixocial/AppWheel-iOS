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

@property (nonatomic, strong) NSString * originalTransactionId;

@property (nonatomic, strong) NSString * transactionId;

@property (nonatomic, strong) NSDate * subscriptionExpiredTime;

@property (nonatomic, strong) NSDate * subscriptionGracePeriodExpiredTime;

@property (nonatomic, strong) NSString * inAppOwnershipType;
///兑换码
@property (nonatomic, strong) NSString * offerCodeRefName;

@property (nonatomic, strong) NSString * productType;

- (instancetype)initWithSubscriptionInfo:(NSDictionary *)subscriptionInfo;

@end

NS_ASSUME_NONNULL_END

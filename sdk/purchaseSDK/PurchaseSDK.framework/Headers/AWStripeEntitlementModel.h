//
//  AWStripeEntitlementModel.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWProduct.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWStripeEntitlementModel : NSObject
///过期时间
@property (nonatomic, assign) long expiresDateMs;
///首次购买时间
@property (nonatomic, assign) long originalPurchaseDateMs;
///宽限期过期时间
@property (nonatomic, assign) long gracePeriodExpiresDateMs;


- (instancetype)initWithDic:(NSDictionary *)dic;

- (NSString *)toString;
@end

NS_ASSUME_NONNULL_END

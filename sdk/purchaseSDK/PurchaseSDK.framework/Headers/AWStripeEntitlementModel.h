//
//  AWStripeEntitlementModel.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWProduct.h"
#import "AWEntitlementOrders.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWStripeEntitlementModel : NSObject
///过期时间
@property (nonatomic, assign) long expiresDateMs;
///首次购买时间
@property (nonatomic, assign) long originalPurchaseDateMs;
///宽限期过期时间
@property (nonatomic, assign) long gracePeriodExpiresDateMs;
///未过期，满足权益的所有订单详细，续订订单只有最后生效的一笔
@property (nonatomic, strong) NSMutableArray<AWEntitlementOrders*> *orders;


- (instancetype)initWithDic:(NSDictionary *)dic;

- (NSString *)toString;
@end

NS_ASSUME_NONNULL_END

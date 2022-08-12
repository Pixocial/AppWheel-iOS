//
//  AWEntitlementOrders.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/7/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWEntitlementOrders : NSObject

///appid
@property (nonatomic, assign) int appId;
///平台 iOS，Android，Stripe
@property (nonatomic, strong) NSString *platform;
///商品id
@property (nonatomic, strong) NSString *productId;
///是否自动续订
@property (nonatomic, assign) BOOL isAutoRenew;
///非必须（android时不存在），试用期
@property (nonatomic, assign) BOOL isTrialPeriod;
///商品类别 0消耗商品，1非消耗商品，2自动续订商品，3非自动续订商品
@property (nonatomic, assign) int productType;
///// 原始交易id，订阅id
@property (nonatomic, strong) NSString *originalTransactionId;
///交易id
@property (nonatomic, strong) NSString *transactionId;
///状态 订单状态：0 未付款 1 付款正常使用 2 过期 3 宽限期 4 暂停 5 保留期'
@property (nonatomic, assign) int status;
///购买时间
@property (nonatomic, assign) long purchaseDateMs;
/// 首次购买时间
@property (nonatomic, assign) long originalPurchaseDateMs;
///过期时间
@property (nonatomic, assign) long expiresDateMs;
///宽限期过期时间，宽限期时有效
@property (nonatomic, assign) long gracePeriodExpiresDateMs;


- (instancetype)initWithDic:(NSDictionary *)dic;
- (NSString *)toString;
@end

NS_ASSUME_NONNULL_END

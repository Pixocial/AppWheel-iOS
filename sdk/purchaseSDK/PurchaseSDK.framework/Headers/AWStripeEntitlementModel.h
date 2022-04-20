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
/// 订单id
@property (nonatomic, strong) NSString *orderId;
/// appid
@property (nonatomic, strong) NSString *appId;
///商品id
@property (nonatomic, strong) NSString *productId;
///平台
@property (nonatomic, strong) NSString *platform;
///商品类别
@property (nonatomic, assign) AWProductType productType;
///是否自动续订
@property (nonatomic, assign) BOOL isAutoRenew;
///试用期
@property (nonatomic, assign) BOOL isTrialPeriod;
///购买时间
@property (nonatomic, strong) NSDate *purchaseDate;
///过期时间
@property (nonatomic, strong) NSDate *expiresDate;
///首次购买时间
@property (nonatomic, strong) NSDate *originalPurchaseDate;
///宽限期过期时间
@property (nonatomic, strong) NSDate *gracePeriodExpiresDate;
/// 状态订单状态：0 未付款 1 付款正常使用 2 取消 3 过期 4 宽限期 5 暂停',
@property (nonatomic, assign) int status;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

//
//  AWStripePurchaseInfo.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWStripeEntitlementModel.h"
#import "AWStripeOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWStripePurchaseInfo : NSObject

/// 权益
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *,NSArray< AWStripeEntitlementModel *> *> *entitlementsDic;
/// 订单
@property (nonatomic, strong, nullable) NSMutableArray<AWStripeOrderModel *> *orders;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

//
//  AWStripePurchaseInfo.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWStripeEntitlementModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWStripePurchaseInfo : NSObject

/// 权益
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *,AWStripeEntitlementModel *> *entitlement;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

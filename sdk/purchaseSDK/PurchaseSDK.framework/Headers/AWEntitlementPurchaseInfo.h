//
//  AWEntitlementPurchaseInfo.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWEntitlementModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWEntitlementPurchaseInfo : NSObject

/// 权益
@property (nonatomic, strong, nullable) NSMutableDictionary<NSString *,AWEntitlementModel *> *entitlement;


- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END

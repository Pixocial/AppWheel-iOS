//
//  AWEntitlementsManager.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/3/24.
//

#import <Foundation/Foundation.h>
#import "AWEntitlementPurchaseInfo.h"
#import "AWError.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWEntitlementsManager : NSObject

//+ (id)sharedInstance;

- (void)queryOrdersWithCompletion:(void (^)(BOOL success,
                                            AWEntitlementPurchaseInfo * _Nullable info,
                                            AWError * _Nullable error))completion;

- (nullable AWEntitlementPurchaseInfo *)getPurchaseInfo;
@end

NS_ASSUME_NONNULL_END

//
//  AWSUbscribeModel1.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import <Foundation/Foundation.h>
#import "AWSubscribeBtnModel.h"
#import <PurchaseSDK/InAppPurchaseKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWSUbscribeViewModel1 : NSObject

- (void)purchaseWithProduct:(Product *)product
             withCompletion:(void (^)(BOOL success, InAppPurchaseError * error))completion;


- (void)restoreWithCompletion:(void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, InAppPurchaseError * restoredSubscriptionResult))completion;

@end

NS_ASSUME_NONNULL_END

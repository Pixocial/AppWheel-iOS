//
//  InAppPurchaseObserver.h
//  AFNetworking
//
//  Created by Ellise on 2020/6/1.
//

#import <Foundation/Foundation.h>
#import "PurchasedProduct.h"
#import "LatestSubscriptionInfo.h"
#import "InAppPurchaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol InAppPurchaseObserver <NSObject>

//- (void)iapUnlockedItemsUpdated:(NSArray<PurchasedProduct *> *)purchasedProducts;

//- (void)subscriptionStateUpdated;
//
- (void)purchases:(InAppPurchaseInfo *) purchaseInfo;

//@optional
//
//- (void)subscriptionReceiptInfoUpdated;
//
//- (void)validSubscriptionsUpdated:(NSArray<LatestSubscriptionInfo *> *)validSubscriptions;

@end

NS_ASSUME_NONNULL_END

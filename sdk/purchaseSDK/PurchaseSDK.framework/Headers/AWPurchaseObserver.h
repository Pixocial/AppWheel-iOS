//
//  AWPurchaeObserver.h
//  AFNetworking
//
//  Created by Ellise on 2020/6/1.
//

#import <Foundation/Foundation.h>
#import "PurchasedProduct.h"
#import "LatestSubscriptionInfo.h"
#import "AWPurchaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AWPurchaseObserver <NSObject>

//- (void)iapUnlockedItemsUpdated:(NSArray<PurchasedProduct *> *)purchasedProducts;

//- (void)subscriptionStateUpdated;
//
- (void)purchases:(AWPurchaseInfo *) purchaseInfo;

//@optional
//
//- (void)subscriptionReceiptInfoUpdated;
//
//- (void)validSubscriptionsUpdated:(NSArray<LatestSubscriptionInfo *> *)validSubscriptions;

@end

NS_ASSUME_NONNULL_END

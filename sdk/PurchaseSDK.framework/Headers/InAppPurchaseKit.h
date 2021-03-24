//
//  InAppPurchaseKit.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaymentDiscountOffer.h"
#import "LatestSubscriptionInfo.h"
#import "Product.h"
#import "ProductsRequest.h"
#import "PurchasedProduct.h"
#import "InAppPurchaseError.h"
#import "InAppPurchaseObserver.h"
#import "InAppPurchaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface InAppPurchaseKit : NSObject

+ (void)setDebug:(BOOL)isDebug;

+ (void)configureWithAppId:(NSInteger)appId
                       uid:(NSString * _Nullable)appUserId
                completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

//+ (void)updateInAppLanguage:(NSString * _Nullable)inAppLanguage
//                 firebaseId:(NSString * _Nullable)firebaseId
//                appsflyerId:(NSString * _Nullable)appsflyerId
//                        gid:(NSString * _Nullable)gid;

+ (void)setShouldAddStorePaymentBlock:(void (^)(Product * product, SKPayment * payment))completion;

+ (void)setRevokeEntitlementsBlock:(void (^)(NSArray<NSString *> * productIdentifiers))completion;

+ (void)addPurchaseObserver:(id<InAppPurchaseObserver>)observer;

+ (void)removePurchaseObserver:(id<InAppPurchaseObserver>)observer;

+ (void)getProductsInfoWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers
                                     completion:(void (^)(RetrievedProducts * retrievedProducts))completion;

+ (void)purchaseProduct:(Product *)product
        paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
               quantity:(NSInteger)quantity
            productType:(NSString *)productType
             completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                             paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
                                    quantity:(NSInteger)quantity
                                 productType:(NSString *)productType
                                  completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)subscribeProduct:(Product *)product
         paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
             productType:(NSString *)productType
              completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)subscribeProductIdentifier:(NSString *)productIdentifier
                   paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
                       productType:(NSString *)productType
                        completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                                    quantity:(NSInteger)quantity
                                 productType:(NSString *)productType
                                  completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)subscribeProductFromAppStorePromotion:(Product *)product
                                      payment:(SKPayment *)skPayment
                                  productType:(NSString *)productType
                                   completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)fetchSubscriptionOfferWithProductIdentifier:(NSString *)productIdentifier
                        subscriptionOfferIdentifier:(NSString *)subscriptionOfferIdentifier
                                         completion:(void (^)(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error))completion;

+ (void)restorePurchaseWithCompletion:(nullable void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, InAppPurchaseError * restoredSubscriptionResult))completion;

+ (void)refreshInAppPurchaseInfoWithCompletion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)changeToPreproduction:(BOOL)isPreHost;

+ (InAppPurchaseInfo *)getPurchaseInfo;

//+ (void)refreshInAppPurchaseState;

//+ (BOOL)isSubscriptionUnlockedUser;

//+ (BOOL)userInGracePeriod;

//+ (BOOL)productUnlocked:(NSString *)productIdentifier;

//+ (NSInteger)productQuantity:(NSString *)productIdentifier;

//+ (NSDate * _Nullable)originalTransactionDate;

//+ (NSDate * _Nullable)currentSubscriptionExpiredDate;

//+ (NSDate * _Nullable)currentGracePeriodExpiredDate;

//+ (LatestSubscriptionInfo *)getLatestSubscriptionInfo;

//+ (NSArray<LatestSubscriptionInfo *> *)getCurrentValidSubscriptions;

+ (void)refreshValidSubscriptions;

//+ (BOOL)isSubscriptionValid:(NSString *)productIdentifier;

//+ (NSArray *)purchasedItems;

//+ (NSArray<LatestSubscriptionInfo *> *)getAllSubscriptions;

+ (void)updateRemoteTime;

+ (void)presentCodeRedemptionSheet API_AVAILABLE(ios(14.0));

+ (void)delKC;

+ (void)getRetryPeriodWithCompletion:(nullable void (^)(BOOL isInRetryPeriod,  InAppPurchaseError *error))completion;
@end

NS_ASSUME_NONNULL_END

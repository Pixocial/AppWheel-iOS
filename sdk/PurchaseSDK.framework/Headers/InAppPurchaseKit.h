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
#import "AWProductManager.h"
#import "AWCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InAppPurchaseKit : NSObject

+ (void)setDebug:(BOOL)isDebug;

+ (NSString *)getVersion;

+ (void)configureWithAppId:(NSInteger)appId
                        uid:(NSString *)appUserId
              applicationId:(NSString * _Nullable)applicationIdentifier
                    apiKey:(NSString * _Nullable)apiKey
             inAppLanguage:(NSString * _Nullable)inAppLanguage
                firebaseId:(NSString * _Nullable)firebaseId
               appsflyerId:(NSString * _Nullable)appsflyerId
                completion:(void (^)(BOOL, InAppPurchaseError * _Nonnull))completion;

+ (void)configureWithAppId:(NSInteger)appId
                       uid:(nullable NSString *)appUserId
                completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)setShouldAddStorePaymentBlock:(void (^)(Product * product, SKPayment * payment))completion;

+ (void)setRevokeEntitlementsBlock:(void (^)(NSArray<NSString *> * productIdentifiers))completion;

+ (void)addPurchaseObserver:(id<InAppPurchaseObserver>)observer;

+ (void)removePurchaseObserver:(id<InAppPurchaseObserver>)observer;

+ (void)getProductsInfoWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers
                                     completion:(void (^)(RetrievedProducts * retrievedProducts))completion;

+ (void)purchaseProduct:(Product *)product
        paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
             completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                             paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
                                    quantity:(NSInteger)quantity
                                 productType:(NSInteger)productType
                                  completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                                    quantity:(NSInteger)quantity
                                 productType:(NSInteger)productType
                                  completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)subscribeProductFromAppStorePromotion:(Product *)product
                                      payment:(SKPayment *)skPayment
                                  productType:(NSInteger)productType
                                   completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)fetchSubscriptionOfferWithProductIdentifier:(NSString *)productIdentifier
                        subscriptionOfferIdentifier:(NSString *)subscriptionOfferIdentifier
                                         completion:(void (^)(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error))completion;

+ (void)restorePurchaseWithCompletion:(nullable void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, InAppPurchaseError * restoredSubscriptionResult))completion;

+ (void)refreshInAppPurchaseInfoWithCompletion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)changeToPreproduction:(BOOL)isPreHost;

+ (InAppPurchaseInfo *)getPurchaseInfo;

+ (void)refreshValidSubscriptions;

+ (void)updateRemoteTime;

+ (void)presentCodeRedemptionSheet API_AVAILABLE(ios(14.0));

+ (void)delKC;

+ (void)getRetryPeriodWithCompletion:(nullable void (^)(BOOL isInRetryPeriod,  InAppPurchaseError *error))completion;

+ (NSString *)getUserId;

+ (void)checkProductPurchaseHistoryStatus:(NSString *)productIdentifier completion:(nullable void (^)(ProductFreeTrialStatus productFreeTrialStatus, ProductPaidStatus productPaidStatus))completion;

/// 请求优惠券
+ (void)queryCouponDetail:(nullable void (^)(BOOL success,AWCouponModel * _Nullable model, InAppPurchaseError * _Nullable error))completion;

+ (void)updateConponStateWithTaskId:(long)taskId
                     withCompletion:(nullable void (^)(BOOL success, InAppPurchaseError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END

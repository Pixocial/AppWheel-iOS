//
//  AWPurchaseKit.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AWPaymentDiscountOffer.h"
#import "LatestSubscriptionInfo.h"
#import "AWProduct.h"
#import "AWProductsRequest.h"
#import "PurchasedProduct.h"
#import "AWError.h"
#import "AWPurchaseObserver.h"
#import "AWPurchaseInfo.h"
#import "AWProductManager.h"
#import "AWCouponModel.h"
#import "AWStripePurchaseInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWPurchaseKit : NSObject

+ (void)setDebug:(BOOL)isDebug;

+ (NSString *)getVersion;

+ (void)configureWithAppId:(NSInteger)appId
                        uid:(NSString *)appUserId
              applicationId:(NSString * _Nullable)applicationIdentifier
                    apiKey:(NSString * _Nullable)apiKey
                    secret:(NSString *)secret
             inAppLanguage:(NSString * _Nullable)inAppLanguage
                firebaseId:(NSString * _Nullable)firebaseId
               appsflyerId:(NSString * _Nullable)appsflyerId
                completion:(void (^)(BOOL, AWError * _Nonnull))completion;

+ (void)configureWithAppId:(NSInteger)appId
                    secret:(NSString *)secret
                       uid:(nullable NSString *)appUserId
                completion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)setShouldAddStorePaymentBlock:(void (^)(AWProduct * product, SKPayment * payment))completion;

+ (void)setRevokeEntitlementsBlock:(void (^)(NSArray<NSString *> * productIdentifiers))completion;

+ (void)addPurchaseObserver:(id<AWPurchaseObserver>)observer;

+ (void)removePurchaseObserver:(id<AWPurchaseObserver>)observer;

+ (void)getProductsInfoWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers
                                     completion:(void (^)(RetrievedProducts * retrievedProducts))completion;

+ (void)purchaseProduct:(AWProduct *)product
               quantity:(NSInteger)quantity
            productType:(AWProductType)productType
        paymentDiscount:(AWPaymentDiscountOffer * _Nullable)paymentDiscount
             completion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                             paymentDiscount:(AWPaymentDiscountOffer * _Nullable)paymentDiscount
                                    quantity:(NSInteger)quantity
                                 productType:(AWProductType)productType
                                  completion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier
                                    quantity:(NSInteger)quantity
                                 productType:(AWProductType)productType
                                  completion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)subscribeProductFromAppStorePromotion:(AWProduct *)product
                                      payment:(SKPayment *)skPayment
                                  productType:(AWProductType)productType
                                   completion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)fetchSubscriptionOfferWithProductIdentifier:(NSString *)productIdentifier
                        subscriptionOfferIdentifier:(NSString *)subscriptionOfferIdentifier
                                         completion:(void (^)(AWPaymentDiscountOffer * _Nullable paymentDiscount, AWError * error))completion;

+ (void)restorePurchaseWithCompletion:(nullable void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, AWError * restoredSubscriptionResult))completion;

+ (void)refreshInAppPurchaseInfoWithCompletion:(nullable void (^)(BOOL success, AWError * error))completion;

+ (void)changeToPreproduction:(BOOL)isPreHost;

+ (AWPurchaseInfo *)getPurchaseInfo;

+ (void)refreshValidSubscriptions;

+ (void)updateRemoteTime;

+ (void)presentCodeRedemptionSheet API_AVAILABLE(ios(14.0));

+ (void)delKC;

+ (void)getRetryPeriodWithCompletion:(nullable void (^)(BOOL isInRetryPeriod,  AWError *error))completion;

+ (NSString *)getUserId;

+ (void)checkProductPurchaseHistoryStatus:(NSString *)productIdentifier completion:(nullable void (^)(ProductFreeTrialStatus productFreeTrialStatus, ProductPaidStatus productPaidStatus))completion;

/// 请求优惠券
+ (void)queryCouponDetail:(nullable void (^)(BOOL success,AWCouponModel * _Nullable model, AWError * _Nullable error))completion;

+ (void)updateConponStateWithTaskId:(long)taskId
                     withCompletion:(nullable void (^)(BOOL success, AWError * _Nullable error))completion;

+ (void)requestProductsWithOfferCodeId:(NSInteger)codeId
                             offerCode:(NSString *)offerCode
                  productsFetchedBlock:(OfferCodeProductsBlock)offerCodeProductsBlock;

+ (void)consumeOfferCodeId:(NSInteger)offercodeId
                 offerCode:(NSString *)offerCode
          subscriptionInfo:(LatestSubscriptionInfo *)info
              withComplete:(nullable void (^)(BOOL success, AWError * _Nullable error))completion;



+ (void)queryStripeOrdersWithCompletion:(void (^)(BOOL success,
                                            AWStripePurchaseInfo * _Nullable info,
                                                  AWError * _Nullable error))completion;

+ (AWStripePurchaseInfo *)getStripePurchaseInfo;



@end
NS_ASSUME_NONNULL_END

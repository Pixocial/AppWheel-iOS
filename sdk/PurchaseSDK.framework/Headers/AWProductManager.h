//
//  AWProductManager.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "AWPaymentDiscountOffer.h"
#import "AWError.h"
#import "AWProduct.h"
#import "AWProductsRequest.h"
#import "LatestSubscriptionInfo.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^PaymentDiscountBlock)(AWPaymentDiscountOffer * _Nullable paymentDiscount, AWError * error);

typedef enum : NSUInteger {
    /// 没有被试用过
    ProductFreeTrialStatusNone = 0,
    /// 被试用过了
    ProductFreeTrialStatusUsed
} ProductFreeTrialStatus;

typedef enum : NSUInteger {
    ProductPaidStatusNone,
    ProductPaidStatusPaid
} ProductPaidStatus;

@interface ProductsInfoQuery : NSObject

@end


@interface AWProductManager : NSObject

+ (instancetype)sharedInstance;
/// 获取优惠签名
- (void)getDiscountSignWithProductId:(NSString *)productId
                            discountId:(NSString *)discountId
                            completion:(PaymentDiscountBlock)completion;

- (void)requestProductsWithIds:(NSSet<NSString *> *)productIdentifiers
          productsFetchedBlock:(ProductsFetchedBlock)productsFetchedBlock;

- (SKProduct *)getSKProductWithIdFromCache:(NSString *)identifier;

- (void)saveSKProducts2Cache:(NSArray<SKProduct *> *)products;

- (void)checkProductPurchaseHistoryStatus:(NSString *)productIdentifier completion:(nullable void (^)(ProductFreeTrialStatus productFreeTrialStatus, ProductPaidStatus productPaidStatus))completion;

- (void)requestProductsWithOfferCodeId:(NSInteger) codeId
                             offerCode:(NSString *)offerCode
                  productsFetchedBlock:(OfferCodeProductsBlock)offerCodeProductsBlock;

- (void)consumeOfferCodeId:(NSInteger)offercodeId
                 offerCode:(NSString *)offerCode
          subscriptionInfo:(LatestSubscriptionInfo *)info
              withComplete:(nullable void (^)(BOOL success, AWError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END

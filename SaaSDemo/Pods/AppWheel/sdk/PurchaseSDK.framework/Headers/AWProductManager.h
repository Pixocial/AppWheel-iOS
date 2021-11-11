//
//  AWProductManager.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "PaymentDiscountOffer.h"
#import "InAppPurchaseError.h"
#import "Product.h"
#import "ProductsRequest.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^PaymentDiscountBlock)(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error);

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

@end

NS_ASSUME_NONNULL_END
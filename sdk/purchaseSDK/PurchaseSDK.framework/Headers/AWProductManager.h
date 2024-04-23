//
//  AWProductManager.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "AWPaymentDiscountOffer.h"
#import  <AWCore/AWError.h>
#import "AWProduct.h"
#import "AWProductsRequest.h"
#import "LatestSubscriptionInfo.h"
#import "AWProductPurchaseState.h"


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
///
- (void)getDiscountSignWithProduct:(AWProduct *)product
                       productType:(AWProductType)type
                        discountId:(NSString *)discountId
                        completion:(PaymentDiscountBlock)completion;

- (void)getSKProductWithSkuId:(NSString *)skuId
                       discount: (AWPaymentDiscountOffer * _Nullable)paymentDiscount
                    productType: (NSInteger)productType
                    withBlock: (void (^)(SKProduct * _Nullable product, AWError * _Nullable error))block;
- (void)requestProductsWithIds:(NSSet<NSString *> *)productIdentifiers
          productsFetchedBlock:(ProductsFetchedBlock)productsFetchedBlock;

- (SKProduct *)getSKProductWithIdFromCache:(NSString *)identifier;

- (void)saveSKProducts2Cache:(NSArray<SKProduct *> *)products;

///该方法支持查询单个SKU的试用与付费历史状态，回调中的ProductFreeTrialStatus与ProductPaidStatus分为未试用/付费与试用过/付费过两种状态。当本地收据为空时，会查询该设备的所有历史记录（包括该设备使用过的所有Apple账号）。该方法仅支持查询当前输入的SKU信息，不包含是否试用过该SKU同组下的其他SKU。
///第一个参数就是：是否被试用过了。第二个就是是否付费过了。
//- (void)checkProductPurchaseHistoryStatus:(NSString *)productIdentifier completion:(nullable void (^)(ProductFreeTrialStatus productFreeTrialStatus, ProductPaidStatus productPaidStatus))completion;


///通过服务器获取商品是否付费过
- (void)getProductHasPaiedWithProductId:(NSString *)productId
                         withcompletion:(void (^)(BOOL success, AWProductPurchaseState * _Nullable state, AWError * _Nullable error))completion;

- (void)checkGroupPurchasedIntroductoryOfferWithGroupId:(NSString *)groupId
                                                    gid:(NSString *)gid
                                                    uid:(NSString * _Nullable)uid
                                                    completion:(void (^)(BOOL success, BOOL purchased, AWError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END

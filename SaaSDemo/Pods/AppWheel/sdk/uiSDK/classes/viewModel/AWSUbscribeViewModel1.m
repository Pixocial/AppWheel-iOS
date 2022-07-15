//
//  AWSUbscribeModel1.m
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import "AWSUbscribeViewModel1.h"
#import "AWPageModel.h"

@implementation AWSUbscribeViewModel1


#pragma mark:- 订阅相关
- (void)querySKUs: (NSSet<NSString *> *)skus
        intoModel: (NSArray<AWSubscribeBtnModel *> *)models
     withComplete:(void (^)(BOOL success,NSString * _Nullable errorMsg))completion {
    [AWPurchaseKit getProductsInfoWithProductIdentifiers:skus completion:^(RetrievedProducts * _Nonnull retrievedProducts) {
        if (!retrievedProducts) {
            completion(NO,nil);
            return;
        }
        if (retrievedProducts.invalidProductIdentifiers && retrievedProducts.invalidProductIdentifiers.count > 0) {
            NSString *errorMsg = [NSString stringWithFormat:@"invalidProductId:%@",[retrievedProducts.invalidProductIdentifiers componentsJoinedByString:@","]];
            completion(NO,errorMsg);
            return;
        }
        for (AWProduct *product in retrievedProducts.validProducts) {
            for (AWSubscribeBtnModel * model in models) {
                if ([model.productId isEqualToString: product.productIdentifier]) {
                    /// todo 这边设置的sku都是订阅的，所以type都是2，如果后续有不是订阅的选项的话这边需要修改
                    product.productType = 2;
                    model.product = product;
                }
            }
        }
        completion(YES,nil);
    }];
}

- (void)purchaseWithProduct:(AWProduct *)product
             withCompletion:(void (^)(BOOL success, AWError * error))completion {
    /// todo 这边设置的sku都是订阅的，所以type都是2，如果后续有不是订阅的选项的话这边需要修改
    [AWPurchaseKit purchaseProduct:product quantity:1 productType:AWProductTypeAutoRenewable paymentDiscount:nil completion:completion];
}

- (void)restoreWithCompletion:(void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, AWError * restoredSubscriptionResult))completion {
    [AWPurchaseKit restorePurchaseWithCompletion:completion];
}


@end

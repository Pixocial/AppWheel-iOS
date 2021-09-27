//
//  AWSUbscribeModel1.m
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import "AWSUbscribeViewModel1.h"

@implementation AWSUbscribeViewModel1

- (void)querySKUs: (NSSet<NSString *> *)skus
        intoModel: (NSArray<AWSubscribeBtnModel *> *)models {
    [InAppPurchaseKit getProductsInfoWithProductIdentifiers:skus completion:^(RetrievedProducts * _Nonnull retrievedProducts) {
        if (!retrievedProducts) {
            return;
        }
        for (Product *product in retrievedProducts.validProducts) {
            for (AWSubscribeBtnModel * model in models) {
                if (model.productId == product.productIdentifier) {
                    model.product = product;
                }
            }
        }
    }];
}

- (void)purchaseWithProduct:(Product *)product
             withCompletion:(void (^)(BOOL success, InAppPurchaseError * error))completion {
    [InAppPurchaseKit purchaseProduct:product paymentDiscount:nil completion:completion];
}

- (void)restoreWithCompletion:(void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, InAppPurchaseError * restoredSubscriptionResult))completion {
    [InAppPurchaseKit restorePurchaseWithCompletion:completion];
}

@end

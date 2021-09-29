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

#pragma mark:- 处理数据
/// 通过递归查找到对应的components
- (AWBaseComponentModel *)findModelInComponents:(NSArray<AWBaseComponentModel *> *)components
                   withName:(NSString *)name {

    for (AWBaseComponentModel *component in components) {
        if ([component.name isEqualToString:name]) {
            return component;
        }
        if (component.components && component.components.count > 0) {
            AWBaseComponentModel *findModel = [self findModelInComponents:component.components withName:name];
            if (findModel) {
                return findModel;
            }
        }
    }
    return nil;
}

@end

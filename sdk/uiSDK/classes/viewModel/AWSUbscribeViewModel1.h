//
//  AWSUbscribeModel1.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import <Foundation/Foundation.h>
#import "AWSubscribeBtnModel.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import "AWBaseComponentModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWSUbscribeViewModel1 : NSObject

- (void)querySKUs: (NSSet<NSString *> *)skus
        intoModel: (NSArray<AWSubscribeBtnModel *> *)models
     withComplete:(void (^)(BOOL success, NSString * _Nullable errorMsg))completion;

- (void)purchaseWithProduct:(AWProduct *)product
             withCompletion:(void (^)(BOOL success, AWError * error))completion;


- (void)restoreWithCompletion:(void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, AWError * restoredSubscriptionResult))completion;

@end

NS_ASSUME_NONNULL_END

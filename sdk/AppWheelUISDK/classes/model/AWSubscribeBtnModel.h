//
//  AWSubscribeBtnModel.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import "AWBaseComponetModel.h"
#import <PurchaseSDK/InAppPurchaseKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWSubscribeBtnModel : AWBaseComponetModel

@property(strong, nonatomic)NSString *productId;
@property(strong, nonatomic)Product *product;

@end

NS_ASSUME_NONNULL_END

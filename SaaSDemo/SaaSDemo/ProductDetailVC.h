//
//  ProductDetailVC.h
//  PurchaseSDKDemo
//
//  Created by yikunHuang on 2021/8/24.
//

#import <UIKit/UIKit.h>
#import <PurchaseSDK/AWPurchaseKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailVC : UIViewController

@property(strong, nonatomic)AWProduct *product;
@end

NS_ASSUME_NONNULL_END

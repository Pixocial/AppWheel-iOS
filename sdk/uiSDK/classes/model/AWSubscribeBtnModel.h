//
//  AWSubscribeBtnModel.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/26.
//

#import "AWBaseComponentModel.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import "AWBaseComponentModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWSKUType) {
    AWSKUType_Year = 0,///年
    AWSKUType_Month = 1,// 月
    AWSKUType_Week = 2,// 周
    AWSKUType_Day = 3,// 日
};

@interface AWSubscribeBtnModel : NSObject

@property(strong, nonatomic)NSString *productId;
@property(strong, nonatomic)AWProduct *product;
@property(strong, nonatomic)AWBaseComponentModel *componentModel;
@property(nonatomic, assign)AWSKUType skuType;

@end

NS_ASSUME_NONNULL_END

//
//  AWProductPurchaseState.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/7/27.
//  商品历史购买状态

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWProductPurchaseState : NSObject
///商品id
@property (nonatomic, strong) NSString * productId;
/// 是否试用过：试过用就是1，没有试过就是0
@property (nonatomic, assign) NSInteger hasTrialed;
/// 是否付费过
@property (nonatomic, assign) NSInteger hasPaid;
/// 当前是否在宽限期
@property (nonatomic, assign) NSInteger inGracePeriod;
///
@property (nonatomic, assign) NSInteger autoRenewStatus;

- (instancetype)initWithDictionary:(NSDictionary *)purchaseState;

- (NSString *)toString;
@end

NS_ASSUME_NONNULL_END

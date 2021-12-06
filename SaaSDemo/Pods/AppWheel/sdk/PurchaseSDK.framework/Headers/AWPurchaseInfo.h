//
//  AWPurchaseInfo.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/3/5.
//

#import <Foundation/Foundation.h>
#import "LatestSubscriptionInfo.h"
#import "PurchasedProduct.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InAppPurchaseSubcriptionState) {
    InAppPurchaseSubcriptionStateUnknown = 0,
    InAppPurchaseSubcriptionStateFreshUser,
    InAppPurchaseSubcriptionStateSubscribed,
    InAppPurchaseSubcriptionStateSubscriptionExpired
};

typedef NS_ENUM(NSInteger, InAppPurchaseGracePeriodState) {
    InAppPurchaseGracePeriodStateUnknown = 0,
    InAppPurchaseGracePeriodStateNotInGracePeriod,
    InAppPurchaseGracePeriodStateInGracePeriod,
    InAppPurchaseGracePeriodStateGracePeriodExpired
};


FOUNDATION_EXPORT NSString * const kIAPOriginalTransactionDateKey;
FOUNDATION_EXPORT NSString * const kIAPLatestSubscriptionInfoKey;
FOUNDATION_EXPORT NSString * const kIAPSubscriptionStateKey;
FOUNDATION_EXPORT NSString * const kIAPGracePeriodStateKey;
FOUNDATION_EXPORT NSString * const kIAPSubscriptionExpiredTimeKey;
FOUNDATION_EXPORT NSString * const kIAPGracePeriodExpiredTimeKey;
FOUNDATION_EXPORT NSString * const kIAPPurchasedItemsKey;
FOUNDATION_EXPORT NSString * const kIAPPurchasedItemInfosKey;
FOUNDATION_EXPORT NSString * const kIAPValidSubscriptionProductsKey;
FOUNDATION_EXPORT NSString * const kIAPAllSubscriptionProductsKey;
FOUNDATION_EXPORT NSString * const kIAPRemoteTimeKey;
FOUNDATION_EXPORT NSString * const kIAPUserInitResult;

@interface AWPurchaseInfo : NSObject {
    
    @protected NSLock * _inAppPurchasedValidSubscriptionsLock;
    @protected NSUserDefaults * _inAppPurchaseInfoUserDefaults;
    @protected NSDate * _remoteDate;
    
    @protected NSLock * _inAppPurchasedItemLock;
    /// 购买到的商品的id数组，不包含自动续订
    @protected  NSArray * _purchasedIds;
    @protected  NSArray<PurchasedProduct *> * _purchasedArray;
    @protected InAppPurchaseSubcriptionState _inAppPurchaseSubcriptionState;
    @protected InAppPurchaseGracePeriodState _inAppPurchaseGracePeriodState;
    @protected NSDate * _subscriptionExpiredDate;
    @protected NSDate * _gracePeriodExpiredDate;
    
    @protected BOOL _isSubscriptionUnlockedUser;
    
    @protected NSMutableArray<LatestSubscriptionInfo *> * _validSubscriptions;
    
    @protected NSMutableArray<LatestSubscriptionInfo *> * _allSubscriptions;
}
- (NSArray *)purchasedIds;

- (NSArray<PurchasedProduct *> *)purchasedArray;

- (NSInteger)productQuantity:(NSString *)productIdentifier;

- (BOOL)isSubscriptionUnlockedUser;

- (NSDate * _Nullable)originalTransactionDate;

- (LatestSubscriptionInfo * _Nullable)getLatestSubscriptionInfo;

- (BOOL)productUnlocked:(NSString *)productIdentifier;

- (void)refreshInAppPurchaseState;

- (NSDate * _Nullable)currentSubscriptionExpiredDate;

- (BOOL)userInGracePeriod;

- (NSDate * _Nullable)currentGracePeriodExpiredDate;

/// 给外部的用户使用的
- (NSArray<LatestSubscriptionInfo *> *)getCurrentValidSubscriptions;

- (BOOL)subscriptionValidCurrently:(NSString *)productId;

- (NSArray<LatestSubscriptionInfo *> *)getAllSubscriptionsInfo;

- (NSDate *)getRemoteTime;
@end

NS_ASSUME_NONNULL_END

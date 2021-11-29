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

@interface AWPurchaseInfo : NSObject


@property (nonatomic, strong, nullable) NSDate * remoteDate;

- (void)updateRemoteTime:(double) remoteDateMS;

- (NSArray *)purchasedIds;

- (NSArray<PurchasedProduct *> *)purchasedArray;

- (NSInteger)productQuantity:(NSString *)productIdentifier;

- (BOOL)isSubscriptionUnlockedUser;

- (void)setOriginalTransactionDate:(NSDate * _Nullable)originalTransactionDate;

- (NSDate * _Nullable)originalTransactionDate;


- (void)saveLatestSubscriptionInfo:(NSDictionary *)latestSubscriptionInfo;

- (LatestSubscriptionInfo * _Nullable)getLatestSubscriptionInfo;


- (void)saveInAppPurchaseItems:(NSArray<NSDictionary *> *)inAppPurchaseItems;

- (BOOL)updateInAppPurchaseItems:(NSString *)productIdentifier quantity:(NSInteger)quantity;

- (BOOL)productUnlocked:(NSString *)productIdentifier;

- (void)removeAllInAppPurchaseItems;


- (void)setInAppPurchaseSubcriptionState:(InAppPurchaseSubcriptionState)state;

- (void)setInAppPurchaseGracePeriodState:(InAppPurchaseGracePeriodState)state;

- (void)refreshInAppPurchaseState;


- (void)setSubscriptionExpiredDate:(NSDate * _Nullable)subscriptionExpiredDate;

- (void)expireSubscription;

- (NSDate * _Nullable)currentSubscriptionExpiredDate;


- (void)checkGracePeriodDate;

- (BOOL)userInGracePeriod;

- (void)setGracePeriodExpiredDate:(NSDate * _Nullable)gracePeriodExpiredDate;

- (void)expireGracePeriod;

- (NSDate * _Nullable)currentGracePeriodExpiredDate;

- (void)saveCurrentValidSubscriptions:(NSArray<NSDictionary *> *)currentValidSubscriptions;

- (void)removeSubscriptionValidCurrently;
/// 给manager 使用的
- (NSArray<LatestSubscriptionInfo *> *)getValidSubscriptions;
/// 给外部的用户使用的
- (NSArray<LatestSubscriptionInfo *> *)getCurrentValidSubscriptions;

- (BOOL)subscriptionValidCurrently:(NSString *)productId;


- (void)saveAllSubscriptions:(NSArray<NSDictionary *> *)subscriptions;

- (NSArray<LatestSubscriptionInfo *> *)getAllSubscriptionsInfo;
@end

NS_ASSUME_NONNULL_END

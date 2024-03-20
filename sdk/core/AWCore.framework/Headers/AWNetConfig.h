//
//  AWNetConfig.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWNetConfig : NSObject


@property (nonatomic, assign) BOOL isUserOld;
///是否调用过init
@property (nonatomic, assign) BOOL isCalledInit;
///多个账号的时候，恢复购买的时候订单是否需要从账号1合并到账号2的标识，默认是需要合并
@property (nonatomic, assign) BOOL isMergeOrders;


+ (instancetype)sharedInstance;

- (BOOL)setAppId:(NSInteger)appId
          userId:(NSString *) userId
          apiKey:(NSString * _Nullable)apiKey
   applicationId:(NSString * _Nullable)applicationIdentifier
          secret:(NSString *)secret
   inAppLanguage:(NSString * _Nullable)inAppLanguage;

- (NSInteger)getSDKVersion;

- (NSDictionary *)basicParams;

- (void)setDebug:(BOOL)isDebug;
- (BOOL)getDebug;
- (NSString *)getApplicationIdentifier;

- (NSString *)getApiKey;

- (NSString *)getInAppLanguage;

- (NSInteger)getAppId;

- (NSString *)getSecret;

- (NSInteger)getRemoteTimeOffset;
- (void)setRemoteTimeOffset:(NSInteger)remoteTime;

@end

NS_ASSUME_NONNULL_END

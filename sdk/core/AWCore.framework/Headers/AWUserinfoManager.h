//
//  AWUserinfoManager.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2021/9/13.
//

#import <Foundation/Foundation.h>
#import  <AWCore/AWError.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWUserinfoManager : NSObject

+ (instancetype)sharedInstance;

- (void)initUserWithAppId:(NSInteger)appId
                      uid:(NSString *)uid
               firebaseId:(NSString * _Nullable)firebaseId
              appsflyerId:(NSString * _Nullable)appsflyerId
               completion:(nullable void (^)(BOOL success, AWError * error))completion;

- (void)setUserAttributes:(NSDictionary *)params
               completion:(nullable void (^)(BOOL success, AWError * error))completion;

- (void)getUserAttributes:(void (^)(BOOL success, NSDictionary* attributs, AWError * error)) completion;
- (NSString *)getUserId;

- (void)delUserId;

- (NSString *)getFirebaseId;

- (NSString *)getAppsFlyerId;
///手动解锁
- (void)manualUnlockWithCompletion:(nullable void (^)(NSInteger result, NSString * _Nullable errorMsg, NSDictionary * _Nullable data))completion;

@end

NS_ASSUME_NONNULL_END

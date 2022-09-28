//
//  AWNewApiManager.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWNewApiManager : NSObject

+ (instancetype)sharedInstance;


- (void)getWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

- (void)getWithPath:(NSString *)path
         pathParams:(NSString * _Nullable)pathParams
        extraParams:(NSDictionary * _Nullable)params
         completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

- (void)postWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

- (void)postWithPath:(NSString *)path
          pathParams:(NSString * _Nullable)pathParams
         extraParams:(NSDictionary * _Nullable)
    params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

- (void)putWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

/// 给不需要携带统一参数的请求使用的，目前使用的模块有：marvel
- (void)mGetWithPath:(NSString *)path
         pathParams:(NSString * _Nullable)pathParams
        extraParams:(NSDictionary * _Nullable)params
          completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

- (void)mGetWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;
@end

NS_ASSUME_NONNULL_END

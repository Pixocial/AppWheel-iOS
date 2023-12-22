//
//  InAppPurchaseHttpManager.h
//  AWPurchaseKit
//
//  Created by Yk Huang on 2021/1/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWHttpManager : NSObject

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration;

- (void)post:(NSString *)URLString
 contentType:(NSString *)contentType
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    success:(nullable void (^)(NSURLSessionTask *task, id _Nullable responseObject, NSString * _Nullable traceId))success
    failure:(nullable void (^)(NSURLSessionTask * _Nullable task, id _Nullable responseObject, NSError *error, NSString * _Nullable traceId))failure;


- (void)put:(NSString *)URLString
 contentType:(NSString *)contentType
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    success:(nullable void (^)(NSURLSessionTask *task, id _Nullable responseObject, NSString * _Nullable traceId))success
    failure:(nullable void (^)(NSURLSessionTask * _Nullable task, id _Nullable responseObject, NSError *error, NSString * _Nullable traceId))failure;


- (void)get:(NSString *)URLString
 contentType:(NSString *)contentType
 parameters:(nullable id)parameters
    headers:(nullable NSDictionary <NSString *, NSString *> *)headers
    success:(nullable void (^)(NSURLSessionTask *task, id _Nullable responseObject, NSString * _Nullable traceId))success
    failure:(nullable void (^)(NSURLSessionTask * _Nullable task, id _Nullable responseObject, NSError *error, NSString * _Nullable traceId))failure;

@end

NS_ASSUME_NONNULL_END

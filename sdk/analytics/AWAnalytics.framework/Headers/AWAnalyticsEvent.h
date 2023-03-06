//
//  AWAnalyticsEvent.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWAnalyticsEvent : NSObject


+ (instancetype)sharedInstance;

- (void)eventWithName:(NSString *)eventName
              withKey:(NSString *)eventKey;

- (void)eventWithName:(NSString *)eventName
              withKey:(NSString *)eventKey
          withTraceId:(NSString * _Nullable)traceId;

- (void)eventPurchaseWithName:(NSString *)eventName
                      withKey:(NSString *)eventKey
                      withSku:(NSString *)sku
                  withTraceId:(NSString * _Nullable)traceId
                      withMsg:(NSString * _Nullable)msg;

- (void)eventWithName:(NSString *)eventName
              withKey:(NSString *)eventKey
          withTraceId:(NSString * _Nullable)traceId
              withMsg:(NSString * _Nullable)msg;

- (void)post2ServerWithName:(NSString *)eventName
                    withKey:(NSString *)eventKey
                    withDic:(NSDictionary *)dic;

- (void)pushFailed;
@end

NS_ASSUME_NONNULL_END

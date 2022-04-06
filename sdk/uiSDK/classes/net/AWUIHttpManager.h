//
//  AWHttpManager.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//  网络请求的类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWUIHttpManager : NSObject

+ (instancetype)sharedInstance;

- (void)setDebug:(BOOL)isDebug;
//post的请求接口
- (void)requestWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;
@end

NS_ASSUME_NONNULL_END

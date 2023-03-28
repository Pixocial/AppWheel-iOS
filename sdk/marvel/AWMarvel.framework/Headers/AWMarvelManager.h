//
//  AWMarvelManager.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2022/8/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWMarvelManager : NSObject

+ (instancetype)sharedInstance;

/// 获取弹窗配置
- (void)getPopupWithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
           withEffectiveFilter:(NSInteger)effectiveFilter
          withTimezoneOffset:(NSInteger)timezoneOffset
                  withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;
/// 弹窗id预览
- (void)getPopupPreviewWithRid:(NSString *)rid
                  WithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

/// 获取启动页
- (void)getStartPageWithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
             withEffectiveFilter:(NSInteger)effectiveFilter
              withTimezoneOffset:(NSInteger)timezoneOffset
                  withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

///获取订阅列表
- (void)getNewSubsWithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
           withEffectiveFilter:(NSInteger)effectiveFilter
            withTimezoneOffset:(NSInteger)timezoneOffset
                withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

/// 获取产品配置
- (void)getProductConfigWithLanguage:(NSString *)language
                withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
           withEffectiveFilter:(NSInteger)effectiveFilter
                     withTimezoneOffset:(NSInteger)timezoneOffset
                         withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;
/// 获取产品配置V2
- (void)getProductConfigV2WithLanguage:(NSString *)language
                withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
           withEffectiveFilter:(NSInteger)effectiveFilter
                     withTimezoneOffset:(NSInteger)timezoneOffset
                         withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

/// 获取banner
- (void)getBannerWithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
                  withAbcodes:(NSString * _Nullable)abcodes
           withEffectiveFilter:(NSInteger)effectiveFilter
           withTimezoneOffset:(NSInteger)timezoneOffset
               withCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;


/// 获取预发布密码
- (void)getPreviewPwdWithCompletion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

///首页配置
- (void)getHomeConfigWithLanguage:(NSString *)language
               withCountryCode:(NSString *)countryCode
                    withPhrase:(NSString * _Nullable)phrase
                    withUpdate:(NSString * _Nullable)update
           withEffectiveFilter:(NSInteger)effectiveFilter
               withTimezoneOffset:(NSInteger)timezoneOffset
                       completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;

///高级开关
- (void)advancedSwitchWith:(NSString *)language
            withCountryCode:(NSString *)countryCode
                 withKey:(NSString * _Nullable)key
                 withUpdate:(NSString * _Nullable)update
                completion:(nullable void (^)(NSInteger result, NSString * errorMsg, NSDictionary * _Nullable data))completion;
@end

NS_ASSUME_NONNULL_END

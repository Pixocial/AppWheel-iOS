//
//  AWHttpManager.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import "AWUIHttpManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+AWMD5.h"

static NSString *awUISDKVersion = @"2.0.1.0";


@interface AWUIHttpManager ()

@property (nonatomic, strong) NSString * applicationIdentifier;

@property (nonatomic, strong) NSString * apiKey;

@property (nonatomic, assign) NSInteger appId;

@property (nonatomic, strong, nullable) NSString * inAppLanguage;

@property (nonatomic, strong) dispatch_queue_t networkQueue;

@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;

@property (nonatomic, assign) BOOL isPreHost;

@property (nonatomic, assign) BOOL isDebug;

@end

@implementation AWUIHttpManager

+ (instancetype)sharedInstance {
    static AWUIHttpManager * sharedInstance;
    static dispatch_once_t aWHttpManagerOnceToken;
    dispatch_once(&aWHttpManagerOnceToken, ^{
        sharedInstance = [[super allocWithZone:NULL] init];
        sharedInstance.networkQueue = dispatch_queue_create("com.awHttpManager.networkQueue", DISPATCH_QUEUE_CONCURRENT);
        
        NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 30;
        configuration.timeoutIntervalForResource = 30;
        sharedInstance.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return self;
}

- (BOOL)setApplicationIdentifier:(NSString *)applicationIdentifier apiKey:(NSString *)apiKey appId:(NSInteger)appId inAppLanguage:(NSString * _Nullable)inAppLanguage {
    if (applicationIdentifier.length && apiKey.length) {
        self.applicationIdentifier = applicationIdentifier;
        self.apiKey = apiKey;
        self.appId = appId;
        self.inAppLanguage = inAppLanguage;
        return YES;
    }
    
    return NO;
}

/// 提供给外部使用，用来切换debug和release的地址的
- (void)setDebug:(BOOL)isDebug {
    self.isDebug = isDebug;
}

- (NSString *)getHost {
    if (self.isDebug) {
        return @"https://api-test.appwheel.com";
    } else {
        return @"https://api.appwheel.com";
    }
}

- (void)setInAppLanguage:(NSString *)inAppLanguage {
    _inAppLanguage = inAppLanguage;
}

- (NSInteger)standardizedVersion:(NSString *)version {
    /*
     Sample： 101031000
     第1位数字        1: 表示平台号，1：Android， 2：iOS
     第2-3位数字   01: 表示大版本号
     第4-5位数字   03: 表示中版本号
     第6-7位数字   10: 表示小版本号
     第8-9位数字   00: 表示内部版本号，用于Google Play上传多个同版本的发布包
     */
    
    if (!version || ![version isKindOfClass:[NSString class]]) {
        version = @"";
    }
    
    NSArray * components = [version componentsSeparatedByString:@"."];
    if (components.count < 4) {
        version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        if (!version || ![version isKindOfClass:[NSString class]]) {
            version = @"0.0.0.0";
            components = [version componentsSeparatedByString:@"."];
        }
    }
    
    NSInteger bigVerNum = components.count >= 1 ? [components[0] integerValue] : 0;
    NSInteger midVerNum = components.count >= 2 ? [components[1] integerValue] : 0;
    NSInteger smallVerNum = components.count >= 3 ? [components[2] integerValue] : 0;
    NSInteger buildnum = components.count >= 4 ? [components[3] integerValue] : 0;
    
    NSString * standardizedVersion = [NSString stringWithFormat:@"2%02ld%02ld%02ld%02ld", bigVerNum % 100 ,midVerNum % 100 ,smallVerNum % 100 ,buildnum % 100];
    return [standardizedVersion integerValue];
}

- (NSDictionary *)basicHeader {
    NSMutableDictionary * header = [[NSMutableDictionary alloc] init];
//    [header setValue:@"ios" forKey:@"platform"];
    if (self.applicationIdentifier.length && self.apiKey.length) {
        [header setValue:self.apiKey forKey:@"apiKey"];
        [header setValue:self.applicationIdentifier forKey:@"applicationId"];
    }
    
    return header;
}

- (NSDictionary *)basicParams {
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    
//    NSInteger timeStamp = [[NSDate date] timeIntervalSince1970];
//    NSString * idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString] ? [[[UIDevice currentDevice] identifierForVendor] UUIDString] : @"";
//
//    NSString * deviceLanguage = [[NSLocale preferredLanguages] count] > 0 ? [[NSLocale preferredLanguages] firstObject] : @"en";
//    NSString * regionCode = [NSLocale currentLocale].countryCode ? [NSLocale currentLocale].countryCode : @"";
//    NSString * language = self.inAppLanguage ? self.inAppLanguage : @"en";
//
//    [params setObject:@(timeStamp) forKey:@"timeStamp"];
    
//    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
//    if ([version isKindOfClass:[NSString class]] && version.length) {
//        [params setObject:version forKey:@"appVer"];
//    }else {
//        [params setObject:@"0.0.0.0" forKey:@"appVer"];
//    }
    
    [params setObject:@([self standardizedVersion:awUISDKVersion]) forKey:@"version"];

//    [params setObject:@(self.appId) forKey:@"appId"];
//    [params setObject:idfv forKey:@"uDeviceId"];
//    [params setObject:deviceLanguage forKey:@"deviceLanguage"];
//    [params setObject:regionCode forKey:@"regionCode"];
//    [params setObject:language forKey:@"language"];
    
    return params;
}

- (NSDictionary *)processedParamsWithExtraParams:(NSDictionary * _Nullable)extraParams {
    NSMutableDictionary * params = [NSMutableDictionary dictionaryWithDictionary:[self basicParams]];
    if (extraParams.count) {
        [params addEntriesFromDictionary:extraParams];
    }
    
    NSMutableArray * keyValues = [[NSMutableArray alloc] init];
    NSCharacterSet * characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]{}\" "] invertedSet];
    
    NSArray * sortedKey = [params.allKeys sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString * s1 = obj1;
        NSString * s2 = obj2;
        NSComparisonResult result = [s1 compare:s2];
        return result;
    }];
    
    for (NSString * key in sortedKey) {
        if ([[params objectForKey:key] isKindOfClass:[NSString class]]) {
            [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, [[params objectForKey:key]  stringByAddingPercentEncodingWithAllowedCharacters:characterSet]]];
        }else {
            [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, [[[params objectForKey:key] stringValue] stringByAddingPercentEncodingWithAllowedCharacters:characterSet]]];
        }
    }
    
    NSString * secret = [keyValues componentsJoinedByString:@"&"];
    NSString * encryptedSecret = [secret MD5];
    [params setObject:encryptedSecret forKey:@"secret"];
    
    return params;
}

- (void)requestWithPath:(NSString *)path extraParams:(NSDictionary * _Nullable)params completion:(nullable void (^)(NSInteger result, NSString * msg, NSDictionary * _Nullable data))completion {
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(self.networkQueue, ^{
        [weakSelf.sessionManager POST:[NSString stringWithFormat:@"%@%@", [weakSelf getHost], path] parameters:[weakSelf processedParamsWithExtraParams:params] headers:[weakSelf basicHeader] progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            dispatch_async(weakSelf.networkQueue, ^{
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    if (completion) {
                        NSDictionary * data = responseObject[@"data"];
                        NSString * message = responseObject[@"message"];
                        NSInteger code = [responseObject[@"code"] integerValue];
                        completion(code, message, data);
                    }
                }else {
                    if (completion) {
                        completion(30001, @"Raw Data from server is not in JSON Serialization", nil);
                    }
                }
            });
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(weakSelf.networkQueue, ^{
                if (completion) {
                    completion(error.code, error.localizedDescription, nil);
                }
            });
        }];
    });
}

@end

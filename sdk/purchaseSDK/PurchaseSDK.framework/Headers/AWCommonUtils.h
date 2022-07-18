//
//  AWCommonUtils.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/8/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWCommonUtils : NSObject

+ (BOOL)isSandBox;

+ (BOOL)checkReceiptInfoAvailable;

+ (BOOL)isJailbroken;

+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dictionary;

+ (NSDictionary *)getDictFromjsonString:(NSString *)jsonString;

@end

NS_ASSUME_NONNULL_END

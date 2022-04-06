//
//  AWCommonUtil.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWCommonUtil : NSObject

/// 把字典转换为jsonString
+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dictionary;

/// 把jsonString转换为NSDictionary
+ (NSDictionary *)getDictFromjsonString:(NSString *)jsonString;
@end

NS_ASSUME_NONNULL_END

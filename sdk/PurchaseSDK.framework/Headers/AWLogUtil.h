//
//  AWLogUtil.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2021/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWLogUtil : NSObject


+ (void)isCanLog:(BOOL)isCanLog;
+ (Boolean)getCanLog;

+ (void)print:(NSString *)log;

+ (NSMutableString *)getLog;

+ (void)clearLog;

@end

NS_ASSUME_NONNULL_END

//
//  AWRGBUtil.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWRGBUtil : NSObject

+ (UIColor *)RGBWithR:(float)r
                    g:(float)g
                    b:(float)b;

+ (UIColor *)RGB:(int)hexValue;

+ (UIColor *)RGBHex:(NSString *)hexValue;

+ (UIColor *)RGBHex:(NSString *)hexValue
            opacity:(CGFloat)opacity;
@end

NS_ASSUME_NONNULL_END

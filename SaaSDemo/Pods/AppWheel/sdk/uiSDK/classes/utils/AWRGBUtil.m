//
//  AWRGBUtil.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import "AWRGBUtil.h"
#import "AWUIDef.h"

@implementation AWRGBUtil

+ (UIColor *)RGBWithR:(float)r
                    g:(float)g
                    b:(float)b {
    return [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f];
}

+ (UIColor *)RGBWithR:(float)r
                    g:(float)g
                    b:(float)b
                    a:(float)a {
    return [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:a];
}

+ (UIColor *)RGB:(int)hexValue {
    return [self RGBWithR:(float)((hexValue & 0xFF0000) >> 16) g:(float)((hexValue & 0xFF00) >> 8) b:(float)(hexValue & 0xFF)];
}


+ (UIColor *)RGBHex:(NSString *)hexValue {
    return [self RGBHex:hexValue opacity:1.0];
}

///opacity:0-1.0的CGFloat类型
+ (UIColor *)RGBHex:(NSString *)hexValue
            opacity:(CGFloat)opacity {
    NSString *cString = [[hexValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
    if ([cString length] < 6) {
        return [self RGBWithR:255 g:255 b:255];
    }
            
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [self RGBWithR:255 g:255 b:255];
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    if (opacity) {
//        float opacityF = [opacity floatValue];
        return [self RGBWithR:r g:g b:b a:opacity];
    }
    return [self RGBWithR:r g:g b:b];
}


@end

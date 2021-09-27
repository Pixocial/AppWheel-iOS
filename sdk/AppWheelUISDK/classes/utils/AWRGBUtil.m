//
//  AWRGBUtil.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import "AWRGBUtil.h"

@implementation AWRGBUtil

+ (UIColor *)RGBWithR:(float)r
                    g:(float)g
                    b:(float)b {
    return [UIColor colorWithRed:r / 255.f green:g / 255.f blue:b / 255.f alpha:1.f];
}

+ (UIColor *)RGB:(int)hexValue {
    return [self RGBWithR:(float)((hexValue & 0xFF0000) >> 16) g:(float)((hexValue & 0xFF00) >> 8) b:(float)(hexValue & 0xFF)];
}

+ (UIColor *)RGBHex:(NSString *)hexValue {
    NSString *cString = [[hexValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
    if ([cString length] < 6) {
        return [self RGBWithR:0 g:0 b:0];
    }
            
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [self RGBWithR:0 g:0 b:0];
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
    return [self RGBWithR:r g:g b:b];
//    return [UIColor colorWithRed:((float) r / 255.0f)
//                           green:((float) g / 255.0f)
//                            blue:((float) b / 255.0f)
//                           alpha:1.0f];

}


@end

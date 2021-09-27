//
//
//  AirBrush
//
//  Created by Webster Wu on 12/30/15.
//  Copyright © 2015 美图网. All rights reserved.
//


#import "NSString+AWMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (AWMD5)

// 32 MD5 enconde
- (nonnull NSString *)MD5 {
    const char *str = [self UTF8String];
    unsigned char md5_buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), md5_buffer);
    
    NSMutableString *string = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i=0; i<CC_MD5_DIGEST_LENGTH; i ++) {
        [string appendFormat:@"%02x",md5_buffer[i]];
    }
    return string;
}

@end

//
//  AWUBundleUtil.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import "AWUBundleUtil.h"

@implementation AWUBundleUtil

+ (NSString *)getResourcePath:(NSString *)resource {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"AWUI" ofType:@"bundle"];
    NSString *resourcePath = [bundlePath stringByAppendingString:resource];
    return resourcePath;
}

@end

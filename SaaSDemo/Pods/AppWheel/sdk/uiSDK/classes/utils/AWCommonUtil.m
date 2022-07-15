//
//  AWCommonUtil.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import "AWCommonUtil.h"

@implementation AWCommonUtil

+ (NSString *)getJSONStringFromDictionary:(NSDictionary *)dictionary {
    if (!dictionary) {
        return @"";
    }
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:(NSJSONWritingOptions)0 error:nil];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (jsonString) {
        return jsonString;
    }else {
        return @"";
    }
}

+ (NSDictionary *)getDictFromjsonString:(NSString *)jsonString {
    NSDictionary *retDict = nil;
    if ([jsonString isKindOfClass:[NSString class]]) {
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        retDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        return  retDict;
    }else{
        return retDict;
    }

}

@end

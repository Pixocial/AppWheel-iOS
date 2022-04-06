//
//  AWStyleModel.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWStyleModel.h"

@implementation AWStyleModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
        [self parse:dict];
    }
    return self;
}
- (void)parse: (NSDictionary *)dict {
    self.fontSize = dict[@"fontSize"];
    self.backgroundColor = dict[@"backgroundColor"];
    self.color = dict[@"color"];
    self.opacity = [dict[@"opacity"] floatValue];
}

@end

//
//  AWAttrModel.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/28.
//

#import "AWAttrModel.h"

@implementation AWAttrModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
        [self parse:dict];
    }
    return self;
}
- (void)parse: (NSDictionary *)dict {
    self.src = dict[@"src"];
}
@end

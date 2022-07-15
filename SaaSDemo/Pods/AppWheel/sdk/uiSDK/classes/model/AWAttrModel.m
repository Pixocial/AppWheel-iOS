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
    self.herf = dict[@"herf"];
    self.skuId = dict[@"skuId"];
    self.comparePrice = dict[@"comparePrice"];
    if (dict[@"animation"]) {
        self.animation = [dict[@"animation"] integerValue];
    }
    if (dict[@"available"]) {
        self.available = [dict[@"available"] boolValue];
    } else {
        self.available = YES;
    }
    self.video = dict[@"video"];
    
}
@end

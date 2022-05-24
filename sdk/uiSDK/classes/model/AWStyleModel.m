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
    self.fontStyle = dict[@"fontStyle"];
    self.fontWeight = dict[@"fontWeight"];
    self.textDecoration = dict[@"textDecoration"];
    self.backgroundColor = dict[@"backgroundColor"];
    self.color = dict[@"color"];
    self.opacity = [dict[@"opacity"] floatValue];
    if (dict[@"colors"]) {
        if (!_colors) {
            _colors = [[NSMutableArray alloc]init];
        }
        self.colors = dict[@"colors"];
    }
}

@end

//
//  BaseComponetModel.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWBaseComponetModel.h"


@implementation AWBaseComponetModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end

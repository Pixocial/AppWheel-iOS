//
//  BaseComponetModel.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWBaseComponentModel.h"
#import "NSString+AWCategory.h"
#import "AWUIDef.h"
#import "AWRGBUtil.h"


@implementation AWBaseComponentModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        [self parse:dict];
    }
    return self;
}
- (void)parse: (NSDictionary *)dict {
    self.id = dict[@"id"];
    self.name = dict[@"name"];
    self.type = dict[@"type"];
    [self parseStyle: dict[@"style"]];
    [self parseAttr: dict[@"attr"]];
    self.text = dict[@"text"];
    [self parseComponents:dict[@"components"]];
    self.textList = dict[@"textList"];
}

- (void)parseComponents: (NSArray<NSDictionary *> *)array {
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        AWBaseComponentModel *model = [[AWBaseComponentModel alloc] initWithDict:dict];
        [modelArray addObject:model];
    }
    if (modelArray.count > 0) {
        self.components = modelArray;
    }
}

- (void)parseStyle: (NSDictionary *)dict {
    if (dict) {
        self.style = [[AWStyleModel alloc]initWithDict:dict];
    }
}

- (void)parseAttr: (NSDictionary *)dict {
    if (dict) {
        self.attr = [[AWAttrModel alloc]initWithDict:dict];
    }
}

#pragma mark:- 在对应的控件上展示
- (void)setDataToLabel:(UILabel *)label {
    if ([self.text isKindOfClass:[NSNumber class]]) {
        NSString *text = [NSString stringWithFormat:@"%@", self.text];
        label.text = text;
    }else if ([self.text isKindOfClass:[NSString class]]) {
        if (!IS_EMPTY_STRING(self.text)) {
            label.text = self.text;
        }
        
    }
    if (self.style && !IS_EMPTY_STRING(self.style.fontSize)) {
        int fontSize = [self.style.fontSize extractNumber];
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    
    if (self.style && !IS_EMPTY_STRING(self.style.backgroundColor)) {
        label.backgroundColor = [AWRGBUtil RGBHex:self.style.backgroundColor];
    }
    if (self.style && !IS_EMPTY_STRING(self.style.color)) {
        label.textColor = [AWRGBUtil RGBHex:self.style.color opacity:self.style.opacity];
    }
    
}

@end

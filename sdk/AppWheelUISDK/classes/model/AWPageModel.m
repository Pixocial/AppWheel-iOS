//
//  AWRGBUtil.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import "AWPageModel.h"

/// 标题主体
const NSString *awPage1BannerDiv = @"bannerDiv";
/// 主标题
const NSString *awPage1MainTitle = @"mainTitle";
/// 副标题
const NSString *awPage1TitleMessage = @"titleMessage";

@implementation AWPageModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        [self parseDict2Model:dict];
    }
    return self;
}

- (void)parseDict2Model: (NSDictionary *)dict {
    self.template = [dict[@"template"] intValue];
    self.pageId = dict[@"pageId"];
    self.pageName = dict[@"pageName"];
    [self parseComponents:dict[@"components"]];
    
}

- (void)parseComponents: (NSArray<NSDictionary *> *)array {
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        AWBaseComponetModel *model = [[AWBaseComponetModel alloc] initWithDict:dict];
        [modelArray addObject:model];
    }
    if (modelArray.count > 0) {
        self.components = modelArray;
    }
}

@end

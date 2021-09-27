//
//  AWRGBUtil.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AWBaseComponetModel.h"


NS_ASSUME_NONNULL_BEGIN


/// 定义的type对应的组件 ////

/// 标题主体
FOUNDATION_EXPORT const NSString *awPage1BannerDiv;
/// 主标题
FOUNDATION_EXPORT const NSString *awPage1MainTitle;
/// 副标题
FOUNDATION_EXPORT const NSString *awPage1TitleMessage;

static const int TEMPLATE_1 = 1;

@interface AWPageModel : NSObject
/// 页面id
@property(nonatomic, assign)NSString *pageId;
/// 页面名称
@property(nonatomic, assign)NSString *pageName;
/// 模版id
@property(nonatomic, assign)int template;
/// 嵌套的组件
@property(nonatomic, strong)NSArray<AWBaseComponetModel *> *components;
/// 使用dictionary的初始化方式
- (instancetype)initWithDict: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

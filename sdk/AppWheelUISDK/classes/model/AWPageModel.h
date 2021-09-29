//
//  AWRGBUtil.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/4/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AWBaseComponentModel.h"


NS_ASSUME_NONNULL_BEGIN

static const int TEMPLATE_1 = 1;

@interface AWPageModel : NSObject
/// 页面id
@property(nonatomic, strong)NSString *pageId;
/// 页面名称
@property(nonatomic, strong)NSString *pageName;
/// 模版id
@property(nonatomic, assign)int template;
/// 嵌套的组件
@property(nonatomic, strong)NSArray<AWBaseComponentModel *> *components;
/// 使用dictionary的初始化方式
- (instancetype)initWithDict: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

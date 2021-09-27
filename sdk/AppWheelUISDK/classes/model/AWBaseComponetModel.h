//
//  BaseComponetModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//  控件的最小单位的数据model

#import <Foundation/Foundation.h>
#import "AWStyleModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWBaseComponetModel : NSObject

/// 编号
@property (weak, nonatomic) NSString *id;
/// 名称
@property (weak, nonatomic) NSString *name;
/// 类型：用来区分具体是哪一个控件
@property (weak, nonatomic) NSString *type;
/// 文本
@property (weak, nonatomic) NSArray<NSString *> *text;
/// 类型
@property (weak, nonatomic) AWStyleModel *style;
/// 属性
@property (weak, nonatomic) NSObject *attr;
/// 嵌套的组件
@property(nonatomic, strong)NSArray<AWBaseComponetModel *> *components;
/// web端用的字段，目前iOS没用
@property(nonatomic, assign)int themeIndex;
@property(nonatomic, assign)int level;
@property(nonatomic, assign)int theme;

- (instancetype)initWithDict: (NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

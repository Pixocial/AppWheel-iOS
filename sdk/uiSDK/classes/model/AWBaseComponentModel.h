//
//  BaseComponetModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//  控件的最小单位的数据model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AWStyleModel.h"
#import "AWAttrModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWBaseComponentModel : NSObject

/// 编号
@property (strong, nonatomic) NSString *id;
/// 名称
@property (strong, nonatomic) NSString *name;
/// 类型：用来区分具体是哪一个控件
@property (strong, nonatomic) NSString *type;
/// 文本
@property (strong, nonatomic) NSString *text;
/// 类型
@property (strong, nonatomic) AWStyleModel *style;
/// 属性
@property (strong, nonatomic) AWAttrModel *attr;
/// 嵌套的组件
@property(nonatomic, strong)NSArray<AWBaseComponentModel *> *components;
/// 有些是多个文案的字段
@property(nonatomic, strong)NSArray<NSString *> *textList;

/// web端用的字段，目前iOS没用
@property(nonatomic, assign)int themeIndex;
@property(nonatomic, assign)int level;
@property(nonatomic, assign)int theme;

- (instancetype)initWithDict: (NSDictionary *)dict;
/// 把字体、文字啥的设置给label
- (void)setDataToLabel:(UILabel *)label;
- (void)setTextColor:(UILabel *)label;
- (void)setTextAndTextColor:(UILabel *)label;
@end

NS_ASSUME_NONNULL_END

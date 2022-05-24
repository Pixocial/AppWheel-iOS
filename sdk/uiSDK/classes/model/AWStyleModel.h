//
//  AWStyleModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//  样式：包含颜色、字体等样式属性

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWStyleModel : NSObject

/// 字体大小
@property (strong, nonatomic) NSString *fontSize;
/// 斜体：italic & normal
@property (strong, nonatomic) NSString *fontStyle;
///下划线
@property (strong, nonatomic) NSString *textDecoration;
///粗体
@property (strong, nonatomic) NSString *fontWeight;
/// 背景颜色 16位进制
@property (strong, nonatomic) NSString *backgroundColor;
/// 字体颜色 16位进制
@property (strong, nonatomic) NSString *color;
/// 渐变色颜色 16位进制
@property (strong, nonatomic) NSMutableArray<NSString *> *colors;
/// 透明度0-1
@property (assign, nonatomic) CGFloat opacity;

- (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

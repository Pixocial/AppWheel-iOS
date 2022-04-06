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
/// 背景颜色 16位进制
@property (strong, nonatomic) NSString *backgroundColor;
/// 字体颜色 16位进制
@property (strong, nonatomic) NSString *color;
/// 透明度0-1
@property (assign, nonatomic) CGFloat opacity;

- (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

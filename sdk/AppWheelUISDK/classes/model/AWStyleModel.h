//
//  AWStyleModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//  样式：包含颜色、字体等样式属性

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWStyleModel : NSObject

/// 字体大小
@property (weak, nonatomic) NSString *fontSize;
/// 颜色 16位进制
@property (weak, nonatomic) NSString *backgroundColor;
@end

NS_ASSUME_NONNULL_END

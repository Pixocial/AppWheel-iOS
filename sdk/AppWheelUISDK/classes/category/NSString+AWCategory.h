//
//  NSString+AWCategory.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/23.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AWCategory)
/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

/**
 *  @brief 判断当前字符串是否是空字符
 *
 *  @return 是否是空字符
 */
-(BOOL)isEmpty;

/**
 *  @brief 去掉字符串前后的空格
 *
 *  @return 去掉字符串前后的空格后的字符串
 */
- (NSString *)trimmedString;

/**
 *  @brief 去掉字符串中所有的空格
 *
 *  @return 返回 无空格字符串
 */
- (NSString *)removeSpace;
@end

NS_ASSUME_NONNULL_END

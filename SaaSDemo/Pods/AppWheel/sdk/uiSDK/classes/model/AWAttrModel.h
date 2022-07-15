//
//  AWAttrModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///滚轮的滚动方式
typedef NS_ENUM(NSInteger, AWUIScrollType) {
    ///自动滚动（禁止掉手动）
    AWUIScrollTypeAuto = 1,
    ///手动滚动（禁止掉自动）
    AWUIScrollTypeManual = 2,
    ///自动和手动都可以
    AWUIScrollTypeAutoAndManual = 3
};

@interface AWAttrModel : NSObject
/// 图片的地址
@property(nonatomic, strong)NSString *src;
/// 视频的地址
@property(nonatomic, strong)NSString *video;
/// 链接地址
@property(nonatomic, strong)NSString *herf;
/// 滚轮的滚动方式
@property(nonatomic, assign)AWUIScrollType animation;

/**SKU相关***/
/// skuId
@property(nonatomic, strong)NSString *skuId;
/// 是否展示SKU
@property(nonatomic, assign)BOOL available;
/// sku的价格：0.9/week
@property(nonatomic, strong)NSString *comparePrice;


- (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

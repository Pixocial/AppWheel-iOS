//
//  AWAttrModel.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWAttrModel : NSObject
/// 图片的地址
@property(nonatomic, strong)NSString *src;

- (instancetype)initWithDict: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

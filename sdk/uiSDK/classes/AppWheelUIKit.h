//
//  AppWheelUIKit.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AWPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppWheelUIKit : NSObject

+ (void)config;

+ (void)getPagesModelWithPageId:(NSString *)linkUrl
                       complete:(void (^)(BOOL,AWPageModel * _Nullable,NSString * _Nullable))complete;
+ (void)presentSubscribeWithModel:(AWPageModel *)uiModel
               fromViewController:(UIViewController *)vc;

+ (void)setDebug:(BOOL)isDebug;
@end

NS_ASSUME_NONNULL_END

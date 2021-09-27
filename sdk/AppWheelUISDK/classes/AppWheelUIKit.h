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

+ (void)getPagesModelWithComplete:(void (^)(BOOL,
                                            NSArray<AWPageModel *> * _Nullable,
                                            NSError * _Nullable))complete;

+ (void)presentSubscribeWithModel:(AWPageModel *)uiModel
               fromViewController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END

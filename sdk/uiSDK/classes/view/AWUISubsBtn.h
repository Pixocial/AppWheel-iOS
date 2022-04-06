//
//  AWUSubsBtn.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "AWSubscribeBtnModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWUISubsBtn : UIButton

@property(nonatomic, strong)AWSubscribeBtnModel *model;

- (void)setTextColor:(AWStyleModel *)model;

@end

NS_ASSUME_NONNULL_END

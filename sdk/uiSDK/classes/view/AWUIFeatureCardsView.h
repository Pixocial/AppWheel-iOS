//
//  AWUFeatureCardsView.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "AWUIFeatureCellModel.h"
#import "AWBaseComponentModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWUIFeatureCardsView : UIView

- (void)setData:(AWBaseComponentModel *)scrollingModel;

@end

NS_ASSUME_NONNULL_END

//
//  AWUFeatureCardsView.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "AWUIFeatureCellModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface AWUIFeatureCardsView : UIView

@property(strong, nonatomic)NSArray<AWUIFeatureCellModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END

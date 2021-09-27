//
//  AWUFeatureCardsView.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "AWUFeatureModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWUFeatureCardsView : UIView

@property(strong, nonatomic)NSArray<AWUFeatureModel *> *dataArray;

@end

NS_ASSUME_NONNULL_END

//
//  AWUFeatureCardsCell.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/25.
//

#import <UIKit/UIKit.h>
#import "AWUIFeatureCellModel.h"
#import "MPIPlayerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWUIFeatureCardsCell : UICollectionViewCell

@property(strong, nonatomic)AWUIFeatureCellModel *model;

@property(strong, nonatomic)UILabel *label;

@property(strong, nonatomic)MPIPlayerView *playerView;

@end

NS_ASSUME_NONNULL_END

//
//  AWGradientButton.h
//  AWUI
//
//  Created by yikunHuang on 2022/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWGradientButton : UIButton

@property(strong, nonatomic)NSArray *colors;
@property(assign, nonatomic)CGPoint startPoint;
@property(assign, nonatomic)CGPoint endPoint;
@property(strong, nonatomic)NSArray<NSNumber *> * locations;

@end

NS_ASSUME_NONNULL_END

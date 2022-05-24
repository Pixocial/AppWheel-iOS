//
//  AWGradientView.h
//  AWUI
//
//  Created by yikunHuang on 2022/5/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface AWGradientView : UIView

@property(strong, nonatomic)NSArray *colors;
@property(assign, nonatomic)CGPoint startPoint;
@property(assign, nonatomic)CGPoint endPoint;
@property(strong, nonatomic)NSArray<NSNumber *> * locations;

@end

NS_ASSUME_NONNULL_END

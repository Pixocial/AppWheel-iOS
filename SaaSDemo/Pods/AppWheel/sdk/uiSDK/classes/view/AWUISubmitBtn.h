//
//  AWUISubmitBtn.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import "AWGradientButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWUISubmitBtn : AWGradientButton

@property(strong, nonatomic)UILabel *mainTitleLabel;

- (void)setGradientColors:(NSArray *)colors;

@end

NS_ASSUME_NONNULL_END

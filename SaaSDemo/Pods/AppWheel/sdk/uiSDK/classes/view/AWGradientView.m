//
//  AWGradientView.m
//  AWUI
//
//  Created by yikunHuang on 2022/5/12.
//

#import "AWGradientView.h"

@interface AWGradientView()

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation AWGradientView

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}

- (void)config {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    self.gradientLayer = gradientLayer;
    [self.layer addSublayer:gradientLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateColors];
}

- (void)updateColors {
    if (self.colors) {
        self.gradientLayer.frame = self.bounds;
        self.gradientLayer.colors = self.colors;
        self.gradientLayer.locations = self.locations;
        self.gradientLayer.startPoint = self.startPoint;
        self.gradientLayer.endPoint = self.endPoint;
    }
}
@end

//
//  AWUISubmitBtn.m
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/22.
//

#import "AWUISubmitBtn.h"
#import "Masonry.h"
#import "AWRGBUtil.h"

@interface AWUISubmitBtn()

 
@end

@implementation AWUISubmitBtn

- (instancetype)init {
    self = [super init];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        [self makeUI];
    }
    return self;
}


- (void)setGradient {
    self.startPoint = CGPointMake(0.0, 0.5);
    self.endPoint = CGPointMake(1.0, 0.5);
    self.colors = @[(__bridge id)[AWRGBUtil RGB:0x55C2FF].CGColor,
                    (__bridge id)[AWRGBUtil RGB:0x8967FF].CGColor,
                    (__bridge id)[AWRGBUtil RGB:0xF665AB].CGColor];
    self.locations = @[@0, @0.5, @1];
}

///外部设置渐变颜色
- (void)setGradientColors:(NSArray *)colors {
    if (colors && colors.count > 0) {
        self.startPoint = CGPointMake(0.0, 0.5);
        self.endPoint = CGPointMake(1.0, 0.5);
        self.colors = colors;
        if (colors.count == 2) {
            self.locations = @[@0, @1];
        }
        return;
    }
    //设置默认颜色
    [self setGradient];
}


#pragma mark:- UI

- (void)makeUI {
//    self.backgroundColor = [AWRGBUtil RGB:0x8995FF];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]init];
        _mainTitleLabel.textColor = [UIColor whiteColor];
        _mainTitleLabel.font = [UIFont systemFontOfSize:16];
        
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _mainTitleLabel];
    }
    return _mainTitleLabel;
}

@end

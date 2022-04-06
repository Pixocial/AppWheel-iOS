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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



#pragma mark:- UI

- (void)layoutSubviews {
    [super layoutSubviews];
    [self makeUI];
}
- (void)makeUI {
    self.backgroundColor = [AWRGBUtil RGB:0x8995FF];
    
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

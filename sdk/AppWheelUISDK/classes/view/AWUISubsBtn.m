//
//  AWUSubsBtn.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import "AWUISubsBtn.h"
#import "AWRGBUtil.h"
#import "AWUBundleUtil.h"
#import "Masonry.h"

@interface AWUISubsBtn()
/// 左上角的角标
@property(strong, nonatomic)UILabel *leftTopLabel;
/// 右上角的角标
@property(strong, nonatomic)UILabel *rightTopLabel;
/// 选中的框框
@property(strong, nonatomic)UIView *selectedView;
/// 订阅的总价:100/年
@property(strong, nonatomic)UILabel *fullPriceLabel;
/// 订阅的总周期：100/年
@property(strong, nonatomic)UILabel *fullPeriodLabel;
/// 订阅的每天价格:1/日
@property(strong, nonatomic)UILabel *perPriceLabel;
/// 是否布局了的标量，防止多次布局
@property(assign, nonatomic)BOOL isMakeUI;

@end

@implementation AWUISubsBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self makeUI];
    }
    return self;
}


- (void)setSelected:(BOOL)selected {
    [self changeBGState: selected];
}

- (void)changeBGState:(BOOL)isSelected {
    if (isSelected == YES) {
        [self.selectedView setHidden:NO];
        if (self.skuType == AWSKUType_Year) {
            [self.leftTopLabel setHidden:NO];
            [self.rightTopLabel setHidden:NO];
        }
    } else {
        [self.selectedView setHidden:YES];
        [self.leftTopLabel setHidden:YES];
        [self.rightTopLabel setHidden:YES];
    
    }
}

#pragma mark -UI

- (void)setNeedsLayout {
    if ([self getWith] > 0 && self.isMakeUI != YES) {
        [self makeUI];
    }
}

- (void)makeUI {
    self.isMakeUI = YES;
    int selectViewHeight = [self getHeight] - 10;
    
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.width.mas_equalTo(74);
        make.height.mas_equalTo(21);
    }];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self.rightTopLabel);
        make.width.mas_equalTo(52);
        make.height.mas_equalTo(19);
    }];
    //把selectView置于最底层
    [self sendSubviewToBack:self.selectedView];
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(selectViewHeight);
    }];
    
    [self.fullPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(self.selectedView);
    }];
    
    [self.fullPeriodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fullPriceLabel.mas_right);
        make.centerY.mas_equalTo(self.selectedView);
    }];
    
    [self.perPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(self.selectedView);
    }];
    
}
- (CGFloat)getWith {
    return self.frame.size.width;
}

- (CGFloat)getHeight {
    return self.frame.size.height;
}



- (UILabel *)leftTopLabel {
    if (!_leftTopLabel) {
        _leftTopLabel = [[UILabel alloc]init];
        _leftTopLabel.textColor = [AWRGBUtil RGB:0x5CBBFF];
        _leftTopLabel.font = [UIFont systemFontOfSize:10];
        _leftTopLabel.text = @"Trending";
        _leftTopLabel.layer.borderWidth = 1;
        _leftTopLabel.layer.borderColor = [AWRGBUtil RGB:0x5CBBFF].CGColor;
        _leftTopLabel.layer.masksToBounds = YES;
        _leftTopLabel.layer.cornerRadius = 4;
        _leftTopLabel.backgroundColor = [UIColor blackColor];
        _leftTopLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_leftTopLabel];
    }
    return _leftTopLabel;
}

- (UILabel *)rightTopLabel {
    if (!_rightTopLabel) {
        _rightTopLabel = [[UILabel alloc]init];
        _rightTopLabel.textColor = [UIColor whiteColor];
        _rightTopLabel.font = [UIFont systemFontOfSize:12];
        _rightTopLabel.text = @"Save 67%";
        _rightTopLabel.layer.masksToBounds = YES;
        _rightTopLabel.layer.cornerRadius = 4;
        _rightTopLabel.backgroundColor = [AWRGBUtil RGB:0x8995FF];
        _rightTopLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_rightTopLabel];
    }
    return _rightTopLabel;
}

- (UILabel *)fullPriceLabel {
    if (!_fullPriceLabel) {
        _fullPriceLabel = [[UILabel alloc]init];
        _fullPriceLabel.textColor = [AWRGBUtil RGB:0xE6E6F2];
        _fullPriceLabel.font = [UIFont systemFontOfSize:18];
        _fullPriceLabel.text = @"$46.99";
        [self addSubview:_fullPriceLabel];
    }
    return _fullPriceLabel;
}

- (UILabel *)fullPeriodLabel {
    if (!_fullPeriodLabel) {
        _fullPeriodLabel = [[UILabel alloc]init];
        _fullPeriodLabel.textColor = [AWRGBUtil RGB:0xE6E6F2];
        _fullPeriodLabel.font = [UIFont systemFontOfSize:16];
        _fullPeriodLabel.text = @"/ Year";
        [self addSubview:_fullPeriodLabel];
    }
    return _fullPeriodLabel;
}

- (UILabel *)perPriceLabel {
    if (!_perPriceLabel) {
        _perPriceLabel = [[UILabel alloc]init];
        _perPriceLabel.textColor = [AWRGBUtil RGB:0xE6E6F2];
        _perPriceLabel.font = [UIFont systemFontOfSize:14];
        _perPriceLabel.text = @"$0.9/week ";
        [self addSubview:_perPriceLabel];
    }
    return _perPriceLabel;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIView alloc]initWithFrame:CGRectZero];
        _selectedView.layer.borderColor = [AWRGBUtil RGB:0x8995FF].CGColor;
        _selectedView.layer.borderWidth = 1;
        _selectedView.layer.masksToBounds = YES;
        _selectedView.layer.cornerRadius = 8;
        [self addSubview:_selectedView];
    }
    return _selectedView;
}


#pragma mark - 设置数据

//- (void)setModel:(Product *)product {
//    if (product) {
////        self.descriptionLabel.text = product.localizedDescription;
//        self.priceLabel.text = product.localizedPrice;
//        NSString *periodString = [self getPeriodString:product.subscriptionPeriod];
//        self.periodLabel.text = periodString;
//    }
//}
//
//- (NSString *)getPeriodString:(SubscriptionPeriod *)period {
//    NSString *periodString = [NSString stringWithFormat:@"%ld",(long)period.numberOfDiscountUnits];
//    switch (period.unitType) {
//        case SubscriptionUnitTypeDay:
//            periodString = [periodString stringByAppendingString:@"Day"];
//            break;
//
//        case SubscriptionUnitTypeWeek:
//            periodString = [periodString stringByAppendingString:@"Week"];
//            break;
//        case SubscriptionUnitTypeMonth:
//            periodString = [periodString stringByAppendingString:@"Month"];
//            break;
//        case SubscriptionUnitTypeYear:
//            periodString = [periodString stringByAppendingString:@"Year"];
//            break;
//        default:
//            break;
//    }
//    return periodString;
//}

@end

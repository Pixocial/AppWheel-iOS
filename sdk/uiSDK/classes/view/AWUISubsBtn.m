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
#import "AWComponentNames.h"
#import "AWUIDef.h"
#import "AWPaddingLabel.h"
#import "NSString+AWCategory.h"

@interface AWUISubsBtn()
/// 左上角的角标
@property(strong, nonatomic)AWPaddingLabel *leftTopLabel;
/// 右上角的角标
@property(strong, nonatomic)AWPaddingLabel *rightTopLabel;
/// 选中的框框
@property(strong, nonatomic)UIView *selectedView;
/// 订阅的总价:100/年
@property(strong, nonatomic)UILabel *fullPriceLabel;
/// 订阅的总周期：100/年
@property(strong, nonatomic)UILabel *fullPeriodLabel;
/// 订阅的每天价格:1/日
@property(strong, nonatomic)UILabel *perPriceLabel;
@property(strong, nonatomic)UILabel *perPriceLabel2;
/// 是否布局了的标量，防止多次布局
@property(assign, nonatomic)BOOL isMakeUI;

@end

@implementation AWUISubsBtn

- (void)setSelected:(BOOL)selected {
    [self changeBGState: selected];
}

- (void)changeBGState:(BOOL)isSelected {
    if (isSelected == YES) {
        [self.selectedView setHidden:NO];
        
        [self checkRightLabelShow];
        [self checkLeftLabelShow];
        
        self.fullPriceLabel.alpha = 1;
        self.fullPeriodLabel.alpha = 1;
        self.perPriceLabel.alpha = 1;
        self.perPriceLabel.alpha = 1;
        self.perPriceLabel2.alpha = 1;

        self.backgroundColor = [AWRGBUtil RGBHex:@"#1E1E26"];
    } else {
        [self.selectedView setHidden:YES];
        [self.leftTopLabel setHidden:YES];
        [self.rightTopLabel setHidden:YES];
        
        self.fullPriceLabel.alpha = 0.5;
        self.fullPeriodLabel.alpha = 0.5;
        self.perPriceLabel.alpha = 0.5;
        self.perPriceLabel.alpha = 0.5;
        self.perPriceLabel2.alpha = 0.5;
        self.backgroundColor = [AWRGBUtil RGBHex:@"0A0A0D" opacity:0.5];
    
    }
}

- (void)setTextColor:(AWStyleModel *)model {
    if (model && !IS_EMPTY_STRING(model.color)) {
        self.fullPriceLabel.textColor = [AWRGBUtil RGBHex:model.color opacity:model.opacity];
        self.fullPeriodLabel.textColor = [AWRGBUtil RGBHex:model.color opacity:model.opacity];
        self.perPriceLabel.textColor = [AWRGBUtil RGBHex:model.color opacity:model.opacity];
        self.perPriceLabel2.textColor = [AWRGBUtil RGBHex:model.color opacity:model.opacity];
    }
}

- (void)setModel:(AWSubscribeBtnModel *)model {
    _model = model;
    //左上角
    AWBaseComponentModel *leftModel = [AWComponentNames findModelInComponents:model.componentModel.components withName:awPage1skuPopularHint];
    if (leftModel && !IS_EMPTY_STRING(leftModel.text)) {
//        [leftModel setDataToLabel:self.leftTopLabel];
        [leftModel setTextAndTextColor:self.leftTopLabel];
    }
    //右上角
    AWBaseComponentModel *rightModel = [AWComponentNames findModelInComponents:model.componentModel.components withName:awPage1skuDiscountHint];
    if (rightModel && !IS_EMPTY_STRING(rightModel.text)) {
        [rightModel setTextAndTextColor:self.rightTopLabel];
    }
    [self updateMark];
    //总价：¥49.99
    AWBaseComponentModel *price = [AWComponentNames findModelInComponents:model.componentModel.components withName:awPage1skuPrice];
    if (price) {
        [price setTextAndTextColor:self.fullPriceLabel];
        
        //每日价格：0.99/日
        if (price.attr && !IS_EMPTY_STRING(price.attr.comparePrice)) {
            self.perPriceLabel.text = price.attr.comparePrice;
//            NSString *compare = @" ١٢٣د.إ/week";
            [self setTextToPrice:price.attr.comparePrice];
        }
    }
    
    //周期：/年
    AWBaseComponentModel *duration = [AWComponentNames findModelInComponents:model.componentModel.components withName:awPage1skuDuration];
    if (duration) {
        [duration setDataToLabel:self.fullPeriodLabel];
//        [duration setTextColor:self.fullPeriodLabel];
        [self.fullPeriodLabel setText:[NSString stringWithFormat:@" / %@", [self getDuration:self.fullPeriodLabel.text] ]];
    }
}

- (void)setTextToPrice:(NSString *)text {
    //如果包含这种鬼字符，就用两个文本展示
    if ([text containsString:@"د.إ"] || [text containsString:@"ر.س"] || [text containsString:@"ر.ق"]) {
        NSArray * array = [text componentsSeparatedByString:@"/"];
        if (array && array.count >= 2) {
            NSString *duration = array[1];
            NSString *price = array[0];
            price = [NSString stringWithFormat:@"/%@", price];
            self.perPriceLabel.text = price;
            self.perPriceLabel2.text = duration;
            
        }
    } else {
        self.perPriceLabel.text = text;
    }
}

///是否展示右上角
- (void)checkRightLabelShow {
    AWBaseComponentModel *rightModel = [AWComponentNames findModelInComponents:self.model.componentModel.components
                                                                      withName:awPage1skuDiscountHint];
    if (rightModel && !IS_EMPTY_STRING(rightModel.text)) {
        [self.rightTopLabel setHidden:NO];
    } else {
        [self.rightTopLabel setHidden:YES];
    }
}

///是否展示左上角
- (void)checkLeftLabelShow {
    AWBaseComponentModel *leftModel = [AWComponentNames findModelInComponents:self.model.componentModel.components
                                                                     withName:awPage1skuPopularHint];
    if (leftModel && !IS_EMPTY_STRING(leftModel.text)) {
        [self.leftTopLabel setHidden:NO];
    } else {
        [self.leftTopLabel setHidden:YES];
    }
}

- (NSString *)getDuration:(NSString *)price {
    if ([@"P1W" isEqualToString:price]) {
        return @"Week";
    } else if ([@"P4W" isEqualToString:price]) {
        return @"28 Days";
    } else if ([@"P1M" isEqualToString:price]) {
        return @"Month";
    } else if ([@"P2M" isEqualToString:price]) {
        return @"2 Months";
    } else if ([@"P3M" isEqualToString:price]) {
        return @"3 Months";
    } else if ([@"P6M" isEqualToString:price]) {
        return @"6 Months";
    } else if ([@"P12M" isEqualToString:price] || [@"P1Y" isEqualToString:price]) {
        return @"Year";
    } else {
        return @"";
    }
}

/// 刷新一下界面布局：左右上角的角标
- (void)updateMark {
    ///左右角标的最大宽度：屏幕宽度 - 左右边距（16） - 2
    CGFloat markMaxWidth = (ScreenWidth - 34) / 2;
    
    //设置最大宽度为按钮的一半宽度,(+ 12:因为设置文字的paddingLeft、right = 6，所以需要再加12的宽度)
    CGFloat leftWidth = [self.leftTopLabel.text widthWithFont:[UIFont systemFontOfSize:10] constrainedToHeight:22] + 12;
    if (leftWidth > markMaxWidth) {
        leftWidth = markMaxWidth;
    }
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self.rightTopLabel);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(leftWidth);
    }];
    
    //设置最大宽度为按钮的一半宽度
    CGFloat rightWidth = [self.rightTopLabel.text widthWithFont:[UIFont systemFontOfSize:12] constrainedToHeight:22]+ 12;
    if (rightWidth > markMaxWidth) {
        rightWidth = markMaxWidth;
    }
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(rightWidth);
    }];
}


#pragma mark -UI

- (void)setNeedsLayout {
    if ([self getWith] > 0 && self.isMakeUI != YES) {
        [self makeUI];
    }
}

- (void)makeUI {
    self.isMakeUI = YES;
    int selectViewHeight = [self getHeight];
    
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(-8);//往上凸出8个像素
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(22);
    }];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self.rightTopLabel);
        make.height.mas_equalTo(22);
    }];
    //把selectView置于最底层
    [self sendSubviewToBack:self.selectedView];
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
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
    

    [self.perPriceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.centerY.mas_equalTo(self.selectedView);
    }];
    [self.perPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.perPriceLabel2.mas_left);
        make.centerY.mas_equalTo(self.selectedView);
    }];
    
}
- (CGFloat)getWith {
    return self.frame.size.width;
}

- (CGFloat)getHeight {
    return self.frame.size.height;
}



- (AWPaddingLabel *)leftTopLabel {
    if (!_leftTopLabel) {
        _leftTopLabel = [[AWPaddingLabel alloc]init];
        _leftTopLabel.textColor = [AWRGBUtil RGB:0x8995FF];
        _leftTopLabel.font = [UIFont systemFontOfSize:10];
        _leftTopLabel.text = @"Trending";
        _leftTopLabel.layer.borderWidth = 2;
        _leftTopLabel.layer.borderColor = [AWRGBUtil RGB:0x8995FF].CGColor;
        _leftTopLabel.layer.masksToBounds = YES;
        _leftTopLabel.layer.cornerRadius = 4;
        _leftTopLabel.backgroundColor = [UIColor blackColor];
        
        _leftTopLabel.edgeInsets = UIEdgeInsetsMake(3, 6, 3, 6);
        _leftTopLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_leftTopLabel];
    }
    return _leftTopLabel;
}

- (AWPaddingLabel *)rightTopLabel {
    if (!_rightTopLabel) {
        _rightTopLabel = [[AWPaddingLabel alloc]init];
        _rightTopLabel.textColor = [UIColor whiteColor];
        _rightTopLabel.font = [UIFont systemFontOfSize:12];
        _rightTopLabel.text = @"Save 67%";
        _rightTopLabel.layer.masksToBounds = YES;
        _rightTopLabel.layer.cornerRadius = 4;
        _rightTopLabel.backgroundColor = [AWRGBUtil RGB:0x8995FF];
        _rightTopLabel.textAlignment = NSTextAlignmentCenter;
        _rightTopLabel.edgeInsets = UIEdgeInsetsMake(3, 6, 3, 6);
        [self addSubview:_rightTopLabel];
    }
    return _rightTopLabel;
}

- (UILabel *)fullPriceLabel {
    if (!_fullPriceLabel) {
        _fullPriceLabel = [[UILabel alloc]init];
        _fullPriceLabel.textColor = [AWRGBUtil RGB:0xE6E6F2];
        _fullPriceLabel.font = [UIFont boldSystemFontOfSize:18];
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

- (UILabel *)perPriceLabel2 {
    if (!_perPriceLabel2) {
        _perPriceLabel2 = [[UILabel alloc]init];
        _perPriceLabel2.textColor = [AWRGBUtil RGB:0xE6E6F2];
        _perPriceLabel2.font = [UIFont systemFontOfSize:14];
        [self addSubview:_perPriceLabel2];
    }
    return _perPriceLabel2;
}

- (UIView *)selectedView {
    if (!_selectedView) {
        _selectedView = [[UIView alloc]initWithFrame:CGRectZero];
        _selectedView.layer.borderColor = [AWRGBUtil RGB:0x8995FF].CGColor;
        _selectedView.layer.borderWidth = 2;
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

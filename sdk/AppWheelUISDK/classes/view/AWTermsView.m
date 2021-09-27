//
//  AWTermsView.m
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/23.
//  恢复购买、隐私协议的view

#import "AWTermsView.h"
#import "Masonry.h"
#import "NSString+AWCategory.h"

@interface AWTermsView()

/// 恢复购买
@property(strong, nonatomic)UILabel *restoreLabel;
/// 用户协议
@property(strong, nonatomic)UILabel *protocolLabel;
/// 隐私政策
@property(strong, nonatomic)UILabel *privacyLabel;
/// 订阅条款
@property(strong, nonatomic)UILabel *clauseLabel;
/// 中间的“｜”
@property(strong, nonatomic)UILabel *middleLabel;
/// 左边的“｜”
@property(strong, nonatomic)UILabel *leftLabel;
/// right的“｜”
@property(strong, nonatomic)UILabel *rightLabel;

@end

@implementation AWTermsView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self makeUI];
    }
    return self;
}

- (void)layoutSubviews {
    [self makeUI];
}

#pragma mark:- 处理UI
- (void)makeUI {
    
    int protocolWidth = [self getLabelWidth:self.protocolLabel];
    int restoreWidth = [self getLabelWidth:self.restoreLabel];
    int privacyWidth = [self getLabelWidth:self.privacyLabel];
    int clauseWidth = [self getLabelWidth:self.clauseLabel];
    int lineWidth = [self getLabelWidth:self.middleLabel];
    int frameHeight = self.frame.size.height;
    int leftMargin = (self.frame.size.width - (protocolWidth + restoreWidth + privacyWidth + clauseWidth + lineWidth * 3)) * 0.5;
    
    self.restoreLabel.frame = CGRectMake(leftMargin, 0, restoreWidth, frameHeight);
    self.leftLabel.frame = CGRectMake(leftMargin + restoreWidth + 4, 0, lineWidth, frameHeight);
    self.protocolLabel.frame = CGRectMake(leftMargin + restoreWidth + lineWidth + 4*2, 0, protocolWidth, frameHeight);
    self.middleLabel.frame = CGRectMake(leftMargin + restoreWidth + lineWidth +
                                        protocolWidth+ 4*3,
                                        0,
                                        lineWidth,
                                        frameHeight);
    self.privacyLabel.frame = CGRectMake(leftMargin + restoreWidth + lineWidth*2 +
                                        protocolWidth+ 4*4,
                                        0,
                                        privacyWidth,
                                        frameHeight);
    
    self.rightLabel.frame = CGRectMake(leftMargin + restoreWidth + lineWidth*2 +
        protocolWidth+privacyWidth+ 4*5,
        0,
        lineWidth,
        frameHeight);
    self.clauseLabel.frame = CGRectMake(leftMargin + restoreWidth + lineWidth*3 +
        protocolWidth+privacyWidth+ 4*6,
        0,
        clauseWidth,
        frameHeight);
}

- (CGFloat)getLabelWidth: (UILabel *) label{
    return [label.text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToHeight:14].width;
}

- (UILabel *)protocolLabel {
    
    if (!_protocolLabel) {
        _protocolLabel = [self createLabel:@"用户协议"];
    }
    return _protocolLabel;
}

- (UILabel *)clauseLabel {
    
    if (!_clauseLabel) {
        _clauseLabel = [self createLabel:@"订阅条款"];
    }
    return _clauseLabel;
}

- (UILabel *)restoreLabel {
    if (!_restoreLabel) {
        _restoreLabel = [self createLabel:@"恢复购买"];
    }
    return _restoreLabel;
}

- (UILabel *)privacyLabel {
    if (!_privacyLabel) {
        _privacyLabel = [self createLabel:@"隐私协议"];
    }
    return _privacyLabel;
}

- (UILabel *)middleLabel {
    if (!_middleLabel) {
        _middleLabel = [self createLabel:@"|"];
    }
    return _middleLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [self createLabel:@"|"];
    }
    return _rightLabel;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [self createLabel:@"|"];
    }
    return _leftLabel;
}

- (UILabel *)createLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:10];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview: label];
    
    [self bindClickAction:label];
    
    return label;
}

#pragma mark:- 点击事件
/// 给label添加点击事件
- (void)bindClickAction:(UILabel *)label {
    UITapGestureRecognizer *getsture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [label addGestureRecognizer:getsture];
        label.userInteractionEnabled = YES; // 可以理解为设置label可被点击
}

- (void)clickAction:(UITapGestureRecognizer *)recognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(termsView:clickItem:)]) {
        if (self.restoreLabel == (UILabel*)recognizer.view) {
            [self.delegate termsView:self clickItem:AWTermsViewType_Restore];
            return;
        }
        
        if (self.protocolLabel == (UILabel*)recognizer.view) {
            [self.delegate termsView:self clickItem:AWTermsViewType_Protocol];
            return;
        }
    
        if (self.privacyLabel == (UILabel*)recognizer.view) {
            [self.delegate termsView:self clickItem:AWTermsViewType_Privacy];
            return;
        }
    
        if (self.clauseLabel == (UILabel*)recognizer.view) {
            [self.delegate termsView:self clickItem:AWTermsViewType_Clause];
            return;
        }
    }
}

@end

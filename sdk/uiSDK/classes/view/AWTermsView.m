//
//  AWTermsView.m
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/23.
//  恢复购买、隐私协议的view

#import "AWTermsView.h"
#import "Masonry.h"
#import "NSString+AWCategory.h"
#import "AWUIDef.h"

@interface AWTermsView()

/// 订阅条款
//@property(strong, nonatomic)UILabel *clauseLabel;
/// 中间的“｜”
//@property(strong, nonatomic)UILabel *middleLabel;
/// 左边的“｜”
@property(strong, nonatomic)UILabel *leftLabel;
/// right的“｜”
@property(strong, nonatomic)UILabel *rightLabel;

@property(strong, nonatomic)UIView *restoreParent;
@property(strong, nonatomic)UIView *protocolParent;
@property(strong, nonatomic)UIView *privacyParent;
/// 是否布局了的标量，防止多次布局
@property(assign, nonatomic)BOOL isMakeUI;

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

- (void)update {
    [self makeUI];
}

#pragma mark:- 处理UI

- (void)makeUI {
    if (self.isMakeUI == YES) {
        return;
    }
    self.isMakeUI = YES;
    [self addToView];
    CGFloat lineWidth = [self getLabelWidth:self.leftLabel];
    //文字最大宽度为三等分
    CGFloat labelWidth = (ScreenWidth - lineWidth*2 - 2) / 3;
    //最大高度为2行
    UIFont *font = self.restoreLabel.font;
    CGFloat maxHeight = [@"" heightWithFont:font constrainedToWidth:labelWidth] * 2;
    self.maxHeight = maxHeight;
    ///三等分三个父控件
    [self.restoreParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(maxHeight);
    }];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.restoreParent.mas_right);
        make.centerY.mas_equalTo(self);
    }];
    //用户协议
    [self.protocolParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(maxHeight);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.protocolParent.mas_right);
        make.centerY.mas_equalTo(self);
    }];
    //隐私
    [self.privacyParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(maxHeight);
    }];
    
    //三个文本在父控件中居中
    [self.restoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.restoreParent);
        make.left.mas_equalTo(self.restoreParent);
        make.right.mas_equalTo(self.restoreParent);
    }];
    [self.privacyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.privacyParent);
        make.left.mas_equalTo(self.privacyParent);
        make.right.mas_equalTo(self.privacyParent);
    }];
    [self.protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.protocolParent);
        make.left.mas_equalTo(self.protocolParent);
        make.right.mas_equalTo(self.protocolParent);
    }];
}

//- (void)makeUI {
//    int protocolWidth = [self getLabelWidth:self.protocolLabel];
//    int restoreWidth = [self getLabelWidth:self.restoreLabel];
//    int privacyWidth = [self getLabelWidth:self.privacyLabel];
//    //如果有没有设置文字的，就把“|”隐藏掉
//    if (protocolWidth == 0) {
//        self.leftLabel.text = @"";
//    } else {
//        self.leftLabel.text = @"|";
//    }
//
//    if (privacyWidth == 0) {
//        self.rightLabel.text = @"";
//    } else {
//        self.rightLabel.text = @"|";
//    }
//
//    CGFloat lineWidth = [self getLabelWidth:self.leftLabel];
//    CGFloat lineTotalWidth = lineWidth * 2;
//    //限制最宽三等分
//    CGFloat maxWidth = (self.frame.size.width -2 - lineTotalWidth) / 3;
////    if (restoreWidth > maxWidth) {
////        restoreWidth = maxWidth;
////    }
////    if (protocolWidth > maxWidth) {
////        protocolWidth = maxWidth;
////    }
////    if (privacyWidth > maxWidth) {
////        privacyWidth = maxWidth;
////    }
//
//    //限制最大高度两行
//    UIFont *font = self.restoreLabel.font;
//    CGFloat maxHeight = [@"" heightWithFont:font constrainedToWidth:maxWidth] * 2;
//    CGFloat restoreHeight = [self.restoreLabel.text heightWithFont:font constrainedToWidth:maxWidth];
//    CGFloat protocolHeight = [self.protocolLabel.text heightWithFont:font constrainedToWidth:maxWidth];
//    CGFloat privacyHeight = [self.privacyLabel.text heightWithFont:font constrainedToWidth:maxWidth];
//    //有其中一个超过了两行，那么所有的就都是两行的高度
//    if (restoreHeight >= maxHeight || protocolHeight >= maxHeight || privacyHeight >= maxHeight) {
//        restoreHeight = maxHeight;
//        protocolHeight = maxHeight;
//        privacyHeight = maxHeight;
//    }
//    self.maxHeight = restoreHeight;
////    if (protocolHeight > maxHeight) {
////        protocolHeight = maxHeight;
////    }
////    if (privacyHeight > maxHeight) {
////        privacyHeight = maxHeight;
////    }
//
////    int frameHeight = self.frame.size.height;
//
//    int leftMargin = (self.frame.size.width - (maxWidth + maxWidth + maxWidth  + lineWidth * 2)) * 0.5;
//
//    self.restoreLabel.frame = CGRectMake(leftMargin, 0, maxWidth, restoreHeight);
//    self.leftLabel.frame = CGRectMake(leftMargin + maxWidth + 4, 0, lineWidth, restoreHeight);
//    self.protocolLabel.frame = CGRectMake(leftMargin + maxWidth + lineWidth + 4*2, 0, maxWidth, protocolHeight);
//    self.rightLabel.frame = CGRectMake(leftMargin + maxWidth + lineWidth +
//                                       maxWidth+ 4*3,
//                                        0,
//                                        lineWidth,
//                                       restoreHeight);
//    self.privacyLabel.frame = CGRectMake(leftMargin + maxWidth + lineWidth*2 +
//                                         maxWidth+ 4*4,
//                                        0,
//                                         maxWidth,
//                                         privacyHeight);
//
//}

- (void)addToView {
    [self addSubview:self.restoreParent];
    [self addSubview:self.protocolParent];
    [self addSubview:self.privacyParent];
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self.restoreParent addSubview:self.restoreLabel];
    [self.protocolParent addSubview:self.protocolLabel];
    [self.privacyParent addSubview:self.privacyLabel];
}

- (CGFloat)getLabelWidth: (UILabel *) label{
    return [label.text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToHeight:14].width;
}

- (UILabel *)protocolLabel {
    
    if (!_protocolLabel) {
        _protocolLabel = [self createLabel:@""];
    }
    return _protocolLabel;
}

- (UILabel *)restoreLabel {
    if (!_restoreLabel) {
        _restoreLabel = [self createLabel:@""];
    }
    return _restoreLabel;
}

- (UILabel *)privacyLabel {
    if (!_privacyLabel) {
        _privacyLabel = [self createLabel:@""];
    }
    return _privacyLabel;
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

- (UIView *)restoreParent {
    if (!_restoreParent) {
        _restoreParent = [[UIView alloc]init];
    }
    return _restoreParent;
}

- (UIView *)privacyParent {
    if (!_privacyParent) {
        _privacyParent = [[UIView alloc]init];
    }
    return _privacyParent;
}

- (UIView *)protocolParent {
    if (!_protocolParent) {
        _protocolParent = [[UIView alloc]init];
    }
    return _protocolParent;
}

- (UILabel *)createLabel:(NSString *)text {
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:10];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    //省略号结尾
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
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
    
//        if (self.clauseLabel == (UILabel*)recognizer.view) {
//            [self.delegate termsView:self clickItem:AWTermsViewType_Clause];
//            return;
//        }
    }
}

@end

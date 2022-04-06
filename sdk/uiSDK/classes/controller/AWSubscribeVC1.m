//
//  AWSubscribeVC1.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWSubscribeVC1.h"
#import "Masonry.h"
#import "AWRGBUtil.h"
#import "AWUBundleUtil.h"
#import "AWUIFeatureCardsView.h"
#import "AWRGBUtil.h"
#import "AWUISubsBtn.h"
#import "AWUISubmitBtn.h"
#import "AWTermsView.h"
#import "AWUIDef.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import "AWSUbscribeViewModel1.h"
#import "AWBaseComponentModel.h"
#import "AWComponentNames.h"
#import "UIViewController+AWVC.h"
#import "AWWebVC.h"
#import <SDWebImage/SDWebImage.h>
#import "NSArray+AWArray.h"
#import "AWUIError.h"
#import "NSString+AWCategory.h"


NSString *const Failed = @"Failed";
NSString *const Success = @"Success";

@interface AWSubscribeVC1 ()<AWTermsViewDelegate>
/// 关闭按钮和主标题的父控件
@property(nonatomic, strong) UIView *topView;
/// 全局背景
@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIButton *closeBtn;
/// 主标题
@property(nonatomic, strong) UILabel *mainTitleLabel;

/// 副标题
@property(nonatomic, strong) UILabel *titleMessageLabel;
@property(nonatomic, strong) UIView *titleMessageParent;
/// topBanner的背景图
@property(nonatomic, strong) UIImageView *topBannerBgView;
/// 滚轮
@property(nonatomic, strong) AWUIFeatureCardsView *scrollingView;
/// 订阅的按钮的包含器
@property(nonatomic, strong) UIView *subsBtnContainer;
/// 提交按钮
@property(nonatomic, strong) AWUISubmitBtn *submitBtn;
@property(nonatomic, strong) NSMutableArray<NSString *> *submitTextList;
/// 恢复购买
@property(nonatomic, strong) AWTermsView *termsView;

///订阅的product
@property(nonatomic, strong) AWProduct *product;
///viewModel
@property(nonatomic, strong) AWSUbscribeViewModel1 *viewModel;
/// 隐私政策链接
@property(nonatomic, strong) NSString *privacyLink;
/// 协议链接
@property(nonatomic, strong) NSString *protocolLink;

@property(nonatomic, assign) CGFloat screenWidth;

@end

@implementation AWSubscribeVC1

- (void)viewDidLoad {
    [super viewDidLoad];

    [self makeUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setData];
}

#pragma mark:- 解析填充数据
/// 填充UI的数据
- (void)setData {
    if (self.pageModel) {
        //背景
        [self setBg];
//        //标题
        AWBaseComponentModel *mainTitle = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1MainTitle];
        if (mainTitle) {
            [mainTitle setDataToLabel:self.mainTitleLabel];
        }
        //副标题
        [self setSubTitle];
        ///topBanner
        [self setTopBanner];
        /// 滚轮
        [self setScrolling];
        /// 订阅按钮
        [self setSubsBtn];
        ///协议
        [self setTerms];

    }
    
}
/// 设置背景
- (void)setBg {
    if (self.pageModel.style && !IS_EMPTY_STRING(self.pageModel.style.backgroundColor)) {
        if (self.pageModel.attr && !IS_EMPTY_STRING(self.pageModel.attr.src)) {
            //如果两个都配置了，那就展示背景图片
            [self.bgView sd_setImageWithURL:[NSURL URLWithString:self.pageModel.attr.src]];
        } else {
            //如果仅仅配置了背景颜色，那就展示背景颜色
            self.bgView.backgroundColor = [AWRGBUtil RGBHex:self.pageModel.style.backgroundColor];
            self.bgView.image = nil;
        }
    }
    if (!IS_EMPTY_STRING(self.pageModel.attr.src)) {
        [self.bgView sd_setImageWithURL:[NSURL URLWithString:self.pageModel.attr.src]];

    }
}

//设置副标题的数据和高度
- (void)setSubTitle {
    AWBaseComponentModel *subTitle = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TitleMessage];
    if (subTitle) {
        [subTitle setDataToLabel:self.titleMessageLabel];

//        if (!IS_EMPTY_STRING(subTitle.text)) {
//            //默认字体是24
//            UIFont *font = [UIFont systemFontOfSize:24];
//            //如果有配置的话，获取配置的字体大小
//            if (subTitle.style && !IS_EMPTY_STRING(subTitle.style.fontSize)) {
//                int fontSize = [subTitle.style.fontSize extractNumber];
//                font = [UIFont systemFontOfSize:fontSize];
//            }
//
//            CGFloat titleHeight = [subTitle.text heightWithFont:font constrainedToWidth: self.screenWidth];
//            //最大展示三行
//            CGFloat maxHeight = [@"" heightWithFont:font constrainedToWidth: self.screenWidth] * 3;
//            if (titleHeight > maxHeight) {
//                titleHeight = maxHeight;
//            }
//            //不足三行的高度给marginTop
//            CGFloat topMargin = maxHeight - titleHeight;
//            [self.titleMessageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(self.view).offset(16);
//                make.right.mas_equalTo(self.view).offset(-14);
//                make.height.mas_equalTo(titleHeight);
//                make.top.mas_equalTo(self.mainTitleLabel.mas_bottom).offset(self.titleMsgTop + topMargin);
//            }];
//        }
    }
}

///设置topBanner
- (void)setTopBanner {
    AWBaseComponentModel *topBanner = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TopBanner];
    if (topBanner && topBanner.attr && !IS_EMPTY_STRING(topBanner.attr.src)) {
        [self.topBannerBgView sd_setImageWithURL:[NSURL URLWithString:topBanner.attr.src]];
    }
    
}

- (void)setScrolling {
    AWBaseComponentModel *scrolling = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1Scrolling];
    if (scrolling) {
        [self.scrollingView setData:scrolling];
    }
}


- (void)setSubsBtn {
    NSMutableSet *skuSet = [[NSMutableSet alloc]init];
    NSMutableArray *btnModelArray = [[NSMutableArray alloc]init];
    AWBaseComponentModel *subsContainerModel = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1skuOfferings];
    if (subsContainerModel && subsContainerModel.components.count > 0) {
        /// 默认选中的sku的model
        AWSubscribeBtnModel *defaultSelectedModel;
        int topMargin = 0;
        //实际需要展示的按钮的个数
        int availabelBtnCount = 0;
        for (int i = 0; i < subsContainerModel.components.count; i++) {
            AWBaseComponentModel *model = [subsContainerModel.components objectAtIndex:i];
            //判断是否能够展示
            if (model && model.attr && model.attr.available == NO) {
                continue;
            }
            availabelBtnCount = availabelBtnCount + 1;
            AWUISubsBtn *btn = [[AWUISubsBtn alloc] init];
            [btn setTextColor:subsContainerModel.style];
            AWSubscribeBtnModel *btnModel = [[AWSubscribeBtnModel alloc]init];
            btnModel.componentModel = model;
            
            // 添加sku
            if (model.attr && !IS_EMPTY_STRING(model.attr.skuId)) {

                [skuSet addObject:model.attr.skuId];
                btnModel.productId = model.attr.skuId;
            }
                                    
            [btnModelArray addObject:btnModel];
            btn.model = btnModel;
            [btn setSelected:NO];
            //设置默认选中：选中最后一个就对了
            [self subsBtnAction:btn];
            defaultSelectedModel = btnModel;
            
            
            [self addActionToSubsBtn:btn];
            [self.subsBtnContainer addSubview:btn];
            //设置约束
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(self.subsBtnContainer);
                make.top.mas_equalTo(self.subsBtnContainer).offset(topMargin);
                make.height.mas_equalTo(60);
            }];
            topMargin = topMargin + 60;
        }
        /// 重新设置订阅按钮父控件的高度:每个按钮60+8（左右上角突出的像素）
        CGFloat containerHeight = (availabelBtnCount * 60) + 8;
        [self.subsBtnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).offset(16);
            make.right.mas_equalTo(self.view).offset(-16);
            make.height.mas_equalTo(containerHeight);
            make.top.mas_equalTo(self.scrollingView.mas_bottom).offset(16);
        }];
        /// 请求SKU的信息
        if (skuSet.count > 0) {
            [self showLoading];
            __weak __typeof(self) weakSelf = self;
            [self.viewModel querySKUs:skuSet intoModel:btnModelArray withComplete:^(BOOL success) {
                __strong __typeof(weakSelf) strongSelf = weakSelf;
                [strongSelf hideLoading];
                if (success) {
                    if (defaultSelectedModel && defaultSelectedModel.product) {
                        strongSelf.product = defaultSelectedModel.product;
                    }
                } else {
                    [strongSelf showDialogWithTitle:Failed message:AWUIErrorTypeRequestSkuErrorMsg];
                }
            }];
        } else {
            [self showDialogWithTitle:Failed message:AWUIErrorTypeSkuConfigErrorMsg];
        }
    }
}

- (void)setTerms {
    AWBaseComponentModel *restoreModel = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TermsRestore];
    if (restoreModel) {
        [restoreModel setDataToLabel:self.termsView.restoreLabel];
    }
    AWBaseComponentModel *privacyModel = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TermsPrivacy];
    if (privacyModel) {
        [privacyModel setDataToLabel:self.termsView.privacyLabel];
    }
    AWBaseComponentModel *protocolModel = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TermsProtocol];
    if (protocolModel) {
        [protocolModel setDataToLabel:self.termsView.protocolLabel];
    }
    //重新设置一遍样式，为啥上面设置完了要重新设置呢？因为web嫌麻烦在外层添加了样式，神奇脑回路
    AWBaseComponentModel *termsModel = [AWComponentNames findModelInComponents:self.pageModel.components withName:awPage1TermsColumn];
    if (termsModel) {
        [termsModel setDataToLabel:self.termsView.restoreLabel];
        [termsModel setDataToLabel:self.termsView.privacyLabel];
        [termsModel setDataToLabel:self.termsView.protocolLabel];
    }
    
    //隐私政策链接
    if (privacyModel && privacyModel.attr && !IS_EMPTY_STRING(privacyModel.attr.herf)) {
        self.privacyLink = privacyModel.attr.herf;
    }
    //用户协议链接
    if (protocolModel && protocolModel.attr && !IS_EMPTY_STRING(protocolModel.attr.herf)) {
        self.protocolLink = protocolModel.attr.herf;
    }
    [self.termsView update];
    
    CGFloat bottomMargin = IS_IPHONE_X_SERIES ? -34 - 7 : -7;
    [self.termsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.termsView.maxHeight);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(bottomMargin);
    }];
}

- (AWSUbscribeViewModel1 *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AWSUbscribeViewModel1 alloc]init];
    }
    return _viewModel;
}

#pragma mark: UI相关

- (void)makeUI {
    [self addToParent];
    
    CGFloat navibarHeight =  getNavibarHeight();
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.view);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(navibarHeight);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self.topView);
        make.left.mas_equalTo(self.topView).offset(16);
    }];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.topView);
        make.width.mas_equalTo(self.topView);
        make.height.mas_equalTo(self.topView);
    }];
    ///副标题的高度：全面屏=screenWidth/3*2,向下对齐；
    /// 非全面屏=scerrnWidth/2
    CGFloat subTitleHeight = ScreenWidth / 2 - navibarHeight - 44;
    if (IS_IPHONE_X_SERIES) {
        subTitleHeight =  ScreenWidth / 3 * 2 - navibarHeight - 44;
    }
    //副标题
    [self.titleMessageParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-14);
        make.height.mas_equalTo(subTitleHeight);
        make.top.mas_equalTo(self.mainTitleLabel.mas_bottom);
    }];
    [self.titleMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleMessageParent);
        make.right.mas_equalTo(self.titleMessageParent);
//        make.height.mas_equalTo(subTitleHeight);
        make.bottom.mas_equalTo(self.titleMessageParent.mas_bottom);
    }];
    
    /// topBanner
    //宽高比：3:2
    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat topBannerHeight = self.screenWidth * 2 / 3;
    [self.topBannerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(topBannerHeight);
    }];
    
    [self.scrollingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.width.mas_equalTo(self.view);
        make.height.mas_equalTo(160);
        make.top.mas_equalTo(self.titleMessageLabel.mas_bottom).offset(16);
    }];
    
    [self.subsBtnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(188);
        make.top.mas_equalTo(self.scrollingView.mas_bottom).offset(16);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(52);
        make.top.mas_equalTo(self.subsBtnContainer.mas_bottom).offset(16);
    }];
    CGFloat bottomMargin = IS_IPHONE_X_SERIES ? -34 - 7 : -7;
    [self.termsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
//        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(bottomMargin);
    }];
}

///控制一下视图的层级
- (void)addToParent {
    [self.view addSubview:[self bgView]];
    [self.view addSubview:[self topBannerBgView]];
    [self.view addSubview:[self topView]];
    [self.topView addSubview:[self closeBtn]];
    [self.topView addSubview:[self mainTitleLabel]];
    [self.view addSubview:[self titleMessageParent]];
    [self.titleMessageParent addSubview:[self titleMessageLabel]];
    [self.view addSubview:[self scrollingView]];
    [self.view addSubview:[self subsBtnContainer]];
    [self.view addSubview:[self submitBtn]];
    [self.view addSubview:[self termsView]];
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_closeBtn setImage:[UIImage imageNamed: [AWUBundleUtil getResourcePath: @"/ic_all_wrong.png"]] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

///关闭按钮和主标题的父控件
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
//        _bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[AWUBundleUtil getResourcePath:@"/vip_img_landing_background.png"]]];
    }
    return _bgView;
}

- (UIImageView *)topBannerBgView {
    if (!_topBannerBgView) {
        _topBannerBgView = [[UIImageView alloc]init];
        _topBannerBgView.contentMode = UIViewContentModeScaleAspectFill;
        _topBannerBgView.clipsToBounds = YES;
    }
    return _topBannerBgView;
}


- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _mainTitleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
        _mainTitleLabel.textColor = [UIColor whiteColor];
        //省略号结尾
        _mainTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mainTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _mainTitleLabel;
}


- (UILabel *)titleMessageLabel {
    if (!_titleMessageLabel) {
        _titleMessageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleMessageLabel.font = [UIFont systemFontOfSize:24];
        _titleMessageLabel.textColor = [UIColor whiteColor];
        _titleMessageLabel.numberOfLines = 3;
        _titleMessageLabel.textAlignment = NSTextAlignmentNatural;
        //省略号结尾
        _titleMessageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleMessageLabel;
}

- (UIView *)titleMessageParent {
    if (!_titleMessageParent) {
        _titleMessageParent = [[UILabel alloc]initWithFrame:CGRectZero];
    }
    return _titleMessageParent;
}

- (AWUIFeatureCardsView *)scrollingView {
    if (!_scrollingView) {
        _scrollingView = [[AWUIFeatureCardsView alloc]initWithFrame:CGRectZero];
    }
    return _scrollingView;
}

- (UIView *)subsBtnContainer {
    if (!_subsBtnContainer) {
        _subsBtnContainer = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _subsBtnContainer;
}

- (AWUISubmitBtn *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[AWUISubmitBtn alloc]initWithFrame:CGRectZero];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 28;
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (AWTermsView *)termsView {
    if (!_termsView) {
        _termsView = [[AWTermsView alloc]init];
        _termsView.delegate = self;
    }
    return _termsView;
}

#pragma mark:- action
- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addActionToSubsBtn: (AWUISubsBtn *)btn {
    [btn addTarget:self action:@selector(subsBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}
/// 点击订阅按钮
- (void)subsBtnAction: (AWUISubsBtn *)sender {
    for (AWUISubsBtn *btn in self.subsBtnContainer.subviews) {
        [btn setSelected: NO];
    }
    [sender setSelected: YES];
    self.product = sender.model.product;
    //设置提交按钮的文案
    AWBaseComponentModel *model = sender.model.componentModel;
    if (model) {
        AWBaseComponentModel *actionModel = [AWComponentNames findModelInComponents:model.components
                                                                           withName:awPage1ActionButton];
        [actionModel setDataToLabel:self.submitBtn.mainTitleLabel];
    }
}
/// 点击提交按钮
- (void)submitAction {
    if (self.product) {
        [self showLoading];
        __weak __typeof(self) weakSelf = self;
        [self.viewModel purchaseWithProduct:self.product withCompletion:^(BOOL success, AWError * _Nonnull error) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideLoading];
            if (success) {
                [strongSelf closeAction];
                return;
            }
            if (error.errorCode == AWErrorTypePaymentCancelled) {
                return;
            }
            [strongSelf showDialogWithTitle:Failed message:[NSString stringWithFormat:@"Error code: %ld, msg:%@",(long)error.errorCode, error.errorMessage]];
        }];
    }
    
}

#pragma mark:-  termsViewDelegate

- (void)termsView:(AWTermsView *)termsView clickItem:(AWTermsViewType)type {
    if (type == AWTermsViewType_Restore) {
        [self showLoading];
        __weak __typeof(self) weakSelf = self;
        [self.viewModel restoreWithCompletion:^(BOOL isInSubscriptionPeriod, NSArray * _Nonnull validSubscriptions, NSArray * _Nonnull restoredPurchasedItems, AWError * _Nonnull restoredSubscriptionResult) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf hideLoading];
            if (isInSubscriptionPeriod) {
                [strongSelf closeAction];
            } else {
                [self showDialogWithTitle:Failed message:@"restore fail"];
            }
        }];
        return;
    }
    if (type == AWTermsViewType_Privacy) {
        if (self.privacyLink) {
            AWWebVC *vc = [[AWWebVC alloc]init];
            vc.modalPresentationStyle = 0;
            vc.url = self.privacyLink;
            [self presentViewController:vc animated:YES completion:nil];
        }
        return;
    }
    
    if (type == AWTermsViewType_Protocol) {
        if (self.protocolLink) {
            AWWebVC *vc = [[AWWebVC alloc]init];
            vc.modalPresentationStyle = 0;
            vc.url = self.protocolLink;
            [self presentViewController:vc animated:YES completion:nil];
        }
        return;
    }
    
    
}

@end

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
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "AWSUbscribeViewModel1.h"
#import "AWBaseComponentModel.h"
#import "AWComponentNames.h"

@interface AWSubscribeVC1 ()<AWTermsViewDelegate>


@property(nonatomic, strong) UIButton *closeBtn;
/// 主标题
@property(nonatomic, strong) UILabel *mainTitleLabel;

/// 副标题
@property(nonatomic, strong) UILabel *titleMessageLabel;
/// 滚轮
@property(nonatomic, strong) AWUIFeatureCardsView *scrollingView;
/// 订阅的按钮的包含器
@property(nonatomic, strong) UIView *subsBtnContainer;
/// 提交按钮
@property(nonatomic, strong) AWUISubmitBtn *submitBtn;
/// 恢复购买
@property(nonatomic, strong) AWTermsView *termsView;

///订阅的product
@property(nonatomic, strong) Product *product;
///viewModel
@property(nonatomic, strong) AWSUbscribeViewModel1 *viewModel;


@end

@implementation AWSubscribeVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    [self makeUI];
    [self setData];
}

#pragma mark:- 解析填充数据
/// 填充UI的数据
- (void)setData {
    if (self.pageModel) {
//        //标题
        AWBaseComponentModel *mainTitle = [self.viewModel findModelInComponents:self.pageModel.components withName:awPage1MainTitle];
        if (mainTitle) {
            [mainTitle setDataToLabel:self.mainTitleLabel];
        }
        //副标题
        AWBaseComponentModel *subTitle = [self.viewModel findModelInComponents:self.pageModel.components withName:awPage1TitleMessage];
        if (subTitle) {
            [subTitle setDataToLabel:self.titleMessageLabel];
        }
        /// 滚轮
        [self setScrolling];
        /// 订阅按钮
        [self setSubsBtn];
        

    }
    
}

- (void)setScrolling {
    NSMutableArray *scrollingArray = [[NSMutableArray alloc]init];
    AWBaseComponentModel *scrolling = [self.viewModel findModelInComponents:self.pageModel.components withName:awPage1Scrolling];
    for (AWBaseComponentModel *itemModel in scrolling.components) {
        AWUIFeatureCellModel *model = [[AWUIFeatureCellModel alloc]init];
        if (itemModel.attr && itemModel.attr.src) {
            model.featureImgUrl = itemModel.attr.src;
        }
        model.featureName = itemModel.text;
        [scrollingArray addObject:model];
    }
    if (scrollingArray.count > 0) {
        self.scrollingView.dataArray = scrollingArray;
    }
}


- (void)setSubsBtn {
    AWBaseComponentModel *subsContainerModel = [self.viewModel findModelInComponents:self.pageModel.components withName:awPage1skuOfferings];
    if (subsContainerModel && subsContainerModel.components.count > 0) {
        int topMargin = 0;
        for (AWBaseComponentModel *model in subsContainerModel.components) {
            AWUISubsBtn *btn = [[AWUISubsBtn alloc] init];
            [btn setSelected:NO];
            if ([model.name isEqualToString:awPage1skuOfferingsTypeYear]) {
                btn.skuType = AWSKUType_Year;
                [btn setSelected:YES];
            } else if([model.name isEqualToString:awPage1skuOfferingsTypeWeekly]) {
                btn.skuType = AWSKUType_Week;
            } else if([model.name isEqualToString:awPage1skuOfferingsTypeMonth]) {
                btn.skuType = AWSKUType_Month;
            } else {
                btn.skuType = AWSKUType_Day;
            }
            
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
    }
}

- (AWSUbscribeViewModel1 *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AWSUbscribeViewModel1 alloc]init];
    }
    return _viewModel;
}

#pragma mark: UI相关

- (void)makeUI {
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[AWUBundleUtil getResourcePath:@"/vip_img_landing_background.png"]]];
    [self.view addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(self.view);
    }];
    
    int closeBtnTop = IS_IPHONE_X_SERIES ? 52 : 34;
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.top.mas_equalTo(self.view).offset(closeBtnTop);
        make.left.mas_equalTo(self.view).offset(16);
    }];
    
    [self.mainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.closeBtn);
    }];
    
    int titleMsgTop = IS_IPHONE_X_SERIES ? 77 : 0;
    [self.titleMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-14);
        make.height.mas_equalTo(87);
        make.top.mas_equalTo(self.mainTitleLabel.mas_bottom).offset(titleMsgTop);
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
        make.top.mas_equalTo(self.scrollingView.mas_bottom).offset(5);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(16);
        make.right.mas_equalTo(self.view).offset(-16);
        make.height.mas_equalTo(52);
        make.top.mas_equalTo(self.subsBtnContainer.mas_bottom).offset(20);
    }];
    
    [self.termsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-41);
    }];
    
    
    
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_closeBtn setImage:[UIImage imageNamed: [AWUBundleUtil getResourcePath: @"/ic_all_wrong.png"]] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeBtn];
    }
    return _closeBtn;
}


- (UILabel *)mainTitleLabel {
    if (!_mainTitleLabel) {
        _mainTitleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _mainTitleLabel.font = [UIFont systemFontOfSize:16];
        _mainTitleLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:_mainTitleLabel];
    }
    return _mainTitleLabel;
}


- (UILabel *)titleMessageLabel {
    if (!_titleMessageLabel) {
        _titleMessageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleMessageLabel.font = [UIFont systemFontOfSize:24];
        _titleMessageLabel.textColor = [UIColor whiteColor];
        _titleMessageLabel.numberOfLines = 0;
        _titleMessageLabel.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:_titleMessageLabel];
    }
    return _titleMessageLabel;
}

- (AWUIFeatureCardsView *)scrollingView {
    if (!_scrollingView) {
        _scrollingView = [[AWUIFeatureCardsView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_scrollingView];
    }
    return _scrollingView;
}

- (UIView *)subsBtnContainer {
    if (!_subsBtnContainer) {
        _subsBtnContainer = [[UIView alloc]initWithFrame:CGRectZero];
        [self.view addSubview:_subsBtnContainer];
    }
    return _subsBtnContainer;
}

- (AWUISubmitBtn *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[AWUISubmitBtn alloc]initWithFrame:CGRectZero];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 30;
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (AWTermsView *)termsView {
    if (!_termsView) {
        _termsView = [[AWTermsView alloc]init];
        _termsView.delegate = self;
        [self.view addSubview:_termsView];
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

- (void)subsBtnAction: (AWUISubsBtn *)sender {
    for (AWUISubsBtn *btn in self.subsBtnContainer.subviews) {
        [btn setSelected: NO];
    }
    [sender setSelected: YES];
    self.product = sender.model.product;
}

- (void)submitAction {
    if (self.product) {
        [self.viewModel purchaseWithProduct:self.product withCompletion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
        }];
    }
    
}

#pragma mark:-  termsViewDelegate

- (void)termsView:(AWTermsView *)termsView clickItem:(AWTermsViewType)type {
    if (type == AWTermsViewType_Restore) {
        [self.viewModel restoreWithCompletion:^(BOOL isInSubscriptionPeriod, NSArray * _Nonnull validSubscriptions, NSArray * _Nonnull restoredPurchasedItems, InAppPurchaseError * _Nonnull restoredSubscriptionResult) {
            NSLog(@"");
        }];
        return;
    }
}

@end

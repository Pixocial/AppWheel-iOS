//
//  AWSubscribeCV1.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWSubscribeCV1.h"
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

@interface AWSubscribeCV1 ()<AWTermsViewDelegate>


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

@implementation AWSubscribeCV1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self makeUI];
    [self setData];
}

#pragma mark:- 解析填充数据
/// 填充UI的数据
- (void)setData {
    
//    for (AWBaseComponetModel *componentModel in self.model.components) {
//        if (componentModel.type == componentTitle) {
//            [self setTitleData:componentModel];
//        }
//    }
    ///测试数据
    
    self.mainTitleLabel.text = @"VCUS Pro";
    self.titleMessageLabel.text = @"Развивайте свой бизнес естественным образом,используя VCUS Pro";
    
    AWUIFeatureCellModel *model = [[AWUIFeatureCellModel alloc]init];
    model.featureImgUrl = @"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c";
    model.featureName = @"妆容滤镜";
    
    AWUIFeatureCellModel *model2 = [[AWUIFeatureCellModel alloc]init];
    model2.featureImgUrl = @"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c";
    model2.featureName = @"妆容滤镜2";
    
    AWUIFeatureCellModel *model3 = [[AWUIFeatureCellModel alloc]init];
    model3.featureImgUrl = @"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c";
    model3.featureName = @"妆容滤镜3";
    NSArray *scrollingArray = [[NSArray alloc]initWithObjects:model,model2,model3, nil];
    self.scrollingView.dataArray = scrollingArray;
    self.titleMessageLabel.backgroundColor = [UIColor blackColor];
    [self setSubsBtn];
    
}

- (void)setSubsBtn {
    AWUISubsBtn *btn = [[AWUISubsBtn alloc] init];
    btn.skuType = AWSKUType_Week;
    [self addActionToSubsBtn:btn];
    [self.subsBtnContainer addSubview:btn];
    [btn setSelected:NO];
    
    AWUISubsBtn *btn2 = [[AWUISubsBtn alloc] init];
    btn2.skuType = AWSKUType_Month;
    [self addActionToSubsBtn:btn2];
    [self.subsBtnContainer addSubview:btn2];
    [btn2 setSelected:NO];
    
    AWUISubsBtn *btn3 = [[AWUISubsBtn alloc] init];
    btn3.skuType = AWSKUType_Year;
    [self addActionToSubsBtn:btn3];
    [btn3 setSelected:YES];
    [self.subsBtnContainer addSubview:btn3];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.subsBtnContainer);
        make.height.mas_equalTo(60);
    }];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(btn);
        make.top.mas_equalTo(btn.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(btn2);
        make.top.mas_equalTo(btn2.mas_bottom);
        make.height.mas_equalTo(60);
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[AWUBundleUtil getResourcePath:@"/vip_img_landing_background.jpg"]]]];
    
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.top.mas_equalTo(self.view).offset(34);
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

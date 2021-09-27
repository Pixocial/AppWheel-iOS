//
//  AWTermsView.h
//  subscribeUI
//
//  Created by yikunHuang on 2021/9/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWTermsViewType) {
    AWTermsViewType_Restore = 0,///恢复购买
    AWTermsViewType_Protocol = 1,/// 用户协议
    AWTermsViewType_Privacy = 2,/// 隐私政策
    AWTermsViewType_Clause = 3,/// 订阅条款
};

@class AWTermsView;
@protocol AWTermsViewDelegate <NSObject>

@required
- (void)termsView: (AWTermsView *)termsView
        clickItem: (AWTermsViewType)type;

@end

@interface AWTermsView : UIView

@property(weak, nonatomic)id<AWTermsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

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

//最大高度
@property(assign, nonatomic)CGFloat maxHeight;
/// 恢复购买
@property(strong, nonatomic)UILabel *restoreLabel;
/// 用户协议
@property(strong, nonatomic)UILabel *protocolLabel;
/// 隐私政策
@property(strong, nonatomic)UILabel *privacyLabel;

@property(weak, nonatomic)id<AWTermsViewDelegate> delegate;

- (void)update;

//- (void)setTextToRestore:(NSString *)restore
//              toProtocol:(NSString *)protocol
//               toPrivacy:(NSString *)privacy;

@end

NS_ASSUME_NONNULL_END

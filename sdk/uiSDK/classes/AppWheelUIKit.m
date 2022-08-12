//
//  AppWheelUIKit.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AppWheelUIKit.h"
#import "AWSubscribeVC1.h"
#import "AWPagesRequestManger.h"
#import "AWUIHttpManager.h"


@implementation AppWheelUIKit

+ (void)config {
    
}

+ (void)getPagesModelWithPageLink:(NSString *)linkUrl complete:(void (^)(BOOL, AWPageModel * _Nullable, NSString * _Nullable))complete {
    
    [[[AWPagesRequestManger alloc]init] getPagesModelWithPageId:linkUrl complete:complete];
}

+ (void)presentSubscribeWithModel:(AWPageModel *)uiModel fromViewController:(UIViewController *)vc {
    if (uiModel == nil || vc == nil) {
        return;
    }
    UIViewController *templateVC;
    if (uiModel.template == TEMPLATE_1) {
        AWSubscribeVC1 *vc = [[AWSubscribeVC1 alloc] init];
        vc.pageModel = uiModel;
        templateVC = vc;
    }
    if (!templateVC) {
        return;
    }
    
    templateVC.modalPresentationStyle = 0;
    [vc presentViewController:templateVC animated:YES completion:nil];
}

///设置是否是测试环境
+ (void)setDebug:(BOOL)isDebug {
    [[AWUIHttpManager sharedInstance]setDebug:isDebug];
}
@end

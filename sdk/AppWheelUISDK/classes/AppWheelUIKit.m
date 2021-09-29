//
//  AppWheelUIKit.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AppWheelUIKit.h"
#import "AWSubscribeVC1.h"
#import "AWPagesRequestManger.h"


@implementation AppWheelUIKit

+ (void)getPagesModelWithComplete:(void (^)(BOOL,
                                            NSArray<AWPageModel *> * _Nullable,
                                            NSError * _Nullable))complete {
    [[[AWPagesRequestManger alloc]init] getPagesModelWithComplete:complete];
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
@end

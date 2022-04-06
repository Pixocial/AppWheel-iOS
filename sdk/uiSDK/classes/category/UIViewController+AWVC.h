//
//  UIViewController+AWVC.h
//
//  Created by Yk Huang on 2021/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AWVC)

- (void)showLoading;
- (void)hideLoading;

- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg;
@end

NS_ASSUME_NONNULL_END

//
//  UIViewController+AWVC.m
//
//  Created by Yk Huang on 2021/2/4.
//

#import "UIViewController+AWVC.h"
#import <objc/runtime.h>


@interface UIViewController (Private)

@property (strong, nonatomic) UIActivityIndicatorView *awLoadingView;

@end
@implementation UIViewController (Private)

@dynamic awLoadingView;

- (void)setAwLoadingView:(UIWindow *)loadingView {
    objc_setAssociatedObject(self, @selector(awLoadingView),loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)awLoadingView {
    return objc_getAssociatedObject(self, @selector(awLoadingView));
}



@end

@implementation UIViewController (AWVC)

#pragma mark:- loading
- (void)showAWLoading {
    if (!self.awLoadingView) {
        self.awLoadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:self.awLoadingView];
        self.awLoadingView.center = self.view.center;
        self.awLoadingView.backgroundColor = UIColor.blackColor;
        self.view.userInteractionEnabled = NO;
    }
    [self.awLoadingView startAnimating];
}
- (void)hideAWLoading {
    if (self.awLoadingView && self.awLoadingView.isAnimating) {
        [self.awLoadingView stopAnimating];
    }
    self.view.userInteractionEnabled = YES;
}

#pragma mark:- alert
- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end

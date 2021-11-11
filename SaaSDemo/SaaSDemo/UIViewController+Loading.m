//
//  UIViewController+Loading.m
//  PurchaseSDKDemo
//
//  Created by Yk Huang on 2021/2/4.
//

#import "UIViewController+Loading.h"
#import <objc/runtime.h>


@interface UIViewController (Private)

@property (strong, nonatomic) UIActivityIndicatorView *loadingView;

@end
@implementation UIViewController (Private)

@dynamic loadingView;

- (void)setLoadingView:(UIWindow *)loadingView {
    objc_setAssociatedObject(self, @selector(loadingView),loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)loadingView {
    return objc_getAssociatedObject(self, @selector(loadingView));
}



@end

@implementation UIViewController (Loading)

- (void)showLoading {
    if (!self.loadingView) {
        self.loadingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:self.loadingView];
        self.loadingView.center = self.view.center;
        self.loadingView.backgroundColor = UIColor.blackColor;
        self.view.userInteractionEnabled = NO;
    }
    [self.loadingView startAnimating];
}
- (void)hideLoading {
    if (self.loadingView && self.loadingView.isAnimating) {
        [self.loadingView stopAnimating];
    }
    self.view.userInteractionEnabled = YES;
}

@end

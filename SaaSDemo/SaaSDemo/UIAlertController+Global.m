//
//  UIAlertController+Global.m
//  AirBrush
//
//  Created by simon on 2018/8/20.
//  Copyright © 2018年 Meitu. All rights reserved.
//

#import "UIAlertController+Global.h"
#import <objc/runtime.h>

@interface UIAlertController (Private)

@property (strong,nonatomic) UIWindow *alertWindow;

@end

@implementation UIAlertController (Private)

@dynamic alertWindow;

- (void)setAlertWindow:(UIWindow *)alertWindow {
    objc_setAssociatedObject(self, @selector(alertWindow),alertWindow, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIWindow *)alertWindow {
    return objc_getAssociatedObject(self, @selector(alertWindow));
}

@end

@implementation UIAlertController (Window)

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.alertWindow.hidden = YES;
    self.alertWindow = nil;
}



- (void)show:(UIViewController *)controller {
    [controller presentViewController:self animated:YES completion:nil];
}
//- (void)show {
//    [self show:YES];
//}
//- (void)show:(BOOL)animated {
//    self.alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.alertWindow.rootViewController = [[UIViewController alloc] init];
//    self.alertWindow.windowLevel = UIWindowLevelAlert + 1;
//    [self.alertWindow makeKeyAndVisible];
//    [self.alertWindow.rootViewController presentViewController:self animated:animated completion:nil];
//}



+ (void)showAlertWithTitle:(NSString*)title message:(NSString*)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alert show:self];
    });
    
}

@end

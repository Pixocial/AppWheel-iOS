//
//  UIAlertController+Global.h
//  AirBrush
//
//  Created by simon on 2018/8/20.
//  Copyright © 2018年 Meitu. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIAlertController(Window)

- (void)show:(UIViewController *)controller;

+ (void)showAlertWithTitle:(NSString*)title message:(NSString*)message;

@end

//
//  ProductHistoryViewController.m
//  InAppPurchaseKit_Example
//
//  Created by Ellise on 2021/6/17.
//  Copyright © 2021 Pizhen Huang. All rights reserved.
//

#import "ProductHistoryViewController.h"
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "UIAlertController+Global.h"

@interface ProductHistoryViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ProductHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)checkHistory:(id)sender {
    [InAppPurchaseKit checkProductPurchaseHistoryStatus:self.textField.text completion:^(ProductFreeTrialStatus productFreeTrialStatus, ProductPaidStatus productPaidStatus) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString * trialStatus = productFreeTrialStatus == ProductFreeTrialStatusNone ? @"Never Free Trial" : @"Has Free Trial";
            NSString * paidStatus = productPaidStatus == ProductPaidStatusNone ? @"Never Paid" : @"Has Paid";
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"History" message:[NSString stringWithFormat:@"Free Trial Status: %@ \n Paid Status: %@", trialStatus, paidStatus] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            
           [alert show:self];
        });
    }];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

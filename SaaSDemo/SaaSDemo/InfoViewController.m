//
//  InfoViewController.m
//  InAppPurchaseKit_Example
//
//  Created by Ellise on 2020/6/3.
//  Copyright © 2020 Pizhen Huang. All rights reserved.
//

#import "InfoViewController.h"
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "UIAlertController+Global.h"

@interface InfoViewController ()<InAppPurchaseObserver>

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [InAppPurchaseKit addInAppPurchaseObserver:self];
    
    [self setLabelText];
}

- (void)setLabelText {
    NSString * infoStr = @"Latest subscription info: \n\n";
    LatestSubscriptionInfo * info = [InAppPurchaseKit getLatestSubscriptionInfo];
    if (info) {
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Product id: %@\n\n", info.productIdentifier]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Is trial period: %@\n\n", info.isTrialPeriod ? @"Yes" : @"No"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Is intro period: %@\n\n", info.isInIntroPeriod ? @"Yes" : @"No"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Promotional id: %@\n\n", info.promotionalIdentifier ? info.promotionalIdentifier : @"nil"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Original transaction id: %@\n\n", info.originalTransactionId ? info.originalTransactionId : @"nil"]];
    }else {
        infoStr = [infoStr stringByAppendingString:@"nil \n\n"];
    }
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Subscription unlocked: %@\n\n", [InAppPurchaseKit isSubscriptionUnlockedUser] ? @"Yes" : @"No"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"User in grace period: %@\n\n", [InAppPurchaseKit userInGracePeriod] ? @"Yes" : @"No"]];
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss.S"];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Original transaction date: %@\n\n", [InAppPurchaseKit originalTransactionDate] ? [dateFormat stringFromDate:[InAppPurchaseKit originalTransactionDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Subscription expired date: %@\n\n", [InAppPurchaseKit currentSubscriptionExpiredDate] ? [dateFormat stringFromDate:[InAppPurchaseKit currentSubscriptionExpiredDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Grace period expired date: %@\n\n", [InAppPurchaseKit currentGracePeriodExpiredDate] ? [dateFormat stringFromDate:[InAppPurchaseKit currentGracePeriodExpiredDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:@"Purchased Items:\n\n"];
    
    for (NSString * product in [InAppPurchaseKit purchasedItems]) {
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"%@ \n", product]];
    }
    
    self.label.text = infoStr;
}

- (void)dealloc {
    [InAppPurchaseKit removeInAppPurchaseObserver:self];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)iapUnlockedItemsUpdated:(nonnull NSArray<PurchasedProduct *> *)purchasedProducts {
    NSString * str = @"";
    
    for (PurchasedProduct * product in purchasedProducts) {
        NSString * productId = product.productIdentifier;
        str = [str stringByAppendingString:productId];
        str = [str stringByAppendingString:@"\n"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Item Unlocked" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert2 addAction:action2];
        
        [alert2 show:self];
    });
}

- (void)subscriptionStateUpdated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setLabelText];
        
        UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Subscription update" message:@"Check in Latest Subscription Info VC" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert2 addAction:action2];
        
        [alert2 show:self];
    });
}

@end

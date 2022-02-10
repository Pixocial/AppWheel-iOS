//
//  InfoViewController.m
//  InAppPurchaseKit_Example
//
//  Created by Ellise on 2020/6/3.
//  Copyright © 2020 Pizhen Huang. All rights reserved.
//

#import "InfoViewController.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import "UIAlertController+Global.h"

@interface InfoViewController ()<AWPurchaseObserver>

@property (weak, nonatomic) IBOutlet UITextView *labelt;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AWPurchaseKit addPurchaseObserver:self];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self setLabelText];
}

- (void)setLabelText {
    AWPurchaseInfo *purchaseInfo = [AWPurchaseKit getPurchaseInfo];

    NSString * infoStr = @"Latest subscription info: \n\n";
    LatestSubscriptionInfo * info = [purchaseInfo getLatestSubscriptionInfo];
    if (info) {
        info.offerCodeRefName;
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Product id: %@\n\n", info.productIdentifier]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Is trial period: %@\n\n", info.isTrialPeriod ? @"Yes" : @"No"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Is intro period: %@\n\n", info.isInIntroPeriod ? @"Yes" : @"No"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Promotional id: %@\n\n", info.promotionalIdentifier ? info.promotionalIdentifier : @"nil"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Original transaction id: %@\n\n", info.originalTransactionId ? info.originalTransactionId : @"nil"]];
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"in_app_ownership_type: %@\n\n", info.inAppOwnershipType ? info.inAppOwnershipType : @"nil"]];
    }else {
        infoStr = [infoStr stringByAppendingString:@"nil \n\n"];
    }
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Subscription unlocked: %@\n\n", [purchaseInfo isSubscriptionUnlockedUser] ? @"Yes" : @"No"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"User in grace period: %@\n\n", [purchaseInfo userInGracePeriod] ? @"Yes" : @"No"]];
    
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss.S"];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Original transaction date: %@\n\n", [purchaseInfo originalTransactionDate] ? [dateFormat stringFromDate:[purchaseInfo originalTransactionDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Subscription expired date: %@\n\n", [purchaseInfo currentSubscriptionExpiredDate] ? [dateFormat stringFromDate:[purchaseInfo currentSubscriptionExpiredDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"Grace period expired date: %@\n\n", [purchaseInfo currentGracePeriodExpiredDate] ? [dateFormat stringFromDate:[purchaseInfo currentGracePeriodExpiredDate]] : @"nil"]];
    
    infoStr = [infoStr stringByAppendingString:@"Purchased Items:\n\n"];
    
    for (NSString * product in [purchaseInfo purchasedIds]) {
        infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"%@ \n", product]];
    }
    
    self.labelt.text = infoStr;
}

- (void)dealloc {
    [AWPurchaseKit removePurchaseObserver:self];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)purchases:(AWPurchaseInfo *)purchaseInfo {
    NSArray<PurchasedProduct *> * purchasedProducts = purchaseInfo.purchasedArray;
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

@end

//
//  ViewController.m
//  SaaSDemo
//
//  Created by Yk Huang on 2021/2/2.
//

#import "ViewController.h"
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "ProductViewController.h"
#import "InfoViewController.h"
#import "UIAlertController+Global.h"

@interface ViewController ()<InAppPurchaseObserver>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [InAppPurchaseKit configureIAPKitWithApplicationIdentifier:@"com.meitu.airvid" apiKey:@"563951481cde2bd702c56f460a657f97" appId:123 inAppLanguage:@"en" firebaseId:nil appsflyerId:nil gid:nil];
    [InAppPurchaseKit addInAppPurchaseObserver:self];
    /// 家庭共享权利的撤销
    [InAppPurchaseKit setRevokeEntitlementsBlock:^(NSArray<NSString *> * _Nonnull productIdentifiers) {
        NSArray * a = productIdentifiers;
    }];
    
    [InAppPurchaseKit setShouldAddStorePaymentBlock:^(Product * _Nonnull product, SKPayment * _Nonnull payment) {
        [InAppPurchaseKit subscribeProductFromAppStorePromotion:product payment:payment completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!success) {
                    UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Failed" message:[NSString stringWithFormat:@"Purchase failed. Error message: %@", error.errorMessage] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert2 addAction:action2];
                    
                    [alert2 show:self];
                }else {
                    UIAlertController * alert3 = [UIAlertController alertControllerWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Error message: %@", error.errorMessage] preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert3 addAction:action3];
                    
                    [alert3 show:self];
                }
            });
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [InAppPurchaseKit removeInAppPurchaseObserver:self];
}

- (IBAction)purchase:(id)sender {
    ProductViewController * vc = [[ProductViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)restore:(id)sender {
    [InAppPurchaseKit restorePurchaseWithCompletion:^(BOOL success, NSArray * validSubscriptions, NSArray * purchasedItems, InAppPurchaseError * error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSString * str = @"";
//                if (purchasedItems.count) {
//                    for (NSString * productId in purchasedItems) {
//                        str = [str stringByAppendingString:productId];
//                        str = [str stringByAppendingString:@"\n"];
//                    }
//                }

                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Restore Success" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                }];
                [alert2 addAction:action2];

                [alert2 show:self];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Restore Failed" message:error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

                }];
                [alert2 addAction:action2];

                [alert2 show:self];
            });
        }
    }];
}

- (IBAction)refresh:(id)sender {
    [InAppPurchaseKit refreshInAppPurchaseInfoWithCompletion:^(BOOL success, InAppPurchaseError * error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Refresh Success" message:@"" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert2 addAction:action2];
                
                [alert2 show:self];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Refresh Failed" message:error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert2 addAction:action2];
                
                [alert2 show:self];
            });
        }
    }];
}

- (IBAction)info:(id)sender {
    InfoViewController * vc = [[InfoViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (IBAction)prehost:(id)sender {
//    [InAppPurchaseKit changeToPreproduction:YES];
     [InAppPurchaseKit refreshValidSubscriptions];
}

- (IBAction)debugHost:(id)sender {
   //    [InAppPurchaseKit changeToPreproduction:NO];
}

#pragma mark - InAppPurchaseObserver

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
        UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Subscription update" message:@"Check in Latest Subscription Info VC" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert2 addAction:action2];
        
        [alert2 show:self];
    });
}

- (void)validSubscriptionsUpdated:(NSArray<LatestSubscriptionInfo *> *)validSubscriptions {
    NSString * str = @"";
    
    for (LatestSubscriptionInfo * info in validSubscriptions) {
        NSString * productId = info.productIdentifier;
        str = [str stringByAppendingString:productId];
        str = [str stringByAppendingString:@"\n"];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Valid Subscriptions" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert2 addAction:action2];
        
        [alert2 show:self];
    });
}

#pragma mark - notification
- (void)addNotification {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)handleApplicationDidBecomeActive {
    [InAppPurchaseKit updateRemoteTime];
}

@end

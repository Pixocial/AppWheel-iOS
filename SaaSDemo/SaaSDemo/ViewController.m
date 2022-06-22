//
//  ViewController.m
//  PurchaseSDKDemo
//
//  Created by Yk Huang on 2021/1/25.
//

#import "ViewController.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import <PurchaseSDK/AWLogUtil.h>
#import "ProductViewController.h"
#import "InfoViewController.h"
#import "UIAlertController+Global.h"
#import "UIViewController+Loading.h"
#import "AppWheelUIKit.h"

@interface ViewController ()<AWPurchaseObserver>
@property (weak, nonatomic) IBOutlet UITextField *userIdTV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
 
    [self.view setBackgroundColor:UIColor.whiteColor];
    [AWPurchaseKit addPurchaseObserver:self];
    /// 家庭共享权利的撤销
    [AWPurchaseKit setRevokeEntitlementsBlock:^(NSArray<NSString *> * _Nonnull productIdentifiers) {
        NSArray * a = productIdentifiers;
    }];
    [AWPurchaseKit delUserId];
    [AWLogUtil isCanLog:YES];
//    [AWPurchaseKit setDebug:YES];
    [AWPurchaseKit configureWithAppId:121 secret:@"87481116-6a02-11ec-9266-42010ae30006" uid:self.userIdTV.text completion:^(BOOL success, AWError * _Nonnull error) {
        [AWPurchaseKit getUserId];
    }];
    
    
    [AWPurchaseKit setShouldAddStorePaymentBlock:^(AWProduct * _Nonnull product, SKPayment * _Nonnull payment) {
        [AWPurchaseKit subscribeProductFromAppStorePromotion:product payment:payment productType:@"your productType" completion:^(BOOL success, AWError * _Nonnull error) {
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
#pragma mark - initSDK
- (IBAction)initSDK:(id)sender {
    [self showLoading];
    __weak __typeof(self) weakSelf = self;
    [AWPurchaseKit delUserId];
    [AWPurchaseKit configureWithAppId:121 secret:@"87481116-6a02-11ec-9266-42010ae30006"
                                  uid:self.userIdTV.text completion:^(BOOL success, AWError * _Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        // do something
        [strongSelf hideLoading];
        if (success) {
            [strongSelf showDialogWithTitle:@"Success" message:@"Init Success"];
        } else {
            [strongSelf showDialogWithTitle:@"Fail" message:[NSString stringWithFormat:@"Init SDK Faild: %@", error.errorMessage]];
        }
    }];
}

- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [alert show:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [AWPurchaseKit removePurchaseObserver:self];
}

- (IBAction)purchase:(id)sender {
    ProductViewController * vc = [[ProductViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)restore:(id)sender {
    [AppWheelUIKit getPagesModelWithPageId:@"b247b0b52a72440b80bae282a2088be4" complete:^(BOOL result, AWPageModel *pageModel, NSString * errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result && pageModel) {
                [AppWheelUIKit presentSubscribeWithModel:pageModel fromViewController:self];
                return;
            }
            [self showDialogWithTitle:@"False" message:errorMsg];
            
        });
        
    }];
//    [self showLoading];
//    [AWPurchaseKit restorePurchaseWithCompletion:^(BOOL success, NSArray * validSubscriptions, NSArray * purchasedItems, AWError * error) {
//        [self hideLoading];
//        if (success) {
//            dispatch_async(dispatch_get_main_queue(), ^{
////                NSString * str = @"";
////                if (purchasedItems.count) {
////                    for (NSString * productId in purchasedItems) {
////                        str = [str stringByAppendingString:productId];
////                        str = [str stringByAppendingString:@"\n"];
////                    }
////                }
//
//                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Restore Success" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alert2 addAction:action2];
//
//                [alert2 show:self];
//            });
//        }else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Restore Failed" message:error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alert2 addAction:action2];
//
//                [alert2 show:self];
//            });
//        }
//    }];
}

- (IBAction)refresh:(id)sender {
//    [AWPurchaseKit refreshInAppPurchaseInfoWithCompletion:^(BOOL success, AWError * error) {
//        if (success) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Refresh Success" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alert2 addAction:action2];
//
//                [alert2 show:self];
//            });
//        }else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Refresh Failed" message:error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alert2 addAction:action2];
//
//                [alert2 show:self];
//            });
//        }
//    }];
    
    [AppWheelUIKit getPagesModelWithPageId:@"a697095a91f64649a939b2451219a969" complete:^(BOOL result, AWPageModel *pageModel, NSString * errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result && pageModel) {
                [AppWheelUIKit presentSubscribeWithModel:pageModel fromViewController:self];
                return;
            }
            [self showDialogWithTitle:@"False" message:errorMsg];
            
        });
        
    }];
}

- (IBAction)info:(id)sender {
    InfoViewController * vc = [[InfoViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{

    }];
}

- (IBAction)prehost:(id)sender {
//    [InAppPurchaseKit changeToPreproduction:YES];
     [AWPurchaseKit refreshValidSubscriptions];
}

- (IBAction)debugHost:(id)sender {
   //    [InAppPurchaseKit changeToPreproduction:NO];
}

- (IBAction)getRetryPeriodWithCompletion:(id)sender {

}



#pragma mark - InAppPurchaseObserver

- (void)purchases:(AWPurchaseInfo *)purchaseInfo {
    NSString * str = @"";
    
    for (PurchasedProduct * product in [purchaseInfo purchasedArray]) {
        NSString * productId = product.productIdentifier;
        str = [str stringByAppendingString:productId];
        str = [str stringByAppendingString:@"\n"];
    }
    if (purchaseInfo.isSubscriptionUnlockedUser) {
        str = [str stringByAppendingString:@"SubscriptionUnlock,Check in Purchase Info VC \n"];
    }
    if (str.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showDialogWithTitle:@"Item Unlocked" message:str];
        });
    }
}


#pragma mark - notification
- (void)addNotification {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(handleApplicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}
// update remote time when app become active
- (void)handleApplicationDidBecomeActive {
    [AWPurchaseKit updateRemoteTime];
}

@end

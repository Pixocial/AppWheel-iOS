//
//  ViewController.m
//  PurchaseSDKDemo
//
//  Created by Yk Huang on 2021/1/25.
//

#import "ViewController.h"
#import "AppWheelUIKit.h"
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "ProductViewController.h"
#import "InfoViewController.h"
#import "UIAlertController+Global.h"
#import "UIViewController+Loading.h"
#import "ProductHistoryViewController.h"

static NSString *const kIAPUidKey = @"kIAPUidKey";

@interface ViewController ()<InAppPurchaseObserver>
@property (weak, nonatomic) IBOutlet UITextField *userIdTV;
@property (weak, nonatomic) IBOutlet UILabel *userIdLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
 
    [self.view setBackgroundColor:UIColor.whiteColor];
    //切换成测试服的地址
    #if USE_API_SETTING
    [InAppPurchaseKit setDebug:NO];
    #else
    [InAppPurchaseKit setDebug:YES];
    #endif
    [InAppPurchaseKit addPurchaseObserver:self];
    /// 家庭共享权利的撤销
    [InAppPurchaseKit setRevokeEntitlementsBlock:^(NSArray<NSString *> * _Nonnull productIdentifiers) {
        NSArray * a = productIdentifiers;
    }];
    
    [InAppPurchaseKit configureWithAppId:121
                                     uid:self.userIdTV.text
                           applicationId:@"com.meitu.pomelo"
                                  apiKey:@"6f47588911f7b8c0602276fb294396e0"
                           inAppLanguage:@"en"
                              firebaseId:@"firebaseTestId"
                             appsflyerId:@"test"
                              completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
        // do something
        self.userIdLabel.text = [NSString stringWithFormat:@"userId:%@",[InAppPurchaseKit getUserId]];
    }];
    
    
    [InAppPurchaseKit setShouldAddStorePaymentBlock:^(Product * _Nonnull product, SKPayment * _Nonnull payment) {
        [InAppPurchaseKit subscribeProductFromAppStorePromotion:product payment:payment productType:@"your productType" completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
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
    
    //获取一下缓存里面的userid
    NSString *uid = [NSUserDefaults.standardUserDefaults stringForKey:kIAPUidKey];
    if (uid && uid.length > 0) {
        self.userIdTV.text = uid;
    }
}
#pragma mark - initSDK
- (IBAction)initSDK:(id)sender {
    [self showLoading];
    __weak __typeof(self) weakSelf = self;
    if (self.userIdTV.text && self.userIdTV.text.length > 0) {
        [NSUserDefaults.standardUserDefaults setValue:self.userIdTV.text forKey:kIAPUidKey];
    }
    [InAppPurchaseKit configureWithAppId:121
                                     uid:self.userIdTV.text
                           applicationId:@"com.meitu.pomelo"
                                  apiKey:@"6f47588911f7b8c0602276fb294396e0"
                           inAppLanguage:@"en"
                              firebaseId:@"firebaseTestId"
                             appsflyerId:@"test"  completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        // do something
        [strongSelf hideLoading];
        if (success) {
            [strongSelf showDialogWithTitle:@"Success" message:@"Init Success"];
            
            strongSelf.userIdLabel.text = [NSString stringWithFormat:@"userId:%@",[InAppPurchaseKit getUserId]];
        } else {
            [strongSelf showDialogWithTitle:@"Fail" message:[NSString stringWithFormat:@"Init SDK Faild: %@", error.errorMessage]];
        }
    }];
}
- (IBAction)delKeyChain:(id)sender {
//    [InAppPurchaseKit delKC];
    
    [AppWheelUIKit getPagesModelWithComplete:^(BOOL result, NSArray<AWPageModel *> * pageModels, NSError * error) {
        [AppWheelUIKit presentSubscribeWithModel:pageModels[0] fromViewController:self];
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
    [InAppPurchaseKit removePurchaseObserver:self];
}

- (IBAction)purchase:(id)sender {
    ProductViewController * vc = [[ProductViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)restore:(id)sender {
    [self showLoading];
    [InAppPurchaseKit restorePurchaseWithCompletion:^(BOOL success, NSArray * validSubscriptions, NSArray * purchasedItems, InAppPurchaseError * error) {
        [self hideLoading];
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

- (IBAction)getRetryPeriodWithCompletion:(id)sender {
    [InAppPurchaseKit getRetryPeriodWithCompletion:^(BOOL isInRetryPeriod, InAppPurchaseError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"retryPeriod" message:[NSString stringWithFormat:@"result:%d",isInRetryPeriod]  preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert2 addAction:action2];
            
            [alert2 show:self];
        });
    }];
}

- (IBAction)history:(id)sender {
    ProductHistoryViewController * vc = [[ProductHistoryViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}


#pragma mark - InAppPurchaseObserver

- (void)purchases:(InAppPurchaseInfo *)purchaseInfo {
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
    [InAppPurchaseKit updateRemoteTime];
}

@end

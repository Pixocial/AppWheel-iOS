//
//  ProductDetailVC.m
//  PurchaseSDKDemo
//
//  Created by yikunHuang on 2021/8/24.
//

#import "ProductDetailVC.h"
#import "UIViewController+Loading.h"
#import "UIAlertController+Global.h"

@interface ProductDetailVC()<InAppPurchaseObserver>

@property(strong, nonatomic)UITextView *skuDetailLabel;
@property(strong, nonatomic)UIButton *purchaseBtn;
@property(strong, nonatomic)UIButton *backBtn;

@end

@implementation ProductDetailVC

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [InAppPurchaseKit addPurchaseObserver:self];
    [self setLabelTextWithProduct:self.product];
    
    [self.purchaseBtn addTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];
}

- (void)dealloc {
    [InAppPurchaseKit removePurchaseObserver:self];
}
- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame: CGRectMake(20, 50, 50, 50)];
        [_backBtn setTitle:@"back" forState:UIControlStateNormal];
        [_backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark:- show product detail
- (UITextView *)skuDetailLabel {
    if (!_skuDetailLabel) {
        _skuDetailLabel = [[UITextView alloc]initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, self.view.frame.size.height - 60)];
        _skuDetailLabel.textColor = [UIColor blackColor];
        [_skuDetailLabel setFont:[UIFont systemFontOfSize:12] ];
        _skuDetailLabel.textAlignment = NSTextAlignmentLeft;
        _skuDetailLabel.editable = NO;
        [self.view addSubview:_skuDetailLabel];
    }
    return _skuDetailLabel;
}

- (void)setLabelTextWithProduct:(Product *)product {
    self.product = product;
    
    NSString * productID = self.product.productIdentifier;
    NSString * price = self.product.localizedPrice;
    NSString * title = self.product.localizedTitle;
    NSString * desc = self.product.localizedDescription;
    
    SubscriptionPeriod * period = self.product.subscriptionPeriod;
    NSString * periodString = @"";
    if (period) {
        periodString = [NSString stringWithFormat:@"%ld %@ \n", (long)period.numberOfDiscountUnits, [self unitString:period.unitType]];
    }
    
    NSString * introductoryPriceString = @"";
    if (self.product.introductoryPrice) {
        if (self.product.introductoryPrice.discountIdentifier) {
           introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"\nintroductory discount id: %@ \n", self.product.introductoryPrice.discountIdentifier]];
        }else {
            introductoryPriceString = [introductoryPriceString stringByAppendingString:@"\n"];
        }
        
        introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"introductory discount price: %@ \n", self.product.introductoryPrice.discountLocalizedPrice]];
        
        introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"introductory discount payment mode: %@ \n", [self discountMode:self.product.introductoryPrice.discountPaymentMode]]];
        
        if (self.product.introductoryPrice.discountPeriod) {
            introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"introductory discount period: %ld %@ \n", (long)self.product.introductoryPrice.discountPeriod.numberOfDiscountUnits, [self unitString:self.product.introductoryPrice.discountPeriod.unitType]]];
        }
        
        introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"introductory discount number of period: %ld \n", (long)self.product.introductoryPrice.numberOfDiscountPeriod]];
    }
    
//    self.subscriptionOfferIds = self.product.discounts;
    
    if (self.product.discounts.count) {
        for (ProductDiscount * subscriptionDiscount in self.product.discounts) {
            if (subscriptionDiscount.discountIdentifier) {
                introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"\nsubscription discount id: %@ \n", subscriptionDiscount.discountIdentifier]];
            }
            
            introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"subscription discount price: %@ \n", subscriptionDiscount.discountLocalizedPrice]];
            
            introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"subscription discount payment mode: %@ \n", [self discountMode:subscriptionDiscount.discountPaymentMode]]];
            
            if (subscriptionDiscount.discountPeriod) {
                introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"subscription discount period: %ld %@ \n", (long)subscriptionDiscount.discountPeriod.numberOfDiscountUnits, [self unitString:subscriptionDiscount.discountPeriod.unitType]]];
            }
            
            introductoryPriceString = [introductoryPriceString stringByAppendingString:[NSString stringWithFormat:@"subscription discount number of period: %ld \n", (long)subscriptionDiscount.numberOfDiscountPeriod]];
        }
    }
    
    
    NSString  *isFamilyShareable = [NSString stringWithFormat:@"isFamilyShareable: %d", self.product.isFamilyShareable];;
    
    NSString * alertMsg = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@ \n%@ %@ \n%@", productID, price, title, desc, periodString, introductoryPriceString, isFamilyShareable];
    
    self.skuDetailLabel.text = alertMsg;
    
}

- (NSString *)unitString:(SubscriptionUnitType)type {
    switch (type) {
        case SubscriptionUnitTypeDay:
            return @"day";
            break;
            
        case SubscriptionUnitTypeWeek:
            return @"week";
            break;
            
        case SubscriptionUnitTypeMonth:
            return @"month";
            break;
            
        case SubscriptionUnitTypeYear:
            return @"year";
            break;
    }
}

- (NSString *)discountMode:(DiscountPaymentMode)mode {
    switch (mode) {
        case DiscountPaymentModeNone:
            return @"none";
            break;
            
        case DiscountPaymentModePayUpFront:
            return @"pay up front";
            break;
            
        case DiscountPaymentModePayAsYouGo:
            return @"pay as you go";
            break;
            
        case DiscountPaymentModeFreeTrial:
            return @"free trial";
            break;
    }
}

#pragma mark:-  purchase product
- (UIButton *)purchaseBtn {
    if (!_purchaseBtn) {
        CGSize size = self.view.frame.size;
        _purchaseBtn = [[UIButton alloc] initWithFrame: CGRectMake(30, size.height - 200, 100, 50)];
        [_purchaseBtn setTitle:@"purchase" forState:UIControlStateNormal];
        [_purchaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _purchaseBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        _purchaseBtn.backgroundColor = [UIColor grayColor];
        [self.view addSubview:_purchaseBtn];
        
        
    }
    return _purchaseBtn;
}

- (void)purchase {
    [self showLoading];
    if (self.product.productType == 0 || self.product.productType == 1) {
        [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:nil completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
                [self hideLoading];
                if (!success) {
                    [self showDialogWithTitle:@"Failed" message:[NSString stringWithFormat:@"Purchase failed. Error message: %@", error.errorMessage]];
                }else {
                    [self showDialogWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Success message: %@", error.errorMessage]];
                }
        }];
        return;
    }
    [self subscribe];
}

- (void)subscribe {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Purchase" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [self showLoading];
    /// no discounts
    UIAlertAction * normalPurchase = [UIAlertAction actionWithTitle:@"Purchase normal price" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:nil completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideLoading];
                    if (!success) {
                        [self showDialogWithTitle:@"Failed" message:[NSString stringWithFormat:@"Purchase failed. Error message: %@", error.errorMessage]];
                    }else {
                        [self showDialogWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Success message: %@", error.errorMessage]];
                    }
                });
        }];
    }];
    [alert addAction:normalPurchase];
    /// purchase with discounts
    for (ProductDiscount * subscriptionDiscount in self.product.discounts) {
        UIAlertAction * action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Purchase promotional offer: %@", subscriptionDiscount.discountIdentifier] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Get Discounts Signature
            [InAppPurchaseKit fetchSubscriptionOfferWithProductIdentifier:self.product.productIdentifier subscriptionOfferIdentifier:subscriptionDiscount.discountIdentifier completion:^(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error) {
                
                if (error.errorCode != 0) {
                    [self hideLoading];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showDialogWithTitle:@"Failed" message:[NSString stringWithFormat:@"Fetch payment discount failed. Error message: %@", error.errorMessage]];
                    });
                }else {
                    //purchase with discounts
                    [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:paymentDiscount completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self hideLoading];
                                if (!success) {
                                    [self showDialogWithTitle:@"Failed" message:[NSString stringWithFormat:@"Fetch payment discount success but purchase failed. Error message: %@", error.errorMessage]];
                                }else {
                                    [self showDialogWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Success message: %@", error.errorMessage]];
                                }
                            });
                    }];
                }
            }];
        }];
        [alert addAction:action];
    }
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self hideLoading];
    }];
    [alert addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^{
       [alert show:self];
    });
}

- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [alert show:self];
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
        str = [str stringByAppendingString:@"SubscriptionUnlock,Check in Purchase Info VC"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showDialogWithTitle:@"Item Unlocked" message:str];
    });
}
@end

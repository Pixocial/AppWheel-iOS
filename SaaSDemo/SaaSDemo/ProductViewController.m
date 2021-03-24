//
//  ProductViewController.m
//  InAppPurchaseKit_Example
//
//  Created by Ellise on 2020/6/2.
//  Copyright © 2020 Pizhen Huang. All rights reserved.
//

#import "ProductViewController.h"
#import <PurchaseSDK/InAppPurchaseKit.h>
#import "UIAlertController+Global.h"
#import "UIViewController+Loading.h"
#import "EBDropdownListView.h"

@interface ProductViewController ()<UITextFieldDelegate, InAppPurchaseObserver>

@property (nonatomic, strong) NSMutableArray * productDetailInfo;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (weak, nonatomic) IBOutlet UIButton *fetchProductBtn;
@property (nonatomic, strong) Product * product;

@property (nonatomic, strong) NSArray<ProductDiscount *> * subscriptionOfferIds;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) UIActivityIndicatorView *loadingView;

@property (strong, nonatomic)NSString *productType;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    // Do any additional setup after loading the view from its nib.
    [self initDropdownList];
    [InAppPurchaseKit addPurchaseObserver:self];
    self.textFiled.delegate = self;

}

- (void)dealloc {
    [InAppPurchaseKit removePurchaseObserver:self];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 消耗、非消耗商品的购买
- (IBAction)purchase:(id)sender {
    if (self.productType) {
        if ([self.productType  isEqual: @"consumables"] || [self.productType  isEqual: @"non-consumables"]) {
            [self purchaseGoods];
        } else if ([self.productType  isEqual: @"auto-renewable"] || [self.productType  isEqual: @"non-renewable"]) {
            [self subscription];
        }
        
        
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showDialogWithTitle:@"No productType" message:@""];
        });
    }
    
}
/// purchase consumables\non-consumables
- (void)purchaseGoods {
    if (self.product) {
        [self showLoading];
        [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:nil quantity:1 productType:self.productType completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
                [self hideLoading];
                if (!success) {
                    [self showDialogWithTitle:@"Failed" message:[NSString stringWithFormat:@"Purchase failed. Error message: %@", error.errorMessage]];
                }else {
                    [self showDialogWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Success message: %@", error.errorMessage]];
                }
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showDialogWithTitle:@"No product" message:@""];
        });
    }
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
    
    self.subscriptionOfferIds = self.product.discounts;
    
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
    
    self.label.text = alertMsg;
    
    [self showDialogWithTitle:@"Fetch Success" message:@""];
}
#pragma mark - 查询商品信息
- (IBAction)fetch:(id)sender {
    [self.textFiled resignFirstResponder];
    if (self.textFiled.text.length) {
        NSMutableSet * set = [[NSMutableSet alloc] init];
        [set addObject:self.textFiled.text];
        [self showLoading];
        [InAppPurchaseKit getProductsInfoWithProductIdentifiers:set completion:^(RetrievedProducts * _Nonnull retrievedProducts) {
            [self hideLoading];
            if (retrievedProducts.error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showDialogWithTitle:@"Failed" message:retrievedProducts.error.errorMessage];
                });
            }else if (retrievedProducts.invalidProductIdentifiers.count) {
                NSString * invalidProducts = [NSString stringWithFormat:@"Invalid Identifier:"];
                for (NSString * productID in retrievedProducts.invalidProductIdentifiers) {
                    invalidProducts = [invalidProducts stringByAppendingString:[NSString stringWithFormat:@"\n%@", productID]];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showDialogWithTitle:@"Failed" message:invalidProducts];
                });
            }else if (retrievedProducts.validProducts.count){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setLabelTextWithProduct:[retrievedProducts.validProducts objectAtIndex:0]];
                });
            }
        }];
    }
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
#pragma mark - 优惠代码
- (IBAction)redeem:(id)sender {
    [InAppPurchaseKit presentCodeRedemptionSheet];
}

#pragma mark -Subscription
- (IBAction)subscription {
    if (self.product) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Purchase" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self showLoading];
        /// no discounts
        UIAlertAction * normalPurchase = [UIAlertAction actionWithTitle:@"Purchase normal price" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:nil quantity:nil productType:self.productType completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
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
                        [InAppPurchaseKit purchaseProduct:self.product paymentDiscount:paymentDiscount quantity:1 productType:self.productType completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
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
            
        }];
        [alert addAction:action];
        dispatch_async(dispatch_get_main_queue(), ^{
           [alert show:self];
        });
    }
else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showDialogWithTitle:@"No product" message:@""];
        });
    }
}


- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [alert show:self];
}

#pragma mark -DropdownList
- (void)initDropdownList {
    EBDropdownListItem *item1 = [[EBDropdownListItem alloc] initWithItem:@"1" itemName:@"consumables"];
    EBDropdownListItem *item2 = [[EBDropdownListItem alloc] initWithItem:@"2" itemName:@"non-consumables"];
    EBDropdownListItem *item3 = [[EBDropdownListItem alloc] initWithItem:@"3" itemName:@"auto-renewable"];
    EBDropdownListItem *item4 = [[EBDropdownListItem alloc] initWithItem:@"4" itemName:@"non-renewable"];
    
    EBDropdownListView *dropdownListView = [EBDropdownListView new];
    dropdownListView.dataSource = @[item1, item2, item3, item4];
    CGRect frame = self.fetchProductBtn.frame;
    dropdownListView.frame = CGRectMake(frame.origin.x, frame.origin.y+40, 150, 30);
    [dropdownListView setViewBorder:0.5 borderColor:[UIColor grayColor] cornerRadius:2];
    [self.view addSubview:dropdownListView];
    
    __weak __typeof(self) weakSelf = self;
    [dropdownListView setDropdownListViewSelectedBlock:^(EBDropdownListView *dlv) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        strongSelf.productType = dlv.selectedItem.itemName;
        
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
        str = [str stringByAppendingString:@"SubscriptionUnlock,Check in Purchase Info VC"];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showDialogWithTitle:@"Item Unlocked" message:str];
    });
}
//- (void)iapUnlockedItemsUpdated:(nonnull NSArray<PurchasedProduct *> *)purchasedProducts {
//    NSString * str = @"";
//
//    for (PurchasedProduct * product in purchasedProducts) {
//        NSString * productId = product.productIdentifier;
//        str = [str stringByAppendingString:productId];
//        str = [str stringByAppendingString:@"\n"];
//    }
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self showDialogWithTitle:@"Item Unlocked" message:str];
//    });
//}

//- (void)subscriptionStateUpdated {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self showDialogWithTitle:@"Subscription update" message:@"Check in Latest Subscription Info VC"];
//    });
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

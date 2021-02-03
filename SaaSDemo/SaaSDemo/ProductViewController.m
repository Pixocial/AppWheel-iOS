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

@interface ProductViewController ()<UITextFieldDelegate, InAppPurchaseObserver>

@property (nonatomic, strong) NSMutableArray * productDetailInfo;

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (nonatomic, strong) Product * product;

@property (nonatomic, strong) NSArray<ProductDiscount *> * subscriptionOfferIds;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [InAppPurchaseKit addInAppPurchaseObserver:self];
    self.textFiled.delegate = self;
    self.textFiled.text = @"com.commsource.airvid.subscription.1month.fullprice";
}

- (void)dealloc {
    [InAppPurchaseKit removeInAppPurchaseObserver:self];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - 购买商品
- (IBAction)purchase:(id)sender {
    if (self.product) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Purchase" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * normalPurchase = [UIAlertAction actionWithTitle:@"Purchase normal price" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [InAppPurchaseKit subscribeProductIdentifier:self.product.productIdentifier paymentDiscount:nil completion:^(BOOL success, InAppPurchaseError * _Nonnull error) {
                
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
        [alert addAction:normalPurchase];
        
        for (ProductDiscount * subscriptionDiscount in self.product.discounts) {
            UIAlertAction * action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Purchase promotional offer: %@", subscriptionDiscount.discountIdentifier] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [InAppPurchaseKit fetchSubscriptionOfferWithProductIdentifier:self.product.productIdentifier subscriptionOfferIdentifier:subscriptionDiscount.discountIdentifier completion:^(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error) {
                    
                    if (error.errorCode != 0) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertController * alert1 = [UIAlertController alertControllerWithTitle:@"Failed" message:[NSString stringWithFormat:@"Fetch payment discount failed. Error message: %@", error.errorMessage] preferredStyle:UIAlertControllerStyleAlert];
                                                   UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                   }];
                                                   [alert1 addAction:action1];
                                                   
                                                   [alert1 show:self];
                        });
                    }else {
                        [InAppPurchaseKit subscribeProduct:self.product paymentDiscount:paymentDiscount completion:^(BOOL success, InAppPurchaseError * error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (!success) {
                                    UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"Failed" message:[NSString stringWithFormat:@"Fetch payment discount success but purchase failed. Error message: %@", error.errorMessage] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                    }];
                                    [alert2 addAction:action2];
                                    
                                    [alert2 show:self];
                                    [self presentViewController:alert2 animated:YES completion:nil];
                                }else {
                                    UIAlertController * alert3 = [UIAlertController alertControllerWithTitle:@"Success" message:[NSString stringWithFormat:@"Fetch payment discount success and purchase success. Error message: %@", error.errorMessage] preferredStyle:UIAlertControllerStyleAlert];
                                    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                        
                                    }];
                                    [alert3 addAction:action3];
                                    
                                    [alert3 show:self];
                                    [self presentViewController:alert3 animated:YES completion:nil];
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
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"No product" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert2 addAction:action2];
            
            [self presentViewController:alert2 animated:YES completion:nil];
//            [alert2 show];
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
    
    NSString * alertMsg = [NSString stringWithFormat:@"%@ \n%@ \n%@ \n%@ \n%@ %@", productID, price, title, desc, periodString, introductoryPriceString];
    
    self.label.text = alertMsg;
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Fetch Success" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [alert show:self];
}
#pragma mark - 查询商品信息
- (IBAction)fetch:(id)sender {
    [self.textFiled resignFirstResponder];
    if (self.textFiled.text.length) {
        NSMutableSet * set = [[NSMutableSet alloc] init];
        [set addObject:self.textFiled.text];
        [InAppPurchaseKit fetchProductsInfoWithProductIdentifiers:set completion:^(RetrievedProducts * _Nonnull retrievedProducts) {
            if (retrievedProducts.error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Failed" message:retrievedProducts.error.errorMessage preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    
                    [alert show:self];
                });
            }else if (retrievedProducts.invalidProductIdentifiers.count) {
                NSString * invalidProducts = [NSString stringWithFormat:@"Invalid Identifier:"];
                for (NSString * productID in retrievedProducts.invalidProductIdentifiers) {
                    invalidProducts = [invalidProducts stringByAppendingString:[NSString stringWithFormat:@"\n%@", productID]];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Failed" message:invalidProducts preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [alert addAction:action];
                    
                    [alert show:self];
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



#pragma mark - iap代理
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}




@end

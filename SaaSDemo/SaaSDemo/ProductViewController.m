//
//  ProductViewController.m
//  InAppPurchaseKit_Example
//
//  Created by Ellise on 2020/6/2.
//  Copyright © 2020 Pizhen Huang. All rights reserved.
//

#import "ProductViewController.h"
#import <PurchaseSDK/AWPurchaseKit.h>
#import "UIAlertController+Global.h"
#import "UIViewController+Loading.h"
#import "EBDropdownListView.h"
#import "ProductDetailVC.h"

@interface ProductViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray * productDetailInfo;

@property (weak, nonatomic) IBOutlet UICollectionView *skuCV;

@property (nonatomic, strong) AWProduct * product;

@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) UIActivityIndicatorView *loadingView;

@property(strong, nonatomic) NSSet<NSString *> *skuSet;

@property (nonatomic, strong) NSArray<AWProduct *> * validProducts;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    [self querySKU];
}

- (NSSet<NSString *> *)skuSet {
    if (!_skuSet) {
        _skuSet = [[NSSet alloc] initWithObjects: @"com.commsource.pomelo.subscription.1year.test",
        @"com.commsource.pomelo.subscription.1year.newuser",
        @"com.commsource.pomelo.subscription.1year.newuser.test",
        @"subscription_ye",
        @"subscription_mo",
        @"com.commsource.pomelo.subscription.1month.test",
        @"com.commsource.pomelo.filterPack",
        @"Brightness",
        @"com.commsource.pomelo.lifetime.test",
        @"Leak",
        @"Freeze",
        @"Fade",
        @"com.commsource.pomelo.timespackages", nil];
    }
    return _skuSet;
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - query product information

- (void)querySKU {
    if (self.skuSet) {
        [self showLoading];
        [AWPurchaseKit getProductsInfoWithProductIdentifiers:self.skuSet completion:^(RetrievedProducts * _Nonnull retrievedProducts) {
            [self hideLoading];
            if (retrievedProducts.error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showDialogWithTitle:@"Failed" message:retrievedProducts.error.errorMessage];
                });
                return;
            }
            if (retrievedProducts.validProducts.count){
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.validProducts = retrievedProducts.validProducts;
                    [self updateUI];
                });
            }
            if (retrievedProducts.invalidProductIdentifiers.count) {
                NSString * invalidProducts = [NSString stringWithFormat:@"Invalid Identifier:"];
                for (NSString * productID in retrievedProducts.invalidProductIdentifiers) {
                    invalidProducts = [invalidProducts stringByAppendingString:[NSString stringWithFormat:@"\n%@", productID]];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showDialogWithTitle:@"Failed" message:invalidProducts];
                });
            }
        }];
    }
}

- (void)updateUI {
    if (self.validProducts) {
        // sort up product
        NSArray *consumables = @[@"com.commsource.pomelo.timespackages"];
        NSArray *nonConsumables = @[@"Fade",@"Freeze",@"Leak",
                                    @"com.commsource.pomelo.lifetime.test",@"pro_lifetime",@"Brightness"];
        NSArray *renewable = @[@"com.commsource.pomelo.subscription.1year.test",
                               @"com.commsource.pomelo.subscription.1year.newuser",
                               @"com.commsource.pomelo.subscription.1year.newuser.test",
                               @"subscription_ye",
                               @"subscription_mo",
                               @"com.commsource.pomelo.subscription.1month.test"];
        NSArray *nonRenewable = @[@"com.commsource.pomelo.filterPack"];
        // set productType and quantity
        for (AWProduct *product in self.validProducts) {
            product.quantity = 1;
            if ([consumables containsObject: product.productIdentifier] ) {
                product.productType = 0;
                continue;;
            }
            if ([nonConsumables containsObject: product.productIdentifier] ) {
                product.productType = 1;
                continue;
            }
            if ([renewable containsObject: product.productIdentifier] ) {
                product.productType = 2;
                continue;
            }
            if ([nonRenewable containsObject: product.productIdentifier] ) {
                product.productType = 3;
                continue;
            }
        }
        
        
        //then update UI
        self.skuCV.delegate = self;
        self.skuCV.dataSource = self;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.itemSize = CGSizeMake(self.skuCV.frame.size.width, 30);
        self.skuCV.collectionViewLayout = layout;
        [self.skuCV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [self.skuCV reloadData];
    }
}


#pragma mark - 优惠代码
- (IBAction)redeem:(id)sender {
    [AWPurchaseKit presentCodeRedemptionSheet];
}

- (void)showDialogWithTitle:(NSString *)title
                    message:(NSString *)msg {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    
    [alert show:self];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.validProducts.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont systemFontOfSize:12]];
    [cell addSubview:label];
    
    AWProduct *product = [self.validProducts objectAtIndex:indexPath.row];
    [label setText:product.productIdentifier];
    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailVC * vc = [[ProductDetailVC alloc] init];
    vc.product = [self.validProducts objectAtIndex:indexPath.row];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end

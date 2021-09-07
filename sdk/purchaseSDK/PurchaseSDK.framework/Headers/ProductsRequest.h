//
//  ProductsRequest.h
//  AirBrush
//
//  Created by Ellise on 2020/5/26.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "Product.h"
#import "InAppPurchaseError.h"

NS_ASSUME_NONNULL_BEGIN

@interface RetrievedProducts : NSObject

@property (nonatomic, strong) NSArray<Product *> * validProducts;

@property (nonatomic, strong) NSArray<NSString *> * invalidProductIdentifiers;

@property (nonatomic, strong, nullable) InAppPurchaseError * error;

@end

typedef void(^ProductsFetchedBlock)(RetrievedProducts * retrievedProducts);

typedef void(^RawProductsBlock)(NSArray<SKProduct *> * rawProducts);

@interface ProductsRequest : NSObject

- (instancetype)initWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers rawProducts:(RawProductsBlock)rawProducts completion:(ProductsFetchedBlock)completion;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END

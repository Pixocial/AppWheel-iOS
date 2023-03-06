//
//  AWProductsRequest.h
//  AirBrush
//
//  Created by Ellise on 2020/5/26.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "AWProduct.h"
#import <AWCore/AWError.h>

NS_ASSUME_NONNULL_BEGIN

@interface RetrievedProducts : NSObject

@property (nonatomic, strong) NSArray<AWProduct *> * validProducts;

@property (nonatomic, strong) NSArray<NSString *> * invalidProductIdentifiers;

@property (nonatomic, strong, nullable) AWError * error;

@end

typedef void(^ProductsFetchedBlock)(RetrievedProducts * retrievedProducts);

typedef void(^RawProductsBlock)(NSArray<SKProduct *> * rawProducts);

typedef void(^OfferCodeProductsBlock)(AWProduct * _Nullable product, AWError * _Nullable error);

@interface AWProductsRequest : NSObject

- (instancetype)initWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers rawProducts:(RawProductsBlock)rawProducts completion:(ProductsFetchedBlock)completion;

- (void)start;

- (void)cancel;

@end

NS_ASSUME_NONNULL_END

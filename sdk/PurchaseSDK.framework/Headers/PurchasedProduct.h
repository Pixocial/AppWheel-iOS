//
//  PurchasedProduct.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchasedProduct : NSObject

@property (nonatomic, strong) NSString * productIdentifier;

@property (nonatomic, assign) NSInteger quantity;

@property (nonatomic, strong, nullable) NSString *originalTransactionId;

@property (nonatomic, strong, nullable) NSString *productType;

- (instancetype)initWithPurchasedProduct:(NSDictionary *)purchasedProduct;

@end

NS_ASSUME_NONNULL_END

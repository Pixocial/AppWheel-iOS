//
//  PaymentDiscount.h
//  AirBrush
//
//  Created by Ellise on 2020/5/25.
//  Copyright © 2020 Meitu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentDiscountOffer : NSObject

@property (nonatomic, strong) NSString * discountIdentifier;

@property (nonatomic, strong) NSString * keyIdentifier;

@property (nonatomic, strong) NSString * nonce;

@property (nonatomic, strong) NSString * signature;

@property (nonatomic, assign) NSInteger timestamp;

@end

NS_ASSUME_NONNULL_END

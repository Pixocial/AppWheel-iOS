//
//  AWError.h
//  AWPurchaseKit
//
//  Created by Ellise on 2020/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWErrorType) {
    AWErrorTypeUnknown = 0,
    
    AWErrorTypeClientInvalid = 1,
    AWErrorTypePaymentCancelled = 2,
    AWErrorTypePaymentInvalid = 3,
    AWErrorTypePaymentNotAllowed = 4,
    AWErrorTypeStoreProductNotAvailable = 5,
    
    AWErrorTypeInvalidOfferIdentifier = 11,
    AWErrorTypeInvalidSignature = 12,
    AWErrorTypeMissingOfferParams = 13,
    AWErrorTypeInvalidOfferPrice = 14,
    
    AWErrorTypeAPISecretError = 10000,
    AWErrorTypeAPICertError = 10001,
    AWErrorTypeClientParamError = 10002,
    AWErrorTypeSqlExecuteError = 10100,
    AWErrorTypeDBDataError = 10101,
    AWErrorTypeRedisConnectError = 10200,
    
    AWErrorTypeAppStoreConnectError = 20000,
    
    AWErrorTypeSubOfferSubscriptionError = 20001,
    AWErrorTypeSubOfferSubscriptionExpired = 20002,
    AWErrorTypeSubOfferCancelSubInfoError = 20003,
    AWErrorTypeSubOfferParamsEmpty = 20004,
    AWErrorTypeSubOfferGenerateSignatureError = 20005,
    
    AWErrorTypeNoReceiptDataOnDevice = 30000,
    AWErrorTypeInvalidRawData = 30001,
    AWErrorTypeNothingToDecrypt = 30002,
    AWErrorTypeFailedToDecrypt = 30003,
    AWErrorTypeDataDecryptedNotInJSON = 30004,
    AWErrorTypeNoItemInReceipt = 30005,
    AWErrorTypeNoSubscriptionInReceipt = 30006,
    AWErrorTypeSubscriptionExpiredInReceipt = 30007,
    AWErrorTypePurchaseItemError = 30008,
    
    AWErrorTypeInvalidProductIdentifier = 30009,
    ///商品类型错误
    AWErrorTypeInvalidProductType = 30010,
    /// 初始化错误
    AWErrorTypeInit = 30011,
    /// 解析get_ios_retry_period接口出错
    AWErrorTypeRetryPeriod = 30013,
    /// 传的product为nil或者没有productId
    AWErrorTypeProductError = 30014,
    /// 传的product为nil或者没有productId
    AWErrorTypeRequestOfferCodeProductError = 30016,
    ///解析stripe的订单数据有问题
    AWErrorTypeRequestStripeOrderError = 30017,
};

@interface AWError : NSObject

@property (nonatomic, assign) AWErrorType errorCode;

@property (nonatomic, strong) NSString * errorMessage;

- (instancetype)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END

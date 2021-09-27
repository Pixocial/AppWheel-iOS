//
//  InAppPurchaseError.h
//  InAppPurchaseKit
//
//  Created by Ellise on 2020/6/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InAppPurchaseErrorType) {
    InAppPurchaseErrorTypeUnknown = 0,
    
    InAppPurchaseErrorTypeClientInvalid = 1,
    InAppPurchaseErrorTypePaymentCancelled = 2,
    InAppPurchaseErrorTypePaymentInvalid = 3,
    InAppPurchaseErrorTypePaymentNotAllowed = 4,
    InAppPurchaseErrorTypeStoreProductNotAvailable = 5,
    
    InAppPurchaseErrorTypeInvalidOfferIdentifier = 11,
    InAppPurchaseErrorTypeInvalidOfferPrice = 12,
    InAppPurchaseErrorTypeInvalidSignature = 13,
    InAppPurchaseErrorTypeMissingOfferParams = 14,
    
    InAppPurchaseErrorTypeAPISecretError = 10000,
    InAppPurchaseErrorTypeAPICertError = 10001,
    InAppPurchaseErrorTypeClientParamError = 10002,
    InAppPurchaseErrorTypeSqlExecuteError = 10100,
    InAppPurchaseErrorTypeDBDataError = 10101,
    InAppPurchaseErrorTypeRedisConnectError = 10200,
    
    InAppPurchaseErrorTypeAppStoreConnectError = 20000,
    
    InAppPurchaseErrorTypeSubOfferSubscriptionError = 20001,
    InAppPurchaseErrorTypeSubOfferSubscriptionExpired = 20002,
    InAppPurchaseErrorTypeSubOfferCancelSubInfoError = 20003,
    InAppPurchaseErrorTypeSubOfferParamsEmpty = 20004,
    InAppPurchaseErrorTypeSubOfferGenerateSignatureError = 20005,
    
    InAppPurchaseErrorTypeNoReceiptDataOnDevice = 30000,
    InAppPurchaseErrorTypeInvalidRawData = 30001,
    InAppPurchaseErrorTypeNothingToDecrypt = 30002,
    InAppPurchaseErrorTypeFailedToDecrypt = 30003,
    InAppPurchaseErrorTypeDataDecryptedNotInJSON = 30004,
    InAppPurchaseErrorTypeNoItemInReceipt = 30005,
    InAppPurchaseErrorTypeNoSubscriptionInReceipt = 30006,
    InAppPurchaseErrorTypeSubscriptionExpiredInReceipt = 30007,
    InAppPurchaseErrorTypePurchaseItemError = 30008,
    
    InAppPurchaseErrorTypeInvalidProductIdentifier = 30009,
    ///商品类型错误
    InAppPurchaseErrorTypeInvalidProductType = 30010,
    /// 初始化错误
    InAppPurchaseErrorTypeInit = 30011,
    /// 未知的错误(网络错误啊之类的)
    InAppPurchaseErrorTypeUnknow = 30012,
    /// 解析get_ios_retry_period接口出错
    InAppPurchaseErrorTypeRetryPeriod = 30013,
    /// 传的product为nil或者没有productId
    InAppPurchaseErrorTypeProductError = 30014,
};

@interface InAppPurchaseError : NSObject

@property (nonatomic, assign) InAppPurchaseErrorType errorCode;

@property (nonatomic, strong) NSString * errorMessage;

- (instancetype)initWithErrorCode:(NSInteger)errorCode errorMessage:(NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END

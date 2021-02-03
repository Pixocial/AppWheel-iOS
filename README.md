# testSaaS
简介


这是订阅中台的iOS组件，将iOS上使用StoreKit实现的完整生命流程抽象出来，支持以下功能：
从App Store Connect获取商品信息
购买/订阅商品
恢复购买/订阅
刷新收据信息
获取订阅折扣签名
ROI数据收集



使用说明

接入要求

iOS 10.0以上
项目已接入Firebase与AppsFlyer SDK，并在启动时调用以下代码以进行数据上报

[FIRAnalytics setUserPropertyString:[AppsFlyerTracker sharedTracker].getAppsFlyerUID forName:@"appsflyer_id"]

需要将订阅中台后台提供的解密文件(apiKey.pem)添加进bundle中


本组件依赖最新版本的AFNetworking与1.0.2.13版本的OpenSSL-Universal库，已加入CocoaPods依赖文件，会自动安装这两个库


接入

通过CocoaPods接入，需在Podfile中加入以下命令

pod 'InAppPurchaseKit', :git => 'git@techgit.meitu.com:GPIG/ios-component.git', :tag => 'tag version'

tag 1.0.5前的版本均存在部分bug，请使用1.0.5及之后的版本


所有方法支持Swift调用，请在Bridging-Header文件中添加语句

import <InAppPurchaseKit.h>

具体代码使用

！！！本组件以InAppPurchaseKit作为核心类，在该类中提供了所有接口，只需调用需要的类方法即可


初始化配置
+ (BOOL)configureIAPKitWithApplicationIdentifier:(NSString *)applicationIdentifier
                                          apiKey:(NSString *)apiKey
                                           appId:(NSInteger)appId
                                   inAppLanguage:(NSString * _Nullable)inAppLanguage
                                      firebaseId:(NSString *)firebaseId
                                     appsflyerId:(NSString *)appsflyerId
                                             gid:(NSString *)gid;
必须尽早在AppDelegate的didFinishLaunchingWithOptions:方法中调用该方法，顺序为Firebase SDK与AppsFlyer SDK初始化完成后。
参数：

applicationIdentifier: 应用的Bundle ID
apiKey: 由订阅中台的后台为应用生成，请找后台同学获取
appId: 参考Meitu App Id

inAppLanguage: 多语言应用当前应用内语言码，如"en"，"pt"
firebaseId：Firebase为当前应用生成的Instance ID, 可通过[FIRAnalytics appInstanceID]获取
appsflyerId：AppsFlyer为当前应用生成的UID，可通过[AppsFlyerTracker sharedTracker].getAppsFlyerUID获取
gid: 美图GID，没有可传空字符串

！！！applicationIdentifier，apiKey，firebaseId与appsflyerId不能为空，传入空值将无法正常使用本组件
返回值：配置的结果，YES为配置成功，NO为配置失败，在配置失败的情况下无法正常使用本组件

更新配置
+ (void)updateInAppLanguage:(NSString * _Nullable)inAppLanguage
                 firebaseId:(NSString *)firebaseId
                appsflyerId:(NSString *)appsflyerId
                        gid:(NSString *)gid;
该方法可在以上参数更新时调用，进行实时更新值。

获取商品
+ (void)fetchProductsInfoWithProductIdentifiers:(NSSet<NSString *> *)productIdentifiers
                                     completion:(void (^)(RetrievedProducts * retrievedProducts))completion;
获取商品接口与StoreKit提供的方法使用方式基本一致，RetrievedProducts结构包含成功获取的商品Product数组，获取失败的商品SKU数组，以及InAppPurchaseError对象
Product数据结构详见飞书文档

购买/订阅商品

单项购买（消耗型/非消耗型商品）

+ (void)purchaseProductWithProductIdentifier:(NSString *)productIdentifier  
                                    quantity:(NSInteger)quantity
                                  completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;
参数：

productIdentifier: 商品SKU
quantity: 购买数量，非消耗型产品通常为1


订阅商品

1.获取Subscription Offers签名
+ (void)fetchSubscriptionOfferWithProductIdentifier:(NSString *)productIdentifier
                        subscriptionOfferIdentifier:(NSString *)subscriptionOfferIdentifier
                                         completion:(void (^)(PaymentDiscountOffer * _Nullable paymentDiscount, InAppPurchaseError * error))completion;
参数：

productIdentifier: 商品SKU
subscriptionOfferIdentifier: Subscription Offer折扣ID

2. 订阅
+ (void)subscribeProduct:(Product *)product
         paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
              completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;

+ (void)subscribeProductIdentifier:(NSString *)productIdentifier
                   paymentDiscount:(PaymentDiscountOffer * _Nullable)paymentDiscount
                        completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;
可通过传入获取到的Product实例或直接传入SKU进行订阅，如无需订阅Subscription Offer则paymentDiscount参数传空即可

恢复购买
+ (void)restorePurchaseWithCompletion:(nullable void (^)(BOOL isInSubscriptionPeriod, NSArray * validSubscriptions, NSArray * restoredPurchasedItems, InAppPurchaseError * restoredSubscriptionResult))completion;
该方法block中的参数，successisInSubscriptionPeriod为是否成功恢复订阅，validSubscriptions 为当前所有有效订阅的收据信息，restoredPurchasedItems为恢复的单项购买SKU，restoredSubscriptionResult为InAppPurchaseError实例

刷新收据信息
+ (void)refreshInAppPurchaseInfoWithCompletion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;
将沙盒中的收据发送给后台，由后台向苹果验证收据以获取最新的收据信息并返回给客户端。在无需与StoreKit发生任何交易但需要获取用户订阅最新信息时可用，如检查用户是否处于宽限期，旧版本数据迁移等。

获取详细单项购买信息
+ (BOOL)productUnlocked:(NSString *)productIdentifier;

+ (NSInteger)productQuantity:(NSString *)productIdentifier;

+ (NSArray *)purchasedItems;
向productUnlocked:方法传入需要查询的商品SKU，返回用户是否已购买该商品
向productQuantity:方法传入需要查询的商品SKU，返回用户已购买的对应可消耗型商品数量（仅限可消耗型商品）
purchasedItems 方法为NSString数组，内含当前所有有效的单项购买SKU

获取详细订阅信息

判断用户是否处于解锁订阅状态（订阅未过期或宽限期未过期）
+ (BOOL)isSubscriptionUnlockedUser;

判断用户是否处于宽限期
+ (BOOL)userInGracePeriod;

获取用户首次订阅时间
+ (NSDate * _Nullable)originalTransactionDate;

获取用户当前订阅（不包含宽限期）过期时间
+ (NSDate * _Nullable)currentSubscriptionExpiredDate;

获取用户当前宽限期过期时间
+ (NSDate * _Nullable)currentGracePeriodExpiredDate;

获取用户最新一笔订阅收据信息
LatestSubscriptionInfo数据结构详见飞书文档
+ (LatestSubscriptionInfo *)getLatestSubscriptionInfo;

添加/移除观察者
在订阅状态发生改变或组件内维护的单项购买信息发生改变时，组件会通知观察者状态发生变化。观察者需遵循InAppPurchaseObserver协议，具体如下：
@protocol InAppPurchaseObserver <NSObject>

- (void)iapUnlockedItemsUpdated:(NSArray<PurchasedProduct *> *)purchasedProducts;

- (void)subscriptionStateUpdated;

@optional

- (void)subscriptionReceiptInfoUpdated;

- (void)validSubscriptionsUpdated:(NSArray<LatestSubscriptionInfo *> *)validSubscriptions;

@end
观察者通过InAppPurchaseKit类提供的方法进行添加与移除：
+ (void)addInAppPurchaseObserver:(id<InAppPurchaseObserver>)observer;

+ (void)removeInAppPurchaseObserver:(id<InAppPurchaseObserver>)observer;

手动刷新用户订阅状态
从用户体验以及避免频繁读写的角度考虑，在订阅时间到期后，组件会在到期后的下一次启动刷新用户的订阅状态，而不是在过期时直接锁上订阅。如果需要精准判断用户的订阅在本次Session中是否已过期，可以调用以下方法：
+ (void)refreshInAppPurchaseState;
刷新订阅状态后进行判断

切换预发布环境
+ (void)changeToPreproduction:(BOOL)isPreHost;
该接口仅在DEBUG模式下生效，isPreHost 为YES时切换至预发布环境，为NO时切回测试环境。调用即生效，无需重启应用。

App Store促销处理

设置App Store促销回调
+ (void)setShouldAddStorePaymentBlock:(void (^)(Product * product, SKPayment * payment))completion;
请在组件初始化之后设置该回调，该回调将在用户点击App Store的促销并拉起应用后触发，product 参数为App Store促销商品的信息， payment参数为App Store已创建好的支付对象，请不要对该参数进行任何更改。

订阅App Store促销商品
+ (void)subscribeProductFromAppStorePromotion:(Product *)product payment:(SKPayment *)skPayment completion:(nullable void (^)(BOOL success, InAppPurchaseError * error))completion;
订阅促销商品时请使用该接口，product与payment传入ShouldAddStorePaymentBlock回调中的参数即可。

App Store退款处理
！！！以下接口仅可在Xcode 12以上使用
+ (void)setRevokeEntitlementsBlock:(void (^)(NSArray<NSString *> * productIdentifiers))completion;
当用户通过苹果退款成功/退出Family Share时，SDK会自动进行收据验证并清除对应退款的已购买/订阅商品，并在验证成功后调用该方法的回调，productIdentifiers参数为用户此次退款的SKU，可通过该参数设置UI信息。

多商品订阅
！！！以下接口支持应用内同时存在多个订阅商品的场景，如应用内同一时间只存在一个活跃订阅，可忽略。
以下接口所描述的有效订阅指未到订阅过期时间或未到宽限期过期时间

获取当前应用内所有有效的订阅信息
+ (NSArray<LatestSubscriptionInfo *> *)getCurrentValidSubscriptions;
该方法返回应用内所有当前未过期订阅的收据信息。

获取当前应用内所有订阅信息
+ (NSArray<LatestSubscriptionInfo *> *)getAllSubscriptions;
该方法返回应用内所有订阅的收据信息，包含未过期与过期订单。

手动刷新所有有效订阅信息
从用户体验以及避免频繁读写的角度考虑，在某个订阅时间到期后，组件会在到期后的下一次启动刷新有效订阅信息数组，而不是在过期时直接锁上该订阅。如果需要精准判断某个订阅在本次Session中是否已过期，可以调用以下方法：
+ (void)refreshValidSubscriptions;
刷新有效订阅信息数组后进行判断

查询订阅当前是否有效
在需要查看某个订阅当前是否处于已订阅状态时调用
+ (BOOL)isSubscriptionValid:(NSString *)productIdentifier;
传入指定商品ID至该方法，返回订阅当前是否生效。

当前有效订阅数组更新通知
在当前有效订阅数组中的元素发生变化时，组件会发送以下通知，回调参数为当前有效订阅信息的数组。如何添加观察者见上文。
- (void)validSubscriptionsUpdated:(NSArray<LatestSubscriptionInfo *> *)validSubscriptions;

错误码
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

//
//  AWCouponModel.h
//  PurchaseSDK
//
//  Created by yikunHuang on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWCouponModel : NSObject

///实验任务 ID
@property(nonatomic, assign) long taskID;
///实验组或测试组 ID
@property(nonatomic, strong) NSString *ABTestCode;
///券下发时间(unix 时间戳)
@property(nonatomic, assign) long distributeTime;
///券有效期， e.g:   3：表示有效期为3天
@property(nonatomic, assign) long validTerm;
///用户弹窗记录状态：unknown: 0, notMatch: 1, matched: 2 popupSuccess: 3
@property(nonatomic, assign) int userPopupStatus;


- (instancetype)initWithDictionary: (NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

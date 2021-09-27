//
//  AWUSubsBtn.h
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/24.
//

#import <UIKit/UIKit.h>
#import "AWSubscribeBtnModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AWSKUType) {
    AWSKUType_Year = 0,///年
    AWSKUType_Month = 1,// 月
    AWSKUType_Week = 2,// 周
};

@interface AWUISubsBtn : UIButton

@property(nonatomic, assign)AWSKUType skuType;
@property(nonatomic, strong)AWSubscribeBtnModel *model;

//- (void)setModel:(Product *)product;

@end

NS_ASSUME_NONNULL_END

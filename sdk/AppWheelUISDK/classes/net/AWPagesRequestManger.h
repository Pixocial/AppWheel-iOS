//
//  AWPagesRequestManger.h
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import <Foundation/Foundation.h>
#import "AWPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AWPagesRequestManger : NSObject

- (void)getPagesModelWithComplete:(void (^)(BOOL,
                                            NSArray<AWPageModel *> * _Nullable,
                                            NSError * _Nullable))complete;
@end

NS_ASSUME_NONNULL_END

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

- (void)getPagesModelWithPageId:(NSString *)pageId
                       complete:(void (^)(BOOL,AWPageModel * _Nullable, NSString * errorMsg))complete;
@end

NS_ASSUME_NONNULL_END

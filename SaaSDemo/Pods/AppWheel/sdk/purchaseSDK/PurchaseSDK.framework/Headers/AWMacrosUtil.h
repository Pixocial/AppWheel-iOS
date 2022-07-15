//
//  AWMacrosUtil.h
//  PurchaseSDK
//
//  Created by Yk Huang on 2021/8/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/// 主线程执行
static inline void asyn_main_safe(dispatch_block_t block){
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

#define IS_EMPTY_STRING(str) (str == nil || [str isEqual:[NSNull null]] || [str isEqualToString:@""])

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

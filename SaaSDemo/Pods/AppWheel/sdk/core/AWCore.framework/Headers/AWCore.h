//
//  AWCore.h
//  AWCore
//
//  Created by yikunHuang on 2023/1/17.
//

#import <Foundation/Foundation.h>

#if __has_include(<AWCore/AWCore.h>)
//! Project version number for AWCore.
FOUNDATION_EXPORT double AWCoreVersionNumber;

//! Project version string for AWCore.
FOUNDATION_EXPORT const unsigned char AWCoreVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AWCore/PublicHeader.h>
#import <AWCore/AWHttpManager.h>
#import <AWCore/AWNewApiManager.h>
#import <AWCore/AWNetConfig.h>
#import <AWCore/AWSSKeychain.h>
#import <AWCore/AWLogUtil.h>
#import <AWCore/AWCommonUtils.h>
#import <AWCore/AWMacrosUtil.h>
#import <AWCore/AWUserinfoManager.h>
#import <AWCore/UIDevice+IAPHardware.h>
#import <AWCore/NSString+IAPMD5.h>
#import <AWCore/AWError.h>

#else

#import "AWHttpManager.h"
#import "AWNewApiManager.h"
#import "AWNetConfig.h"
#import "AWSSKeychain.h"
#import "AWLogUtil.h"
#import "AWCommonUtils.h"
#import "AWUserInfoCache.h"
#import "AWMacrosUtil.h"
#import "UIDevice+IAPHardware.h"
#import "NSString+IAPMD5.h"
#import "AWError.h"
#import "AWUserinfoManager.h"

#endif

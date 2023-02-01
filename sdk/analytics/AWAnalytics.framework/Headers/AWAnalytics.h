//
//  AWAnalytics.h
//  AWAnalytics
//
//  Created by yikunHuang on 2023/1/28.
//

#import <Foundation/Foundation.h>

#if __has_include(<AWAnalytics/AWAnalytics.h>)
//! Project version number for AWAnalytics.
FOUNDATION_EXPORT double AWAnalyticsVersionNumber;

//! Project version string for AWAnalytics.
FOUNDATION_EXPORT const unsigned char AWAnalyticsVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AWAnalytics/PublicHeader.h>
#import <AWAnalytics/AWEventConstants.h>
#import <AWAnalytics/AWAnalyticsEvent.h>

#else

#import "AWEventConstants.h"
#import "AWAnalyticsEvent.h"


#endif

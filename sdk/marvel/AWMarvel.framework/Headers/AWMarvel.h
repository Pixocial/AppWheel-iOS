//
//  AWMarvel.h
//  AWMarvel
//
//  Created by yikunHuang on 2023/1/30.
//

#import <Foundation/Foundation.h>

#if __has_include(<AWAnalytics/AWAnalytics.h>)
//! Project version number for AWMarvel.
FOUNDATION_EXPORT double AWMarvelVersionNumber;

//! Project version string for AWMarvel.
FOUNDATION_EXPORT const unsigned char AWMarvelVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <AWMarvel/PublicHeader.h>
#import <AWMarvel/AWMarvelManager.h>


#else

#import "AWMarvelManager.h"


#endif

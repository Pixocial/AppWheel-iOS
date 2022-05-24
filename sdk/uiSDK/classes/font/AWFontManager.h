//
//  AWFontMananger.h
//  AWUI
//
//  Created by yikunHuang on 2022/4/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWFontManager : NSObject

+ (id)sharedInstance;

- (NSString *)getFontName;

@end

NS_ASSUME_NONNULL_END

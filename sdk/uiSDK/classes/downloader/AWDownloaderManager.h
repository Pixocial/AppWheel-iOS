//
//  AWDownloaderManger.h
//  AWUI
//
//  Created by yikunHuang on 2022/4/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AWDownloaderManager : NSObject

+ (id)sharedInstance;

- (NSString * _Nullable)getLocalCachePath:(NSString *)downloadUrl;

- (void)download:(NSString *)downloadUrl
      completion:(void (^ __nullable)(NSURL *savePath, NSError * _Nullable error))completion;


@end

NS_ASSUME_NONNULL_END

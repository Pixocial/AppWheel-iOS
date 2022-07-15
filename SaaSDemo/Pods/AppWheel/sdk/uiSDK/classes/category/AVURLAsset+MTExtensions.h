//
//  AVURLAsset+MTExtensions.h
//  MTMediaKit
//
//  Created by Zixuan on 2019/11/14.
//  Copyright © 2019 Meitu. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

/// 视频方向
struct MTVideoOrientation {
    CGFloat angle;
    BOOL flipVertically;
};
typedef struct CG_BOXABLE MTVideoOrientation MTVideoOrientation;

NS_ASSUME_NONNULL_BEGIN

@interface AVURLAsset (MTExtensions)

/// 视频方向
@property (nonatomic, assign, readonly) MTVideoOrientation mt_videoOrientation;
/// 尺寸大小
@property (nonatomic, assign, readonly) CGSize mt_videoSize;
/// 时长
@property (nonatomic, assign, readonly) NSInteger mt_videoDuration;
/// 封面图（首帧截图）
@property (nonatomic, strong, readonly) UIImage *mt_coverImage;

@end

NS_ASSUME_NONNULL_END

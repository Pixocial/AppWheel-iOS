//
//  AVURLAsset+MTExtensions.m
//  MTMediaKit
//
//  Created by Zixuan on 2019/11/14.
//  Copyright © 2019 Meitu. All rights reserved.
//

#import "AVURLAsset+MTExtensions.h"
//Framwork
#import <objc/runtime.h>
//Category
#import "AVURLAsset+MTExtensions.h"

/// 创建MTVideoOrientation
/// @param angle 角度
/// @param flipVertically 垂直镜像
CG_INLINE MTVideoOrientation MTVideoOrientationMake(CGFloat angle, BOOL flipVertically);

/// 内联方法定义
CG_INLINE MTVideoOrientation
MTVideoOrientationMake(CGFloat angle, BOOL flipVertically)
{
    MTVideoOrientation orientation;
    orientation.angle = angle;
    orientation.flipVertically = flipVertically;
    return orientation;
}

@implementation AVURLAsset (MTExtensions)

#pragma mark - Public
#pragma mark -
- (MTVideoOrientation)mt_videoOrientation {
    NSArray *videoTracks = [self tracksWithMediaType:AVMediaTypeVideo];
    if (![videoTracks count]) {
        return MTVideoOrientationMake(0, NO);
    }
    AVAssetTrack *videoTrack = [videoTracks firstObject];
    CGAffineTransform transform = [videoTrack preferredTransform];
    //case
    if (transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0) {
        return MTVideoOrientationMake(180, NO);
    } else if (transform.a == 0 && transform.b == 1.0 && transform.c == -1.0 && transform.d == 0) {
        return MTVideoOrientationMake(90, NO);
    } else if (transform.a == 0 && transform.b == -1.0 && transform.c == 1.0 && transform.d == 0) {
        return MTVideoOrientationMake(270, NO);
    } else if (transform.a == -1.0 && transform.b == 0 && transform.c == 0 && transform.d == 1.0) {
        return MTVideoOrientationMake(180, YES);
    } else if (transform.a == 1.0 && transform.b == 0 && transform.c == 0 && transform.d == -1.0) {
        return MTVideoOrientationMake(0, YES);
    } else if (transform.a == 0 && transform.b == 1.0 && transform.c == 1.0 && transform.d == 0) {
        return MTVideoOrientationMake(270, YES);
    } else if (transform.a == 0 && transform.b == -1.0 && transform.c == -1.0 && transform.d == 0) {
        return MTVideoOrientationMake(90, YES);
    }
    return MTVideoOrientationMake(0, NO);
}

- (CGSize)mt_videoSize {
    AVAssetTrack *track = [[self tracksWithMediaType:AVMediaTypeVideo] firstObject];
    CGSize naturalSize = [track naturalSize];
    //根据asset的方向调整输出尺寸
    CGSize size = CGSizeZero;
    if (self.mt_videoOrientation.angle == 90 || self.mt_videoOrientation.angle == 270) {
        size = CGSizeMake(naturalSize.height, naturalSize.width);
    } else {
        size = naturalSize;
    }
    return size;
}

- (NSInteger)mt_videoDuration {
    return CMTimeGetSeconds([self duration]) * 1000;
}

- (UIImage *)mt_coverImage {
    return nil;
//    return [MTMediaCommonHelper thumbnailForVideo:self atTime:CMTimeMakeWithSeconds(0, self.duration.timescale)];
}

#pragma mark - Private
#pragma mark -

#pragma mark - Getter & Setter
#pragma mark -

@end

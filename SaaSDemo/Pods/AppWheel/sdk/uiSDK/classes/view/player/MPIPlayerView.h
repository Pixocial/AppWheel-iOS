//
//  MPIPlayerView.h
//  BeautyPlusStory
//
//  Created by 吕思超 on 2019/10/25.
//  Copyright © 2019 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MPIPlayerViewDelegate;

typedef NS_ENUM(NSInteger, MPIPlayerState) {
    MPIPlayerStateUnknown,                /**< 初始化状态 */
    MPIPlayerStateLoading,                /**< 正在加载 URL */
    MPIPlayerStatePlaying,                /**< 正在播放 */
    MPIPlayerStatePaused,                 /**< 暂停 */
    MPIPlayerStateStopped,                /**< 停止 */
    MPIPlayerStateError                   /**< 错误 */
};

@interface MPIPlayerView : UIView

// 播放时为YES 暂停时为NO
@property (nonatomic, assign, readonly) BOOL isPlaying;
@property (nonatomic, assign, readonly) NSInteger duration;
@property (nonatomic, weak) id<MPIPlayerViewDelegate> delegate;
@property (nonatomic, strong, readonly, nullable) AVPlayerLayer *playerLayer;
@property (nonatomic) CMTime updateTimeFrequency; /**< 进度更新频率，默认1s一次(CMTimeMake(1,1))*/

// 设置播放URL
- (void)setURLWithString:(NSString *)URLStr complete:(void(^)(NSURL * _Nullable url))complete;
- (void)setURLPlayAndDown:(NSURL *)URL;
- (void)setURL:(NSString *)URL complete:(void(^)(NSURL * _Nullable url))complete;
- (void)setAsset:(AVURLAsset *)asset;
- (NSURL * _Nullable)getURL;

// 跳到xx秒播放视频
- (void)seekToTime:(CGFloat )time;
- (void)seekToTime:(CGFloat)time completionHandler:(void (^)(BOOL finished))completionHandler;

// 准备视频
- (void)prepareWithURL:(NSURL *)url;

// 播放
- (void)play;

// 暂停
- (void)pause;

// 停止播放
- (void)stop;

// 重新播放
- (void)replay;

// 设置播放倍速 0.5-2.0
- (void)setPlayerRate:(CGFloat )rate;

// 设置是否静音
- (BOOL)isMuted;
- (void)setMuted:(BOOL)isMuted;

// 获取当前播放的时间
- (CGFloat)getCurrentPlayTime;

// 获取视频的总时间长
- (CGFloat)getTotalPlayTime;

// 获取视频宽高比
- (CGFloat)getVideoScale:(NSURL *)URL;

// 获取网络视频的缩略图
- (UIImage *)getThumbnailImageFromVideoURL:(NSURL *)URL time:(NSTimeInterval )videoTime;

// 获取本地视频缩略图
- (UIImage *)getThumbnailImageFromFilePath:(NSString *)videoPath time:(NSTimeInterval )videoTime;

- (void)changePlayState:(MPIPlayerState)state;

- (void)changePlayerWithURL:(NSURL *)url;

- (void)downloadFile:(NSURL*)sourceURL
     completeHandler:(void(^)(NSError *error, NSURL *__nullable fileURL))completeHandler;

- (void)resetPlayerItemIfNecessary;
@end

@protocol MPIPlayerViewDelegate <NSObject>

@optional

// 所有的代理方法均已回到主线程 可直接刷新UI
// 播放器状态
- (void)videoPlayer:(MPIPlayerView *)playerView statusDidChanged:(MPIPlayerState)status;
// 播放完毕
- (void)videoPlayerDidReachEnd:(MPIPlayerView *)playerView;
// 加载失败
- (void)videoPlayer:(MPIPlayerView *)playerView didFailWithError:(NSError *)error;

// 当前播放时间
- (void)videoPlayer:(MPIPlayerView *)playerView timeDidChange:(CGFloat )time;
// duration 当前缓冲的长度
- (void)videoPlayer:(MPIPlayerView *)playerView loadedTimeRangeDidChange:(CGFloat )duration;

@end
NS_ASSUME_NONNULL_END

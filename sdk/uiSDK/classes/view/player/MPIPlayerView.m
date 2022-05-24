//
//  MPIPlayerView.m
//  BeautyPlusStory
//
//  Created by 吕思超 on 2019/10/25.
//  Copyright © 2019 meitu. All rights reserved.
//

#import "MPIPlayerView.h"
#import "AWDownloaderManager.h"
#import "AVURLAsset+MTExtensions.h"
#import <PurchaseSDK/AWMacrosUtil.h>

static const CGFloat TimeObserverInterval = 0.01;
static void *VideoPlayer_PlayerItemStatusContext = &VideoPlayer_PlayerItemStatusContext;
static void *VideoPlayer_PlayerItemPlaybackLikelyToKeepUp = &VideoPlayer_PlayerItemPlaybackLikelyToKeepUp;
static void *VideoPlayer_PlayerItemPlaybackBufferEmpty = &VideoPlayer_PlayerItemPlaybackBufferEmpty;
static void *VideoPlayer_PlayerItemLoadedTimeRangesContext = &VideoPlayer_PlayerItemLoadedTimeRangesContext;
NSString * const MPIVideoPlayerErrorDomain = @"VideoPlayerErrorDomain";

@interface MPIPlayerView()

// 播放时为YES 暂停时为NO
@property (nonatomic, assign) BOOL isPlaying;
// 播放速度
@property (nonatomic, assign) CGFloat rate;
// 静音开关
@property (nonatomic, assign) BOOL muted;

//@property (nonatomic, strong) id timeObserverToken;
// 播放属性
@property (nonatomic, strong) AVPlayer      *player;
@property (nonatomic, strong) AVPlayerItem  *item;
@property (nonatomic, strong) AVURLAsset    *urlAsset;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) NSInteger duration;

// 播放状态
@property (nonatomic, assign) MPIPlayerState playerStatus;

@property (nonatomic, strong) AWDownloaderManager *downloadManager;

@end

@implementation MPIPlayerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.updateTimeFrequency = CMTimeMake(1, 1);
    if (self.downloadManager == nil) {
        self.downloadManager = [AWDownloaderManager sharedInstance];
    }
    
    // 设置播放速度为1.0
    self.rate = 1.0;
    [self setupAudioSession];
}

- (void)setupAudioSession {
    // 设置音频模式
    NSError *categoryError = nil;
    //后台都可以播放音量
//    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&categoryError];
    //静音
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&categoryError];
    if (!success) {
        NSLog(@"Error setting audio session category: %@", categoryError);
    }
    NSError *activeError = nil;
    success = [[AVAudioSession sharedInstance] setActive:YES error:&activeError];
    if (!success) {
        NSLog(@"Error setting audio session active: %@", activeError);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.playerLayer) {
        self.playerLayer.frame = self.bounds;
    }
}

- (void)dealloc {
    [self resetPlayerItemIfNecessary];
}

// 跳到xx秒播放视频
- (void)seekToTime:(CGFloat)time {
    [self seekToTime:time completionHandler:nil];
}

- (void)seekToTime:(CGFloat)time completionHandler:(void (^)(BOOL finished))completionHandler {
    if (self.player) {
        [self.player.currentItem cancelPendingSeeks];
        [self.player.currentItem.asset cancelLoading];

        CMTime cmTime = CMTimeMakeWithSeconds(time, 1000);
        if (CMTIME_IS_INVALID(cmTime) || self.player.currentItem.status != AVPlayerStatusReadyToPlay) {
            if (completionHandler) {
                completionHandler(false);
            }
            return;
        }
        [self.player seekToTime:cmTime toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:completionHandler];
    }
}

// 设置播放URL
- (void)setURLWithString:(NSString *)URLStr complete:(void(^)(NSURL *_Nullable url))complete {
    if (IS_EMPTY_STRING(URLStr)) {
        if (complete) {
            complete(nil);
        }
        return;
    }
    [self setURL:[NSURL URLWithString:URLStr] complete:complete];
}

- (void)setURLPlayAndDown:(NSURL *)URL {
    if (URL == nil) {
        return;
    }
    [self resetPlayerItemIfNecessary];
    NSString *localUrl = [self.downloadManager getLocalCachePath:[URL absoluteString]];
    self.urlAsset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:localUrl]];
    self.duration = self.urlAsset.mt_videoDuration;
    [self creatPlayerWithAsset:self.urlAsset];
}

- (void)setURL:(NSString *)URL complete:(void(^)(NSURL * _Nullable url))complete {
    if (IS_EMPTY_STRING(URL)) {
        if (complete) {
            complete(nil);
        }
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.downloadManager download:URL completion:^(NSURL * _Nonnull savePath, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // 如果有正在播放的视频 先释放掉
                if (strongSelf.playerStatus == MPIPlayerStateLoading) {
                    [strongSelf resetPlayerItemIfNecessary];
                }
                
//                NSString *path = [[NSBundle mainBundle] pathForResource:@"onboarding_video_page1.mp4" ofType:nil];
//                NSURL *urr = [NSURL fileURLWithPath:path];
//
//                AVURLAsset *asset = [[AVURLAsset alloc]initWithURL:urr options:nil];
//                strongSelf.urlAsset = asset;
                
                strongSelf.urlAsset = [AVURLAsset assetWithURL:savePath];
                strongSelf.duration = strongSelf.urlAsset.mt_videoDuration;
                [strongSelf creatPlayerWithAsset:strongSelf.urlAsset];
                
                if (complete) {
                    complete(savePath);
                }
            });
        } else {
            if (complete) {
                complete(nil);
            }
        }
    }];
}

- (void)setAsset:(AVURLAsset *)asset {
    //如果有正在播放的视频 先释放掉
    [self resetPlayerItemIfNecessary];
    self.urlAsset = asset;
    self.duration = self.urlAsset.mt_videoDuration;
    [self creatPlayerWithAsset:asset];
}

- (NSURL * _Nullable)getURL {
    return self.urlAsset.URL;
}

// 切换播放器
- (void)changePlayerWithURL:(NSURL *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
        // 如果有正在播放的视频 先释放掉
        if (self.playerStatus == MPIPlayerStateLoading) {
            [self resetPlayerItemIfNecessary];
            self.urlAsset = [AVURLAsset assetWithURL:url];
            [self creatPlayerWithAsset:self.urlAsset];
        }
    });
}

// 创建播放器
- (void)creatPlayerWithAsset:(AVURLAsset *)urlAsset {
    //设置静音
    NSArray *audioTracks = [urlAsset tracksWithMediaType:AVMediaTypeAudio];

    // Mute all the audio tracks
    NSMutableArray *allAudioParams = [NSMutableArray array];
    for (AVAssetTrack *track in audioTracks) {
        AVMutableAudioMixInputParameters *audioInputParams =[AVMutableAudioMixInputParameters audioMixInputParameters];
        [audioInputParams setVolume:0.0 atTime:kCMTimeZero];
        [audioInputParams setTrackID:[track trackID]];
        [allAudioParams addObject:audioInputParams];
    }
    AVMutableAudioMix *audioZeroMix = [AVMutableAudioMix audioMix];
    [audioZeroMix setInputParameters:allAudioParams];
    
    
    // 初始化playerItem
    self.item = [AVPlayerItem playerItemWithAsset:urlAsset];
    [self.item setAudioMix:audioZeroMix]; // Mute the player item
    if (@available(iOS 10.0, *)) {
        self.item.preferredForwardBufferDuration = 10;
    } else {
        // Fallback on earlier versions
    }
    
    // 判断item是否创建成功，如果不成功则回调error出去
    if (!self.item) {
        if ([self.delegate respondsToSelector:@selector(videoPlayer:didFailWithError:)]) {
            NSError *error = [NSError errorWithDomain:MPIVideoPlayerErrorDomain
                                                 code:100
                                             userInfo:@{NSLocalizedDescriptionKey : @"创建 AVPlayerItem 失败"}];
            [self.delegate videoPlayer:self didFailWithError:error];
            [self changePlayState:MPIPlayerStateError];
        }
        return;
    }
    
    // 每次都重新创建Player，替换replaceCurrentItemWithPlayerItem:，该方法阻塞线程
    self.player = [AVPlayer playerWithPlayerItem:self.item];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.player setMuted:self.muted];
    
    // 此处为默认视频填充模式
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    // 使playerLayer光栅化(即位图化)，关闭了图层的blending。
    self.playerLayer.shouldRasterize = true;
    // 显式指定光栅化的范围，这样能保证视频的显示质量，不然容易出现视频质量显示不佳。
    self.playerLayer.rasterizationScale = UIScreen.mainScreen.scale;

    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    // 添加playerLayer到self.layer
    [self.layer insertSublayer:self.playerLayer atIndex:0];
    
    // 添加播放时间观察
//    [self addTimeObserver];
    // 添加观察
    [self preparePlayerItem:self.item];
}

- (void)preparePlayerItem:(AVPlayerItem *)playerItem {
    [self addPlayerItemObservers:playerItem];
}

- (void)addPlayerItemObservers:(AVPlayerItem *)playerItem {
    [playerItem addObserver:self
                 forKeyPath:@"status"
                    options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                    context:VideoPlayer_PlayerItemStatusContext];
    
    [playerItem addObserver:self
                 forKeyPath:@"playbackLikelyToKeepUp"
                    options:NSKeyValueObservingOptionNew
                    context:VideoPlayer_PlayerItemPlaybackLikelyToKeepUp];
    
    [playerItem addObserver:self
                 forKeyPath:@"playbackBufferEmpty"
                    options:NSKeyValueObservingOptionNew
                    context:VideoPlayer_PlayerItemPlaybackBufferEmpty];
    
    [playerItem addObserver:self
                 forKeyPath:@"loadedTimeRanges"
                    options:NSKeyValueObservingOptionNew
                    context:VideoPlayer_PlayerItemLoadedTimeRangesContext];
    
    // 播放完毕的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidPlayToEndTime:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
    // 耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
}

- (void)playerItemDidPlayToEndTime:(NSNotification *)notification {
    // 播放完毕的通知
    if (notification.object) {
        AVPlayerItem *item = (AVPlayerItem *) notification.object;
        if (item) {
            AVURLAsset *asset = (AVURLAsset *) item.asset;
            NSString *itemURLStr = asset == nil ? nil : asset.URL.absoluteString;
            NSString *urlStr = self.urlAsset == nil ? nil : self.urlAsset.URL.absoluteString;
            // 判断通知的对象与当前的对象是否是一样的url，则来判断是否需要回调出去
            if (!IS_EMPTY_STRING(itemURLStr) && !IS_EMPTY_STRING(urlStr) && [asset.URL.absoluteString isEqualToString:urlStr] && self.isPlaying) {
                if ([self.delegate respondsToSelector:@selector(videoPlayerDidReachEnd:)]) {
                    [self.delegate videoPlayerDidReachEnd:self];
                }
            }
        }
    }
}

// 耳机插入、拔出事件
 - (void)audioRouteChangeListenerCallback:(NSNotification*)notification {
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:{
            // 拔掉耳机继续播放
            if (self.isPlaying) {
                [self.player play];
            }
        }
            break;
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            break;
    }
}

// 播放时间观察
//- (void)addTimeObserver {
//    if (self.timeObserverToken || self.player == nil) {
//        return;
//    }
//
//    __weak typeof(self) weakSelf = self;
//    self.timeObserverToken = [self.player addPeriodicTimeObserverForInterval:self.updateTimeFrequency queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if ([strongSelf.delegate respondsToSelector:@selector(videoPlayer:timeDidChange:)]) {
//            [strongSelf.delegate videoPlayer:strongSelf timeDidChange:CMTimeGetSeconds(time)];
//        }
//    }];
//}

// 释放
- (void)resetPlayerItemIfNecessary {
    [self.player pause];
    // 移除时间观察者
//    if (self.timeObserverToken) {
//        if (self.player) {
//            [self.player removeTimeObserver:self.timeObserverToken];
//        }
//        self.timeObserverToken = nil;
//    }
    // 移除player属性观察者
    if (self.item) {
        [self.item cancelPendingSeeks];
        @try {
            [self.item removeObserver:self forKeyPath:@"status" context:VideoPlayer_PlayerItemStatusContext];
            [self.item removeObserver:self forKeyPath:@"loadedTimeRanges" context:VideoPlayer_PlayerItemLoadedTimeRangesContext];
            [self.item removeObserver:self forKeyPath:@"playbackBufferEmpty" context:VideoPlayer_PlayerItemPlaybackBufferEmpty];
            [self.item removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:VideoPlayer_PlayerItemPlaybackLikelyToKeepUp];
        } @catch (NSException *exception) {
            NSLog(@"MPIPlayerView - %@", exception.reason);
        }
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.item = nil;
    }
    if (self.player) {
        [self.player replaceCurrentItemWithPlayerItem:nil];
        self.player = nil;
    }
    if (self.urlAsset) {
        self.urlAsset = nil;
    }
    if (self.playerLayer) {
        [self.playerLayer removeFromSuperlayer];
        self.playerLayer = nil;
    }
}

// 准备
- (void)prepareWithURL:(NSURL *)url {
    if (!self.urlAsset) {
        self.urlAsset = [AVURLAsset assetWithURL:url];
        [self creatPlayerWithAsset:self.urlAsset];
    }
}

//播放
- (void)play {
    if (!self.player || self.playerStatus == MPIPlayerStateError) {
        [self setURL:self.urlAsset.URL complete:nil];
        return;
    }
    self.isPlaying = YES;
    self.player.rate = self.rate;
    [self.player play];
    [self changePlayState:MPIPlayerStatePlaying];
}

// 暂停
- (void)pause {
    if (!self.player) {
        return;
    }
    self.isPlaying = NO;
    [self.player pause];
    [self changePlayState:MPIPlayerStatePaused];
}

// 停止播放
- (void)stop {
    // 先改变状态，防止用户可能在等待下载的同时执行其他操作，导致音乐没办法停止而继续播放
    [self changePlayState:MPIPlayerStateStopped];
    
    if (!self.player) {
        return;
    }
    self.isPlaying = NO;
    [self.player pause];
    
    //item置为nil相关
    [self resetPlayerItemIfNecessary];
}

// 重新播放
- (void)replay {
    [self setAsset:self.urlAsset];
    [self play];
}

// 设置播放倍速 0.5-2.0
- (void)setPlayerRate:(CGFloat)rate {
    _rate = rate;
    if (self.player) {
        self.player.rate = rate;
    }
}

// 设置是否静音
- (void)setMuted:(BOOL)isMuted {
    _muted = isMuted;
    if (self.player) {
        [self.player setMuted:isMuted];
    }
}

// MARK: - Getter
- (BOOL)isMuted {
    return self.player.isMuted;
}

// 获取当前播放的时间
- (CGFloat )getCurrentPlayTime {
    if (self.player) {
        return CMTimeGetSeconds([self.player currentTime]);
    }
    return 0.0;
}

// 获取视频的总时间长
- (CGFloat)getTotalPlayTime {
    if (self.player) {
        CMTime duration = self.player.currentItem.asset.duration;
        return CMTimeGetSeconds(duration);
    }
    return 0.0;
}

// 获取视频宽高比
- (CGFloat)getVideoScale:(NSURL *)URL {
    if (!URL) {
        return 0.0;
    }
    // 获取视频尺寸
    AVURLAsset *asset = [AVURLAsset assetWithURL:URL];

    NSArray *array = asset.tracks;
    CGSize videoSize = CGSizeZero;
    for (AVAssetTrack *track in array) {
        if ([track.mediaType isEqualToString:AVMediaTypeVideo]) {
            videoSize = track.naturalSize;
        }
    }
    return videoSize.height / videoSize.width;
}

- (UIImage *)getThumbnailImageFromVideoURL:(NSURL *)URL time:(NSTimeInterval )videoTime {
    if (!URL) {
        return nil;
    }
    
    UIImage *shotImage;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:URL options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(videoTime, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    shotImage = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return shotImage;
}

- (UIImage *)getThumbnailImageFromFilePath:(NSString *)videoPath time:(NSTimeInterval )videoTime {
    if (!videoPath) {
        return nil;
    }
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[[NSURL alloc] initFileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = videoTime;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 600)
                                                    actualTime:NULL error:nil];
    
    if (!thumbnailImageRef) {
        return nil;
    }
    
    UIImage *thumbnailImage = [[UIImage alloc] initWithCGImage:thumbnailImageRef];
    
    CFRelease(thumbnailImageRef);
    
    return thumbnailImage;
}

#pragma mark - Observer Response
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *item = (AVPlayerItem *) object;
    if (item) {
        AVURLAsset *asset = (AVURLAsset *) item.asset;
        NSString *itemURLStr = asset == nil ? nil : asset.URL.absoluteString;
        NSString *urlStr = self.urlAsset == nil ? nil : self.urlAsset.URL.absoluteString;
        // 判断通知的对象与当前的对象是否是一样的url，则来判断是否需要回调出去
        if (IS_EMPTY_STRING(itemURLStr) || IS_EMPTY_STRING(urlStr) || ![asset.URL.absoluteString isEqualToString:urlStr]) {
            return;
        }
    }
    
    // player状态
    if (context == VideoPlayer_PlayerItemStatusContext) {
        AVPlayerStatus newStatus = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];
        AVPlayerStatus oldStatus = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        
        if (newStatus != oldStatus) {
            switch (newStatus) {
                case AVPlayerItemStatusUnknown:
                    NSLog(@"Video player Status Unknown");
                    [self changePlayState:MPIPlayerStateUnknown];
                    break;
                case AVPlayerItemStatusReadyToPlay:
                    
                    break;
                case AVPlayerStatusFailed:{
                    NSError *error = [NSError errorWithDomain:MPIVideoPlayerErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey : @"AVPlayer 状态是 AVPlayerItemStatusFailed"}];
                    if ([self.delegate respondsToSelector:@selector(videoPlayer:didFailWithError:)]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([self.delegate respondsToSelector:@selector(videoPlayer:didFailWithError:)]) {
                                [self.delegate videoPlayer:self didFailWithError:error];
                            }
                        });
                    }
                    [self changePlayState:MPIPlayerStateError];
                                        
                    AVURLAsset *asset = (AVURLAsset *) item.asset;
                    NSFileManager *fm = [NSFileManager defaultManager];
                    [fm removeItemAtPath:asset.URL.absoluteString error:nil];
                }
                    break;
            }
        }
    } else if (context == VideoPlayer_PlayerItemPlaybackBufferEmpty) {
        // 缓冲区
        BOOL oldValue = [change[NSKeyValueChangeOldKey] boolValue];
        BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
        if (oldValue == NO && newValue == YES) {
            //这里这么写是因为观察到会有old new都是0的情况
            [self changePlayState:MPIPlayerStateLoading];
        }
    } else if (context == VideoPlayer_PlayerItemPlaybackLikelyToKeepUp) {
        BOOL oldValue = [change[NSKeyValueChangeOldKey] boolValue];
        BOOL newValue = [change[NSKeyValueChangeNewKey] boolValue];
        if (oldValue == NO && newValue == YES && self.playerStatus != MPIPlayerStatePaused) { //这里这么写是因为观察到会有old new都是0的情况
            [self changePlayState:MPIPlayerStatePlaying];
        }
    } else if (context == VideoPlayer_PlayerItemLoadedTimeRangesContext) {
        if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
            if ([self.delegate respondsToSelector:@selector(videoPlayer:loadedTimeRangeDidChange:)]) {
                CGFloat loadedDuration = [self calcLoadedDuration];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self.delegate respondsToSelector:@selector(videoPlayer:loadedTimeRangeDidChange:)]) {
                        [self.delegate videoPlayer:self loadedTimeRangeDidChange:loadedDuration];
                    }
                });
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (CGFloat)calcLoadedDuration {
    CGFloat loadedDuration = 0.0;
    
    if (self.player && self.player.currentItem) {
        NSArray *loadedTimeRanges = self.player.currentItem.loadedTimeRanges;
        
        if (loadedTimeRanges && [loadedTimeRanges count]) {
            CMTimeRange timeRange = [[loadedTimeRanges firstObject] CMTimeRangeValue];
            CGFloat startSeconds = CMTimeGetSeconds(timeRange.start);
            CGFloat durationSeconds = CMTimeGetSeconds(timeRange.duration);
            
            loadedDuration = startSeconds + durationSeconds;
        }
    }
    return loadedDuration;
}

- (void)downloadFile:(NSURL*)sourceURL
     completeHandler:(void(^)(NSError *error, NSURL *fileURL))completeHandler {
    [self changePlayState:MPIPlayerStateLoading];
    if (!self.downloadManager) {
        self.downloadManager = [AWDownloaderManager sharedInstance];
    }
    
    [self.downloadManager download:[sourceURL absoluteString] completion:^(NSURL * _Nonnull savePath, NSError * _Nullable error) {
        if (error) {
            completeHandler(nil,nil);
            return;
        }
        completeHandler(nil, savePath);
    }];
}

- (void)changePlayState:(MPIPlayerState)state {
    self.playerStatus = state;
    if ([self.delegate respondsToSelector:@selector(videoPlayer:statusDidChanged:)]) {
        [self.delegate videoPlayer:self statusDidChanged:self.playerStatus];
    }
}

@end

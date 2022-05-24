//
//  AWPlayer.m
//  AWUI
//
//  Created by yikunHuang on 2022/4/27.
//

#import "AWPlayer.h"

@implementation AWPlayer

- (instancetype)init {
    if (self = [super init]) {
        [self addNotifications];
    }
    return self;
}

- (instancetype)initWithPlayerItem:(AVPlayerItem *)item {
    if (self = [super initWithPlayerItem:item]) {
        [self addNotifications];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

///添加通知
- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEndTimeNotification) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)playToEndTimeNotification {
    if ([self.delegate respondsToSelector:@selector(awPlayerPlayToEnd:)]) {
        [self.delegate awPlayerPlayToEnd:self];
    }
    if (_isLoopEnabled) {
        [self seekToTime:kCMTimeZero];
        [self play];
    }
}

- (void)willEnterForeground {
    [self play];
}

- (void)didEnterBackground {
    [self pause];
}

@end

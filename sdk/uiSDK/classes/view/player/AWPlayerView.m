//
//  AWPlayerView.m
//  AWUI
//
//  Created by yikunHuang on 2022/4/27.
//

#import "AWPlayerView.h"

@implementation AWPlayerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        AVPlayerLayer *layer = self.layer;
//        if (layer) {
//            [layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//            [layer setShouldRasterize:YES];
//            [layer setRasterizationScale:UIScreen.mainScreen.scale];
//        }
    }
    return self;
}

- (void)setPlayer:(AVPlayer *)player {
    _player = player;
    AVPlayerLayer *newPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [newPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [newPlayerLayer setShouldRasterize:YES];
    [newPlayerLayer setRasterizationScale:UIScreen.mainScreen.scale];
    [newPlayerLayer setFrame:[self.layer bounds]];
    [self.layer addSublayer:newPlayerLayer];
}
//
//- (AVPlayer *)getPlayer {
//    AVPlayerLayer *layer = self.layer;
//    return layer.player;
//}


@end

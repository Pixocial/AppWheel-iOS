//
//  AWPlayer.h
//  AWUI
//
//  Created by yikunHuang on 2022/4/27.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AWPlayer;
@protocol AWPlayerDelegate <NSObject>

- (void)awPlayerPlayToEnd:(AWPlayer *) player;

@end

@interface AWPlayer : AVPlayer

@property(nonatomic, assign) Boolean isLoopEnabled;

@property(nonatomic, strong) NSString *url;

@property(nonatomic, weak, nullable) id <AWPlayerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

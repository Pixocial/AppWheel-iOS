//
//  AWUFeatureCardsCell.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/25.
//  卡片的cell

#import "AWUIFeatureCardsCell.h"
#import "AWUIFeatureCellModel.h"
#import <SDWebImage/SDWebImage.h>
#import "NSString+AWCategory.h"
#import "AWPlayer.h"
#import "AWPlayerView.h"
#import "AWDownloaderManager.h"
#import <PurchaseSDK/AWMacrosUtil.h>
#import "AWGradientView.h"
#import "AWRGBUtil.h"

@interface AWUIFeatureCardsCell() <MPIPlayerViewDelegate>

@property(strong, nonatomic)UIImageView *iv;

@property(strong, nonatomic)NSOperationQueue *operationQueue;

@property(assign, nonatomic)Boolean isSetVideo;

@property(strong, nonatomic)AWGradientView *gradientView;

@end

@implementation AWUIFeatureCardsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)dealloc {
    [self.playerView stop];
}

#pragma mark - UI init
- (void)makeUI{
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.iv];
    [self addSubview:self.playerView];
    [self addSubview:self.gradientView];
    [self addSubview:self.label];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 8;
}

- (UIImageView *)iv {
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _iv.backgroundColor = UIColor.clearColor;
        //设置图片比例不变，但是是填充整个ImageView的，可能只有部分图片显示出来。
        _iv.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _iv;
}

- (MPIPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[MPIPlayerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _playerView.delegate = self;
    }
    return _playerView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frame.size.height - 20, self.frame.size.width - 20, 10)];
        _label.textColor = UIColor.whiteColor;
        _label.font = [UIFont systemFontOfSize:12];
        _label.numberOfLines = 0;
    }
    return _label;
}

- (AWGradientView *)gradientView {
    if (!_gradientView) {
        _gradientView = [[AWGradientView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
        
        _gradientView.startPoint = CGPointMake(0.5, 1.0);
        _gradientView.endPoint = CGPointMake(0.5, 0.0);
        _gradientView.colors = @[(__bridge id)[AWRGBUtil RGBWithR:0 g:0 b:0 a:0.5].CGColor,
                        (__bridge id)[AWRGBUtil RGBWithR:0 g:0 b:0 a:0].CGColor];
        _gradientView.locations = @[@0, @1];
    }
    return _gradientView;
}

#pragma mark - 填充数据
- (void)setModel:(AWUIFeatureCellModel *)model {
    _model = model;
    if (model) {
        self.label.text = model.featureName;
        [self setImage:model.featureImgUrl intoIV:self.iv];
        //todo 这边需要用新的字段
        if (!IS_EMPTY_STRING(model.featureVideoUrl)) {
            [self setToPlayer:model.featureVideoUrl];
        }
        //动态计算文字的高度，苦逼的iOS开发工程师啊，啥都要算，算个球
        CGFloat textHeight = [model.featureName heightWithFont:[UIFont systemFontOfSize:12] constrainedToWidth:self.frame.size.width - 20];
        CGFloat textMaxHeight = self.frame.size.height;
        CGFloat y = self.frame.size.height;
        if (textHeight > textMaxHeight) {
            textHeight = textMaxHeight;
        } else if (textHeight + 8 < textMaxHeight) {
            y = y - 8 - textHeight;
        }
        CGRect frame = self.label.frame;
        frame.size.height = textHeight;
        frame.origin.y = y;
        self.label.frame = frame;
    }
}

#pragma mark - 获取网络的图片
- (void)setImage:(NSString *)url intoIV:(UIImageView *)iv {
    if (url && url.length > 0) {
        [iv sd_setImageWithURL:[NSURL URLWithString:url]];
    }
}

- (void)setToPlayer:(NSString *)url {
    if (IS_EMPTY_STRING(url)) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.playerView setURL:url complete:^(NSURL * _Nullable url) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf.playerView setHidden:NO];
            [strongSelf.playerView play];
    }];
    
}

#pragma mark - 获取网络的图片
- (void)videoPlayerDidReachEnd:(MPIPlayerView *)playerView {
        dispatch_async(dispatch_get_main_queue(), ^{
            [playerView replay];
        });
}


@end

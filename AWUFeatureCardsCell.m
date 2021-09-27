//
//  AWUFeatureCardsCell.m
//  AppWheelUIKit
//
//  Created by Yk Huang on 2021/3/25.
//  卡片的cell

#import "AWUFeatureCardsCell.h"
#import "AWUImageViewUtil.h"

@interface AWUFeatureCardsCell()

@property(strong, nonatomic)UIImageView *iv;
@property(strong, nonatomic)UILabel *label;

@property(strong, nonatomic)NSOperationQueue *operationQueue;

@end

@implementation AWUFeatureCardsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

#pragma mark - UI init
- (void)makeUI{
    self.backgroundColor = UIColor.clearColor;
    [self addSubview:self.iv];
    [self addSubview:self.label];
}

- (UIImageView *)iv {
    if (!_iv) {
        _iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _iv.backgroundColor = UIColor.clearColor;
        _iv.layer.masksToBounds = YES;
        _iv.layer.cornerRadius = 6;
    }
    return _iv;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, self.frame.size.height - 20, self.frame.size.width - 20, 10)];
        _label.textColor = UIColor.whiteColor;
        _label.font = [UIFont systemFontOfSize:12];
    }
    return _label;
}

#pragma mark - 填充数据
- (void)setModel:(AWUFeatureModel *)model {
    if (model) {
        self.label.text = model.featureName;
        [self setImage:model.featureImgUrl intoIV:self.iv];
    }
}

#pragma mark - 获取网络的图片
- (void)setImage:(NSString *)url intoIV:(UIImageView *)iv{
    UIImage *img = [UIImage imageNamed:url];
    if (img) {
        // 如果是本地图片，可以获取得到的话就直接返回了
        iv.image = img;
        return;
    }
    //如果不是的话，就网络获取
    [[AWUImageViewUtil sharedInstance] setImgIntoImageView:iv withWebUrl:url];
}
@end

//
//  AWPaddingLabel.m
//  AWUI
//  带边距的文本
//  Created by yikunHuang on 2022/3/18.
//

#import "AWPaddingLabel.h"

@implementation AWPaddingLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setDefaultEdgeInsets];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setDefaultEdgeInsets];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDefaultEdgeInsets];
}

- (void)setDefaultEdgeInsets {
    self.edgeInsets = UIEdgeInsetsMake(1, 1, 1, 1);
}


//修改绘制文字的区域，edgeInsets增加bounds
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    /**
     调用父类该方法
     主义出阿茹的UIEdgeInsetsInsetRect(bounds, self.edgeInsets)，bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets修改绘制文字的bounds
    rect.origin.x  -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

//绘制文字
- (void)drawTextInRect:(CGRect)rect {
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect,self.edgeInsets)];
}

@end

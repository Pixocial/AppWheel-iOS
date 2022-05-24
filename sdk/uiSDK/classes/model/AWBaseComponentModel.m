//
//  BaseComponetModel.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/8.
//

#import "AWBaseComponentModel.h"
#import "NSString+AWCategory.h"
#import "AWUIDef.h"
#import "AWRGBUtil.h"


@implementation AWBaseComponentModel

- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self == [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        [self parse:dict];
    }
    return self;
}
- (void)parse: (NSDictionary *)dict {
    self.id = dict[@"id"];
    self.name = dict[@"name"];
    self.type = dict[@"type"];
    [self parseStyle: dict[@"style"]];
    [self parseAttr: dict[@"attr"]];
    self.text = dict[@"text"];
    [self parseComponents:dict[@"components"]];
    self.textList = dict[@"textList"];
}

- (void)parseComponents: (NSArray<NSDictionary *> *)array {
    NSMutableArray *modelArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in array) {
        AWBaseComponentModel *model = [[AWBaseComponentModel alloc] initWithDict:dict];
        [modelArray addObject:model];
    }
    if (modelArray.count > 0) {
        self.components = modelArray;
    }
}

- (void)parseStyle: (NSDictionary *)dict {
    if (dict) {
        self.style = [[AWStyleModel alloc]initWithDict:dict];
    }
}

- (void)parseAttr: (NSDictionary *)dict {
    if (dict) {
        self.attr = [[AWAttrModel alloc]initWithDict:dict];
    }
}

#pragma mark:- 在对应的控件上展示
- (void)setDataToLabel:(UILabel *)label {
    [self setLabelText:label];
    
    if (self.style && !IS_EMPTY_STRING(self.style.backgroundColor)) {
        label.backgroundColor = [AWRGBUtil RGBHex:self.style.backgroundColor];
    }
    [self setTextColor:label];
    //下划线
    if (!IS_EMPTY_STRING(self.text) &&
        !IS_EMPTY_STRING(self.style.textDecoration) && [self.style.textDecoration isEqualToString:@"underline"]) {
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
        label.attributedText = attribtStr;
    }
    
    UIFontDescriptorSymbolicTraits symbolicTraits = 0;
    //字号
    int fontSize = label.font.pointSize;
    if (self.style && !IS_EMPTY_STRING(self.style.fontSize)) {
        int fontSize = [self.style.fontSize extractNumber];
        label.font = [UIFont systemFontOfSize:fontSize];
    }
    //粗体
    if (!IS_EMPTY_STRING(self.style.fontWeight) && [self.style.fontWeight isEqualToString:@"bold"]) {
        symbolicTraits |= UIFontDescriptorTraitBold;
    }
    
    //斜体
    UIFontDescriptor *desc = [label.font fontDescriptor];
    if (!IS_EMPTY_STRING(self.style.fontStyle) && [self.style.fontStyle isEqualToString:@"italic"]) {
        symbolicTraits |= UIFontDescriptorTraitItalic;
        //系统的斜体对英文有作用，对中文没用，所以需要另外设置.设置中文倾斜
        if (!IS_EMPTY_STRING(self.text) && [self isChinese:self.text]) {
            CGAffineTransform matrix =CGAffineTransformMake(1, 0, tanf(7 * (CGFloat)M_PI / 180), 1, 0, 0);//设置反射。倾斜角度。
            desc = [ UIFontDescriptor fontDescriptorWithName :[UIFont systemFontOfSize:fontSize].fontName matrix :matrix];//取得系统字符并设置反射。
        }
    }
    
    UIFont *specialFont = [UIFont fontWithDescriptor:[desc fontDescriptorWithSymbolicTraits:symbolicTraits] size:fontSize];
    label.font = specialFont;
}

- (void)setTextAndTextColor:(UILabel *)label {
    [self setLabelText:label];
    [self setTextColor:label];
}

- (void)setLabelText:(UILabel *)label {
    if ([self.text isKindOfClass:[NSNumber class]]) {
        NSString *text = [NSString stringWithFormat:@"%@", self.text];
        label.text = text;
    }else if ([self.text isKindOfClass:[NSString class]]) {
        if (!IS_EMPTY_STRING(self.text)) {
            label.text = self.text;
        }
    }
}

- (void)setTextColor:(UILabel *)label {
    if (self.style && !IS_EMPTY_STRING(self.style.color)) {
        label.textColor = [AWRGBUtil RGBHex:self.style.color opacity:self.style.opacity];
    }
}

///是否包含中文
//- (BOOL)isChinese:(NSString *)str {
//    str = @"Privacy Policy中";
//    NSString *regEx = @".+[\u4e00-\u9fa5].+";// @"^[\u4e00-\u9fa5].*" - ^为匹配中文开始
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regEx];
//    BOOL isChinese = [predicate evaluateWithObject:str];
//    return isChinese;
//
//}
- (BOOL)isChinese:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4E00 <= ch  && ch <= 0x9FA5) {
            return YES;
        }
    }
    return NO;
}

@end

//
//  AWFontMananger.m
//  AWUI
//
//  Created by yikunHuang on 2022/4/28.
//

#import "AWFontManager.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "AWUBundleUtil.h"

@interface AWFontManager()

//目前只有一种字体，后续字体多的话，改成array
@property(nonatomic, strong)NSMutableArray<NSString *>*fontNames;

@end

@implementation AWFontManager


+ (id)sharedInstance {
    // 静态局部变量
    static AWFontManager *instance = nil;
    // 通过dispatch_once方式 确保instance在多线程环境下只被创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例
        instance = [[super allocWithZone:NULL] init];
        [instance registerLocalFont];

    });
    return instance;
}

// 重写方法【必不可少】
+ (id)allocWithZone:(struct _NSZone *)zone{
  return [self sharedInstance];
}

// 重写方法【必不可少】
- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

- (void)registerLocalFont {
    if (!_fontNames) {
        _fontNames = [[NSMutableArray alloc]init];
    }
    //本地资源文件
    NSArray *localRes = @[@"/fonts/inter_normal.ttf",@"/fonts/inter_bold.ttf"];
    for (NSString *url in localRes) {
        NSString *fontUrl = [AWUBundleUtil getResourcePath: url];
        [_fontNames addObject:[self registerFont:fontUrl]];
    }
}

- (NSString *)getFontName {
    return [_fontNames firstObject];
}


//返回字体名称
- (NSString *)registerFont:(NSString *)fontUrl {
    //字体名
    NSString *fontName;

    //下载字体
    NSData *dynamicFontData = [NSData dataWithContentsOfFile:fontUrl];
//    NSData *dynamicFontData = [NSData dataWithContentsOfURL:[NSURL URLWithString:fontUrl]];
    if (!dynamicFontData) {
        return nil;
    }
    CFErrorRef error;
    CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)dynamicFontData);
    CGFontRef font = CGFontCreateWithDataProvider(providerRef);
    if (CTFontManagerRegisterGraphicsFont(font, &error)) {
        fontName = (__bridge NSString *)CGFontCopyPostScriptName(font);
    } else {
//        kCTFontManagerErrorAlreadyRegistered        = 105
        //注册失败
        if ([(__bridge NSString *)CFErrorCopyDescription(error) containsString:@"105"] ) {
            //已经注册
            fontName = (__bridge NSString *)CGFontCopyPostScriptName(font);
        } else {
            //完全注册失败了
        }
    }
    CFRelease(font);
    CFRelease(providerRef);
    return fontName;
}

//是否注册了字体
- (BOOL)isFontDownloaded:(NSString *)fontName {
    UIFont *aFont = [UIFont fontWithName:fontName size:12.0];
    BOOL isDownloaded = (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame
                                 || [aFont.familyName compare:fontName] == NSOrderedSame));
    return isDownloaded;
}

@end

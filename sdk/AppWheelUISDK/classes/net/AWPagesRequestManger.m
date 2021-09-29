//
//  AWPagesRequestManger.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import "AWPagesRequestManger.h"
#import "AWHttpManager.h"
#import "AWCommonUtil.h"

@implementation AWPagesRequestManger

- (void)getPagesModelWithComplete:(void (^)(BOOL,
                                            NSArray<AWPageModel *> * _Nullable,
                                            NSError * _Nullable))complete {
    complete(YES,[self constructData], nil);
//    [[AWHttpManager sharedInstance] requestWithPath:@"subcenter/queryPages" extraParams:nil completion:^(NSInteger result, NSString * _Nonnull errorMsg, NSDictionary * _Nullable data) {
//        if (result != 1) {
//            complete(NO, nil, NSError )
//        }
//    }];
}

/// 测试的数据，后面替换成真的
- (NSArray<AWPageModel *> *)constructData {
    NSString *jsonString = @"{\"pageId\":999999,\"pageName\":\"vcus\",\"template\":1,\"status\":0,\"theme\":1,\"themeColor\":[\"#ffffff\",\"#000000\"],\"components\":[{\"type\":\"container\",\"name\":\"title\",\"description\":\"一级组件，主要展示页首banner等\",\"show\":true,\"level\":2,\"id\":\"t1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"mainTitle\",\"description\":\"banner的主标题，置于页首\",\"show\":true,\"level\":3,\"id\":\"t11\",\"text\":\"VCUS Pro\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"titleMessage\",\"description\":\"banner的描述性文字\",\"show\":true,\"level\":3,\"id\":\"t12\",\"text\":\"Развивайте свой бизнес естественным образом, используя VCUS Pro\",\"style\":{},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"scrolling\",\"description\":\"跑马灯组件\",\"show\":true,\"level\":2,\"id\":\"m3\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"scrollingItem\",\"name\":\"item1\",\"level\":2,\"id\":\"t21\",\"text\":\"第一个item的描述\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c\"},\"theme\":0,\"components\":[]},{\"type\":\"scrollingItem\",\"name\":\"itme2\",\"level\":2,\"id\":\"t21\",\"text\":\"第二个item的描述\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c\"},\"theme\":0,\"components\":[]},{\"type\":\"scrollingItem\",\"name\":\"item3\",\"level\":2,\"id\":\"t21\",\"text\":\"第3个item的描述\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://pic2.zhimg.com/v2-89f3357b919a3e448d73e0f78dda9a2a_r.jpg?source=1940ef5c\"},\"theme\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"skuOfferings\",\"description\":\"SKU按钮组\",\"level\":2,\"id\":\"s1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"skuBtn\",\"name\":\"day\",\"description\":\"SKU按钮组的第一个按钮\",\"level\":3,\"id\":\"s11\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"duration\",\"description\":\"SKU的duration\",\"level\":4,\"id\":\"s111\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"price\",\"description\":\"SKU的price\",\"level\":4,\"id\":\"s112\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"skuBtn\",\"name\":\"month\",\"description\":\"SKU按钮组的第二个按钮\",\"level\":3,\"id\":\"s12\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"duration\",\"name\":\"\",\"level\":4,\"id\":\"s121\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"price\",\"name\":\"\",\"level\":4,\"id\":\"s122\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"skuBtn\",\"name\":\"year\",\"description\":\"SKU按钮组的推荐按钮\",\"level\":3,\"id\":\"s13\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"popularHint\",\"description\":\"\",\"level\":4,\"id\":\"s131\",\"text\":\"Trending\",\"style\":{\"backgroundColor\":\"transparent\"},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"discountHint\",\"description\":\"\",\"level\":4,\"id\":\"s133\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"conversionHint\",\"description\":\"\",\"level\":4,\"id\":\"s134\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"freetrialHint\",\"description\":\"\",\"level\":4,\"id\":\"s135\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"price\",\"level\":4,\"id\":\"s137\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"duration\",\"level\":4,\"id\":\"s138\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]}]},{\"type\":\"container\",\"name\":\"actionButton\",\"description\":\"确认订阅按钮\",\"level\":2,\"id\":\"a1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"subHint\",\"description\":\"按钮文字\",\"level\":3,\"id\":\"a11\",\"text\":\"7 days free trail\",\"style\":{\"backgroundColor\":\"transparent\"},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"subMessage\",\"description\":\"副标题\",\"level\":3,\"id\":\"a12\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"termsColumn\",\"description\":\"条款协议\",\"level\":2,\"id\":\"c1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"termsColumn1\",\"level\":3,\"id\":\"c11\",\"text\":\"恢复购买\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"termsColumn2\",\"level\":3,\"id\":\"c12\",\"text\":\"用户协议\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"termsColumn3\",\"level\":3,\"id\":\"c13\",\"text\":\"隐私政策\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]}]}";
    NSDictionary *dict = [AWCommonUtil getDictFromjsonString:jsonString];
    AWPageModel *model = [[AWPageModel alloc]initWithDict:dict];
    return [[NSArray alloc]initWithObjects:model, nil];
}

@end

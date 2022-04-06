//
//  AWPagesRequestManger.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import "AWPagesRequestManger.h"
#import "AWUIHttpManager.h"
#import "AWCommonUtil.h"
#import "AWUIError.h"

@implementation AWPagesRequestManger

- (void)getPagesModelWithPageId:(NSString *)pageId
                       complete:(void (^)(BOOL, AWPageModel * _Nullable, NSString * _Nullable))complete {

    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:pageId forKey:@"pageId"];

    [[AWUIHttpManager sharedInstance] requestWithPath:@"/api/sub/pages" extraParams:params completion:^(NSInteger result, NSString * _Nonnull msg, NSDictionary * _Nullable data) {
        if (result != 0) {
            complete(NO, nil, msg);
            return;
        }
        if (!data || [data isKindOfClass:[NSNull class]]) {
            complete(NO, nil, AWUIErrorTypePageIdNotFoundMsg);
            return;
        }
        NSString *configString = data[@"pageConfig"];
        if (configString) {
            NSDictionary *dict = [AWCommonUtil getDictFromjsonString:configString];
            if (!dict) {
                complete(NO, nil, @"parse json error");
                return;
            }
            AWPageModel *model = [[AWPageModel alloc]initWithDict:dict];
            if (model) {
                complete(YES,model,nil);
                return;
            }
        }

        complete(NO, nil, AWUIErrorTypePageIdNotFoundMsg);

    }];
//    AWPageModel *model = [self constructData];
//    complete(YES,model,nil);
}


/// 测试的数据，后面替换成真的
- (AWPageModel *)constructData {
    NSString *jsonString = @"{\"pageId\":999999,\"pageName\":\"vcus\",\"template\":1,\"status\":0,\"theme\":1,\"style\":{\"backgroundColor\":\"#2344ff\",\"opacity\":1},\"themeColor\":[\"#ffffff\",\"#000000\"],\"components\":[{\"type\":\"container\",\"name\":\"title\",\"description\":\"一级组件，主要展示页首banner等\",\"show\":true,\"level\":2,\"path\":\"0\",\"id\":\"t1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"media\",\"name\":\"topBanner\",\"description\":\"title的背景图\",\"show\":true,\"level\":3,\"id\":\"t13\",\"text\":\"\",\"style\":{\"backgroundImage\":\"url('https://seopic.699pic.com/photo/50046/5562.jpg_wh1200.jpg')\"},\"attr\":{\"src\":\"https://seopic.699pic.com/photo/50046/5562.jpg_wh1200.jpg\"},\"theme\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"mainTitle\",\"description\":\"banner的主标题，置于页首\",\"show\":true,\"level\":3,\"path\":\"00\",\"id\":\"t11\",\"text\":\"cccccccccc\",\"style\":{\"color\":\"#152B71\",\"opacity\":\"0.5\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"titleMessage\",\"description\":\"banner的描述性文字\",\"show\":true,\"level\":3,\"path\":\"01\",\"id\":\"t12\",\"text\":\"Раз222есесте22222ственным образом, используя VCUS Pro\",\"style\":{\"color\":\"#B33C3C\",\"opacity\":\"1\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"scrolling\",\"description\":\"跑马灯组件\",\"show\":true,\"level\":2,\"id\":\"m3\",\"style\":{},\"attr\":{\"animation\":1},\"themeIndex\":0,\"components\":[{\"type\":\"scrollingItem\",\"name\":\"test1.jpeg\",\"level\":2,\"id\":\"t20\",\"text\":\"\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://media.appwheel.com/public/41/1bcfecc4a72c4d8cb5dcb8733fb862fb.jpeg\"},\"theme\":0,\"components\":[]},{\"type\":\"scrollingItem\",\"name\":\"test1.jpeg\",\"level\":2,\"id\":\"t21\",\"text\":\"\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://media.appwheel.com/public/41/00bdb80598814ee589ccc4f0a94cea66.jpeg\"},\"theme\":0,\"components\":[]},{\"type\":\"scrollingItem\",\"name\":\"test1.jpeg\",\"level\":2,\"id\":\"t22\",\"text\":\"\",\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{\"src\":\"https://media.appwheel.com/public/41/c06ab7c6ea154ff9ae155cc927cc9b08.jpeg\"},\"theme\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"skuOfferings\",\"description\":\"SKU按钮组，该层级包含了compare信息\",\"level\":2,\"id\":\"s1\",\"style\":{\"color\":\"#9E2020\",\"opacity\":1},\"attr\":{\"compare\":\"year\",\"appId\":329206600},\"themeIndex\":0,\"components\":[{\"type\":\"skuBtn\",\"name\":\"day\",\"description\":\"SKU按钮组的第一个按钮\",\"level\":3,\"id\":\"s11\",\"text\":\"\",\"style\":{},\"attr\":{\"skuId\":\"fasfafaf\",\"skuName\":\"\",\"available\":true},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"duration\",\"description\":\"SKU的duration，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s111\",\"text\":\"1m\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"price\",\"description\":\"SKU的price，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s112\",\"text\":\"$22\",\"style\":{},\"attr\":{\"value\":22,\"comparePrice\":\"$267.67 / year\"},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"currency\",\"description\":\"sku的货币，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s113\",\"text\":\"USD\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge1\",\"description\":\"原popularHint，在vcus模板中，位置是选中sku时左上角的宣传文字标记\",\"level\":4,\"id\":\"s114\",\"text\":\"Trending\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge2\",\"description\":\"原discountHint,在vcus模板中，位置是选中sku时右上角的优惠换算标记\",\"level\":4,\"id\":\"s115\",\"text\":\"1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"actionButton\",\"description\":\"选中该SKU时，Action Button所展示的文字\",\"level\":4,\"id\":\"s116\",\"text\":\"\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"skuBtn\",\"name\":\"month\",\"description\":\"SKU按钮组的第二个按钮\",\"level\":3,\"id\":\"s12\",\"text\":\"\",\"style\":{},\"attr\":{\"skuId\":\"fasfafaf\",\"skuName\":\"\",\"available\":false},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"duration\",\"description\":\"SKU的duration，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s121\",\"text\":\"1m\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"price\",\"description\":\"SKU的price，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s122\",\"text\":\"$22\",\"style\":{},\"attr\":{\"value\":22,\"comparePrice\":\"$267.67 / year\"},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"currency\",\"description\":\"sku的货币，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s123\",\"text\":\"USD\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge1\",\"description\":\"原popularHint，在vcus模板中，位置是选中sku时左上角的宣传文字标记\",\"level\":4,\"id\":\"s124\",\"text\":\"Trending\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge2\",\"description\":\"原discountHint,在vcus模板中，位置是选中sku时右上角的优惠换算标记\",\"level\":4,\"id\":\"s125\",\"text\":\"Save 67%\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"actionButton\",\"description\":\"选中该SKU时，Action Button所展示的文字\",\"level\":4,\"id\":\"s126\",\"text\":\"Subscribe Now\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"skuBtn\",\"name\":\"year\",\"description\":\"SKU按钮组的第三个按钮,默认展示为推荐按钮\",\"level\":3,\"id\":\"s13\",\"text\":\"\",\"style\":{},\"attr\":{\"skuId\":\"fasfafaf\",\"skuName\":\"\",\"available\":true},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"duration\",\"description\":\"SKU的duration，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s131\",\"text\":\"1m\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"price\",\"description\":\"SKU的price，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s132\",\"text\":\"$22\",\"style\":{},\"attr\":{\"value\":22,\"comparePrice\":\"$267.67 / year\"},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"currency\",\"description\":\"sku的货币，根据SKU而定，用户不可编辑\",\"level\":4,\"id\":\"s133\",\"text\":\"USD\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge1\",\"description\":\"原popularHint，在vcus模板中，位置是选中sku时左上角的宣传文字标记\",\"level\":4,\"id\":\"s134\",\"text\":\"Trending\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"badge2\",\"description\":\"原discountHint,在vcus模板中，位置是选中sku时右上角的优惠换算标记\",\"level\":4,\"id\":\"s135\",\"text\":\"Save 67%\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"actionButton\",\"description\":\"选中该SKU时，Action Button所展示的文字\",\"level\":4,\"id\":\"s136\",\"text\":\"Subscribe Now\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]}]},{\"type\":\"container\",\"name\":\"actionButton\",\"description\":\"确认订阅按钮\",\"level\":2,\"id\":\"a1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"subHint\",\"description\":\"按钮文字\",\"level\":3,\"id\":\"a11\",\"text\":\"7 days free trail\",\"style\":{\"backgroundColor\":\"transparent\"},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"subMessage\",\"description\":\"副标题\",\"level\":3,\"id\":\"a12\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]}]},{\"type\":\"container\",\"name\":\"termsColumn\",\"description\":\"条款协议\",\"level\":2,\"id\":\"c1\",\"style\":{\"color\":\"#D21C1C\",\"opacity\":\"1\"},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"text\",\"name\":\"restore\",\"level\":3,\"id\":\"c11\",\"text\":\"Restore Purchases\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"protocol\",\"level\":3,\"id\":\"c12\",\"text\":\"Term of Service\",\"style\":{},\"attr\":{\"herf\":\"www.baidu.com\"},\"themeIndex\":0,\"components\":[]},{\"type\":\"text\",\"name\":\"privacy\",\"level\":3,\"id\":\"c13\",\"text\":\"\",\"style\":{},\"attr\":{\"herf\":\"www.baidu.com\"},\"themeIndex\":0,\"components\":[]}]}]}";
    


    NSDictionary *dict = [AWCommonUtil getDictFromjsonString:jsonString];
    AWPageModel *model = [[AWPageModel alloc]initWithDict:dict];
    return model;
}

@end

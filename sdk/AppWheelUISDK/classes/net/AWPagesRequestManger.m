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
    NSString *jsonString = @"{\"pageId\":999999,\"pageName\":\"foo\",\"template\":1,\"status\":0,\"theme\":1,\"themeColor\":[\"#ffffff\",\"#000000\"],\"components\":[{\"type\":\"title\",\"name\":\"\",\"level\":1,\"id\":\"t1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"mainTitle\",\"name\":\"\",\"level\":2,\"id\":\"t11\",\"text\":[\"这是一段主标题\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"titleMessage\",\"name\":\"\",\"level\":1,\"id\":\"t12\",\"text\":[\"这是一段标题信息\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"backgroundText\",\"level\":1,\"name\":\"\",\"id\":\"t2\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"textTitle\",\"name\":\"\",\"level\":2,\"id\":\"t21\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"textMessage\",\"name\":\"\",\"level\":2,\"id\":\"t22\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"media\",\"name\":\"\",\"level\":1,\"id\":\"m1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"topBanner\",\"name\":\"\",\"level\":2,\"id\":\"m21\",\"text\":[],\"style\":{},\"attr\":{\"src\":\"\"},\"theme\":0,\"components\":[]},{\"type\":\"background\",\"name\":\"\",\"level\":1,\"id\":\"m22\",\"text\":[],\"style\":{},\"attr\":{\"src\":\"\"},\"theme\":0,\"components\":[]},{\"type\":\"scrollingBackground\",\"name\":\"\",\"level\":1,\"id\":\"m23\",\"text\":[],\"style\":{},\"attr\":{\"src\":[\"\"]},\"theme\":0,\"components\":[]},{\"type\":\"scrollingTextTitle\",\"name\":\"\",\"level\":1,\"id\":\"m24\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"scrollingTextMessage\",\"name\":\"\",\"level\":1,\"id\":\"m25\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"sku\",\"name\":\"\",\"level\":1,\"id\":\"s1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"popularHint\",\"name\":\"\",\"level\":2,\"id\":\"s11\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"duration\",\"name\":\"\",\"level\":2,\"id\":\"t22\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"price\",\"name\":\"\",\"level\":2,\"id\":\"t23\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"discountHint\",\"name\":\"\",\"level\":2,\"id\":\"t24\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"conversionHint\",\"name\":\"\",\"level\":2,\"id\":\"t25\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"freeTrialHint\",\"name\":\"\",\"level\":2,\"id\":\"t26\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"16px\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"actionButton\",\"name\":\"\",\"level\":1,\"id\":\"a1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"subHint\",\"name\":\"\",\"level\":2,\"id\":\"a11\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"subMessage\",\"name\":\"\",\"level\":2,\"id\":\"a12\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{},\"theme\":0,\"components\":[]},{\"type\":\"bg\",\"name\":\"\",\"level\":2,\"id\":\"a13\",\"text\":[\"\"],\"style\":{\"backgroundColor\":\"#fff\"},\"attr\":{},\"theme\":0,\"components\":[]}]},{\"type\":\"termsColumn\",\"name\":\"\",\"level\":1,\"id\":\"c1\",\"style\":{},\"attr\":{},\"themeIndex\":0,\"components\":[{\"type\":\"subHint\",\"name\":\"\",\"level\":2,\"id\":\"c11\",\"text\":[\"\"],\"style\":{\"color\":\"#fff\",\"fontSize\":\"48px\"},\"attr\":{\"url\":[\"\"]},\"theme\":0,\"components\":[]}]}]}"
    ;
    NSDictionary *dict = [AWCommonUtil getDictFromjsonString:jsonString];
    AWPageModel *model = [[AWPageModel alloc]initWithDict:dict];
    return [[NSArray alloc]initWithObjects:model, nil];
}

@end

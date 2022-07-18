//
//  AWPagesRequestManger.m
//  AppWheel
//
//  Created by yikunHuang on 2021/9/9.
//

#import "AWPagesRequestManger.h"
#import "AWUIHttpManager.h"
#import "AWCommonUtils.h"
#import "AWUIError.h"
#import <PurchaseSDK/AWNewApiManager.h>

@implementation AWPagesRequestManger

- (void)getPagesModelWithPageId:(NSString *)linkUrl
                       complete:(void (^)(BOOL, AWPageModel * _Nullable, NSString * _Nullable))complete {

    NSString *pageId = [self getPageIdFromUrl:linkUrl complete:complete];
    if (!pageId) {
        return;
    }
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    [params setObject:pageId forKey:@"pageId"];

    [[AWNewApiManager sharedInstance] postWithPath:@"/v1/subpage" extraParams:params completion:^(NSInteger result, NSString * _Nonnull msg, NSDictionary * _Nullable data) {
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
            NSDictionary *dict = [AWCommonUtils getDictFromjsonString:configString];
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
    
}

///解析url中的pageId
- (NSString *)getPageIdFromUrl:(NSString *)url
                complete:(void (^)(BOOL, AWPageModel * _Nullable, NSString * _Nullable))complete{
    ///{{host}}/paywall?pageId=3e7d80fc3b364c4fbf04e981f587be23&allowPay=false
    NSArray *array = [url componentsSeparatedByString:@"pageId="];
    if (!array || array.count <2) {
        complete(NO,nil,AWUIErrorTypePageIdNotFoundMsg);
        return nil;
    }

    //得到"pageId="的右侧的字符
    NSString *rightStr = array[1];
    if (!rightStr) {
        complete(NO,nil,AWUIErrorTypePageIdNotFoundMsg);
        return nil;
    }
        
    NSArray * rightArray = [rightStr componentsSeparatedByString:@"&"];
    NSString *pageId = [rightArray firstObject];
    return pageId;
}

@end

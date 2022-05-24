//
//  AWDownloaderManger.m
//  AWUI
//
//  Created by yikunHuang on 2022/4/27.
//

#import "AWDownloaderManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+AWMD5.h"
#import "AWUIHttpManager.h"

NSString *const kDownloadDefaultKey = @"kDownloadDefaultKey";

@interface AWDownloaderManager()

@property(nonatomic, strong)NSUserDefaults *downloadUserDefault;

@end

@implementation AWDownloaderManager


+ (id)sharedInstance {
    // 静态局部变量
    static AWDownloaderManager *instance = nil;
    // 通过dispatch_once方式 确保instance在多线程环境下只被创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建实例
        instance = [[super allocWithZone:NULL] init];
        instance.downloadUserDefault = [[NSUserDefaults alloc] initWithSuiteName:kDownloadDefaultKey];

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

- (NSString * _Nullable)getLocalCachePath:(NSString *)downloadUrl {
    NSString *md5Url = downloadUrl.MD5;
    NSString *localFileName = [_downloadUserDefault stringForKey:md5Url];
    if (localFileName) {
        //需要拼凑一下实时的路径
        NSString *localPath = [NSString stringWithFormat:@"%@/%@", [self getCacheDir], localFileName];
        return localPath;
    }
    return nil;
}

- (void)download:(NSString *)downloadUrl
      completion:(void (^ __nullable)(NSURL *savePath, NSError * _Nullable error))completion {
    NSString *md5Url = downloadUrl.MD5;
    //判断本地是否已经下载过了
    NSString *localFileName = [_downloadUserDefault stringForKey:md5Url];
    if (localFileName) {
        //需要拼凑一下实时的路径
        NSString *localPath = [NSString stringWithFormat:@"%@/%@", [self getCacheDir], localFileName];
        
        completion([NSURL fileURLWithPath:localPath],nil);
        //下载过就不用下载了
        return;
    }
    //保存到磁盘的位置
    NSURL *savaPathURL = [self getCacheFileURL:downloadUrl];
    __weak typeof(self) weakSelf = self;
    [[AWUIHttpManager sharedInstance]download:downloadUrl savePath:savaPathURL completion:^(NSURL * _Nonnull path, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.downloadUserDefault setValue:[strongSelf getCacheFileName:downloadUrl] forKey:md5Url];
        completion(path,error);
    }];
}



- (NSURL *)getCacheFileURL:(NSString *)downloadUrl {
    NSString *fileName = [self getCacheFileName:downloadUrl];

    NSString *downDir = [self getCacheDir];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:downDir]) {
        // 不存在 走创建
        if (![fm createDirectoryAtPath:downDir withIntermediateDirectories:YES attributes:nil error:nil]) {
            // 创建不成功
            return nil;
        }
    } else {
        BOOL isDir;
        [fm fileExistsAtPath:downDir isDirectory:&isDir];
        if (!isDir) {
            // 存在 但不是目录 则删掉重新创建
            [fm removeItemAtPath:downDir error:nil];
            if (![fm createDirectoryAtPath:downDir withIntermediateDirectories:YES attributes:nil error:nil]) {
                return nil;
            }
        }
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", downDir, fileName];
    return [NSURL fileURLWithPath:filePath];
}

//获取本地缓存的的目录
- (NSString *) getCacheDir {
    //这个玩意儿每次启动都是不一样的值
    NSString *cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *downloadDir = [NSString stringWithFormat:@"%@/MediaCache", cachesDir];
    return downloadDir;
}

- (NSString *) getCacheFileName:(NSString *)downloadUrl {
    NSArray *urlStrArray = [downloadUrl componentsSeparatedByString:@"/"];
    NSString *fileNameStr = urlStrArray.lastObject;
    NSArray *fileNameArray = [fileNameStr componentsSeparatedByString:@"."];
    NSArray *suffixStr = fileNameArray.lastObject;
    //MD5+complete+fileName
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",downloadUrl.MD5,suffixStr];
    return fileName;
}

@end

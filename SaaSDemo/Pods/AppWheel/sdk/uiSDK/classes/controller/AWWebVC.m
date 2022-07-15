//
//  AWWebVC.m
//  AWUI
//
//  Created by yikunHuang on 2021/10/21.
//

#import "AWWebVC.h"
#import "WebKit/WebKit.h"
#import "AWUBundleUtil.h"
#import "Masonry.h"
#import "AWUIDef.h"

@interface AWWebVC ()

@property(nonatomic, strong) UIButton *closeBtn;
@property(nonatomic, strong) WKWebView *webView;

@end

@implementation AWWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWebView];
    [self makeUI];
}

- (void)initWebView {
    // 添加WebView
    WKWebView *webView = [[WKWebView alloc] init];
    _webView = webView;
    [self.view addSubview:webView];
    
    // 加载网页
    if (!self.url) {
        return;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [webView loadRequest:request];
    
    // KVO监听属性改变
    /*
     KVO使用:
        addObserver：观察者
        forKeyPath：观察webview哪个属性
        options：NSKeyValueObservingOptionNew观察新值改变
     注意点：对象销毁前 一定要记得移除 -dealloc
     */
//    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
//    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
//    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
//
//    // 进度条
//    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark:- UI
- (void)makeUI {
    int closeBtnTop = IS_IPHONE_X_SERIES ? 52 : 34;
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(24);
        make.top.mas_equalTo(self.view).offset(closeBtnTop);
        make.left.mas_equalTo(self.view).offset(16);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.view);
    }];
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_closeBtn setImage:[UIImage imageNamed: [AWUBundleUtil getResourcePath: @"/ic_all_wrong_black.png"]] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_closeBtn];
    }
    return _closeBtn;
}

#pragma mark:- action
- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - KVO
// 只要观察者有新值改变就会调用
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    self.backItem.enabled = self.webView.canGoBack;
//    self.forwardItem.enabled = self.webView.canGoForward;
//    self.title = self.webView.title;
//    self.progressView.progress = self.webView.estimatedProgress;
//    self.progressView.hidden = self.webView.estimatedProgress>=1;
//}
//
//- (void)dealloc {
//    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
//    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
//    [self.webView removeObserver:self forKeyPath:@"title"];
//    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
//}
//
//#pragma mark - 按钮的点击事件
//- (IBAction)goBack:(id)sender { // 回退
//    [self.webView goBack];
//}
//
//- (IBAction)goForward:(id)sender {  // 前进
//    [self.webView goForward];
//}
//
//- (IBAction)reload:(id)sender { //刷新
//    [self.webView reload];
//}


@end

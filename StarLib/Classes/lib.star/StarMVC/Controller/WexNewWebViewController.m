//
//  PythiaWebViewModel.m
//  Pythia
//
//  Created by 星星 on 2017/4/13.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexNewWebViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WexNewWebViewController () <UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) NJKWebViewProgressView* webViewProgressView;
@property (nonatomic, strong) NJKWebViewProgress* webViewProgressProxy;

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, assign, getter=isLoadCompleted) BOOL loadCompleted;
@end

@implementation WexNewWebViewController

#pragma mark -

+ (instancetype)webvcWithURLString:(NSString *)URLString {
    WexNewWebViewController *vc = [[WexNewWebViewController alloc] init];
    vc.URLString = URLString;
    return vc;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _autoTitle = true;
        _scalesPageToFit = false;
        
        _javascriptObservers = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc {
    [self.webView stopLoading];
    self.webView.delegate = nil;
    self.webView = nil;
}



#pragma mark - 页面构造

- (void)wex_loadNavigationBar {
    [super wex_loadNavigationBar];
    [self setNavBarLeftSecondButtonTitle:@"关闭"];
    self.navBar.leftSecondButton.hidden = true;
    
}

- (void)wex_loadViews {
    [super wex_loadViews];
    
    // 进度条
    self.webViewProgressProxy = [[NJKWebViewProgress alloc] init];
    self.webViewProgressProxy.webViewProxyDelegate = self;
    self.webViewProgressProxy.progressDelegate = self;
    
    UIWebView *webView = [[UIWebView alloc] init];
    self.webView = webView;
    [self.view addSubview:self.webView];
    self.webView.delegate = self.webViewProgressProxy;
    // 解决iOS9上webView有黑边的问题，原因不明
    // http://stackoverflow.com/questions/21420137/black-line-appearing-at-bottom-of-uiwebview-how-to-remove
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scalesPageToFit = self.scalesPageToFit;
    
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.webViewProgressView];
    self.webViewProgressView.progressBarView.backgroundColor = rgba(255,32,32,1);
    
}

- (void)wex_layoutConstraints {
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.navBar.mas_bottom);
    }];
    [self.webViewProgressView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.webView);
        make.height.equalTo(2);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // HTMLString
    if (self.HTMLString){
        NSURL *URL = [NSURL URLWithString:self.URLString];
        [self.webView loadHTMLString:self.HTMLString baseURL:URL];
    }
    // Data
    else if (self.data){
        NSURL *URL = [NSURL URLWithString:self.URLString];
        [self.webView loadData:self.data MIMEType:self.MIMEType textEncodingName:@"UTF-8" baseURL:URL];
    }
    // URL
    else if (self.URLString && !self.HTMLString && !self.data) {
        NSURL *URL = [NSURL URLWithString:self.URLString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
    }
    
}





#pragma mark - NavBar按钮点击

- (void)wex_navBarLeftButtonClicked:(id)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        self.navBar.leftSecondButton.hidden = false;
    }
    else {
        [super wex_navBarLeftButtonClicked:sender];
    }
}

- (void)wex_navBarLeftSecondButtonClicked:(id)sender {
    [self wex_navBarLeftButtonClicked:sender];
}



#pragma mark - NJKWebViewProgressDelegate

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [self.webViewProgressView setProgress:progress animated:YES];
}


#pragma mark - WebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    LogInfo(@"WebView准备加载: %s %@",__FUNCTION__, request);
    return true;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    LogInfo(@"WebView开始加载: %s %@",__FUNCTION__, webView.request);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    LogInfo(@"WebView加载完毕: %s %@",__FUNCTION__, webView.request);
    if (self.isAutoTitle) {
        NSString *title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
    [self.webViewProgressView setProgress:1 animated:YES];
    if (!self.isLoadCompleted) {
        self.loadCompleted = true;
        [self delayMount:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    LogError(@"WebView加载失败: %s %@", __FUNCTION__, error);
}




- (void)delayMount:(UIWebView *)webView {
    
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
        self.loadCompleted = true;
        [self mountJavaScriptAtWebView:webView];
    }
    else {
        self.loadCompleted = false;
        StarWeakSelf
        __weak UIWebView *weakWebView = webView;
        dispatch_delay(1.5, ^{
            [weakSelf delayMount:weakWebView];
        });
    }
}

- (void)mountJavaScriptAtWebView:(UIWebView *)webView {
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context.exceptionHandler = ^void(JSContext *context, JSValue *exception) {
        LogError(@"JS Error: %@", exception);
    };
    
    for (NSString *key in self.javascriptObservers.allKeys) {
        
        PythiaJavascriptCallback block = self.javascriptObservers[key];
        
        JSValue *jv = self.context[key];
        if (![[jv toString] isEqualToString:@"undefined"]) {
            continue;
        }
        
        self.context[key] = ^{
            
            LogError(@"%@", [NSThread currentThread]);
            
            JSValue *this = [JSContext currentThis];
            NSArray *args = [JSContext currentArguments];
            
            dispatch_async(dispatch_get_main_queue(), ^{
               if (block) block(this, args);
            });
        };
    }
    
}


@end

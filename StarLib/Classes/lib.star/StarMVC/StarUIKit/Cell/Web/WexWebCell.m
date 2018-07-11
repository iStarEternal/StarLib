//
//  WexWebCell
//  WexWeiCaiFu
//
//  Created by shaohuali on 15/11/25.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import "WexWebCell.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WexWebCell () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) JSContext *context;
@property (nonatomic, assign, getter=isLoadCompleted) BOOL loadCompleted;

@end

@implementation WexWebCell

- (void)dealloc {
    [self.webView stopLoading];
    self.webView = nil;
}

- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)]; // 防止宽度等于0的情况
    self.webView.delegate = self;
    [self.contentView addSubview:self.webView];
    
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scalesPageToFit = true;
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
}

- (void)wex_layoutConstraints {
    [self.webView makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(0);
        make.left.top.bottom.equalTo(0);
        make.width.equalTo(ScreenWidth);
        make.height.equalTo(10).priorityHigh();
    }];
}

- (NSString *)URLString {
    return self.webView.request.URL.absoluteString;
}

- (void)setURLString:(NSString *)URLString {
    // self.webView
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    }
    NSURL *URL = [NSURL URLWithString:[URLString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:URL]];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // LogInfo(@"WebView Height -> \tRequest: %@", request);
    LogInfo(@"WebView Height -> \tURL: %@", request.URL);
    LogInfo(@"WebView Height -> \tFragment: %@", request.URL.fragment);
    
    CGFloat height = [request.URL.fragment floatValue];
    if (!request.URL.fragment) {
        return true;
    }
    
    [self.webView updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(height).priorityHigh();
    }];
    [self finishLoad];
    
    return true;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self evaluatingJSWithWebView:webView];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"];
        CGFloat sizeHeight = [str floatValue];
        
        [self.webView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(sizeHeight).priorityHigh();
        }];
        [self finishLoad];
    });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    LogError(@"%@", error);
}



- (void)evaluatingJSWithWebView:(UIWebView *)webView {
    
    if (!self.isLoadCompleted) {
        
        if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
            self.loadCompleted = true;
            [self mountJavaScriptAtWebView:webView];
            LogSuccess(@"mountJSScriptAtWebView执行成功");
        }
        else {
            // 资源过多的问题，导致document.readyState == interactive
            LogWarning(@"需要延迟获取document.readyState");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"]) {
                    self.loadCompleted = true;
                    [self mountJavaScriptAtWebView:webView];
                    LogSuccess(@"mountJSScriptAtWebView执行成功");
                }
                else {
                    LogError(@"mountJSScriptAtWebView未执行");
                }
            });
        }
    }
}

- (void)mountJavaScriptAtWebView:(UIWebView *)webView {
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context.exceptionHandler = ^void(JSContext *context, JSValue *exception) {
        LogError(@"JS Error: %@", exception);
    };
    
    StarWeakSelf
    
    self.context[@"askiOSNativeAllowedInvoke"] = ^NSString *() {
        return @"Allowed Invode";
    };
    
    self.context[@"invokeNativeGotoWebInterface"] = ^() {
        
        // JSValue *this = [JSContext currentThis];
        // LogInfo(@"this: %@", this);
        
        NSArray *args = [JSContext currentArguments];
        JSValue *value = args.firstObject;
        NSString *URLString = [value toString];
        
        
        LogInfo(@"%@", URLString);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf gotoWebInterfaceWithURLString:URLString];
        });
    };
}


- (void)gotoWebInterfaceWithURLString:(NSString *)URLString {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexWebCell:didReceivedJSCallBack:)]) {
        [self.delegate wexWebCell:self didReceivedJSCallBack:URLString];
    }
}


- (void)finishLoad {
    if (self.didFinishLoad)
        self.didFinishLoad();
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexWebCell:didFinishLoad:)]) {
        [self.delegate wexWebCell:self didFinishLoad:self.webView];
    }
}

@end

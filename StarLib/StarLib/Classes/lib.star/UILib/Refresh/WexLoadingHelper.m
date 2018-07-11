//
//  WexLoadingHelper.m
//  Pythia
//
//  Created by 星星 on 17/2/15.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexLoadingHelper.h"
#import "WexDispatch.h"

#import <objc/runtime.h>

#import "WexLoadingView.h"


typedef NS_ENUM(NSUInteger, WexLoadingStatus) {
    WexLoadingStatusLoading, // 加载中
    WexLoadingStatusFailure, // 加载失败
    WexLoadingStatusIdle,    // 空闲
};

@interface WexLoadingHelper ()

@property (nonatomic, weak, readonly) UIView *outsideView;
@property (nonatomic, weak) UIView<WexLoadingViewProtocol> *loadingView;

@property (nonatomic, assign) WexLoadingStatus status;

@end

@implementation WexLoadingHelper


- (instancetype)initWithHandleView:(UIView *)view delegate:(id<WexLoadingDelegate>)delegate {
    self = [super init];
    if (self) {
        _outsideView = view;
        _delegate = delegate;
    }
    return self;
}


#pragma mark - 安装 & 卸载

- (void)installLoading {
    
    if (self.loadingView) {
        return;
    }
    
    switch (self.type) {
        case WexLoadingTypeWCF: {
            WexLoadingView *loadingView = [[WexLoadingView alloc] init];
            [self.outsideView addSubview:loadingView];
            self.loadingView = loadingView;
        }
            break;
        default:
            break;
    }
    
    self.loadingView.goBackHidden = self.goBackHidden;
    [self.loadingView addFailureTouchHandlerWithTarget:self action:@selector(handleFailureTouch:)];
    [self.loadingView addGoBackButtonHandlerWithTarget:self action:@selector(handleGoBack:)];
    // 是否交给外面布局
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_loadingNeedLayout:)]) {
        [self.delegate wex_loadingNeedLayout:self.loadingView];
    }
    else {
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.outsideView);
        }];
    }
//    self.loadingView.hidden = true;
//    dispatch_delay(1.0, ^{
//        self.loadingView.hidden = false;
//    });
    
}

- (void)unistallLoading {
    
    [UIView animateWithDuration:0.10 animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished1) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
}


#pragma mark - 开始 & 结束

- (void)beginLoading {
    // 延迟1秒显示动画
    self.status = WexLoadingStatusLoading;
    [self installLoading];
    [self.loadingView setLoading:@"加载中，请稍候..."];
    [self refreshLoading];
}

- (void)endLoading {
    [self unistallLoading];
    self.status = WexLoadingStatusIdle;
}

- (BOOL)isLoading {
    return self.status == WexLoadingStatusLoading;
}

#pragma mark - 调用

- (void)refreshLoading {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(wex_loadingAction)]) {
            [self.delegate wex_loadingAction];
        }
    }
    @catch (NSException *e) {
        
    }
}


#pragma mark - 错误

- (void)setGoBackHidden:(BOOL)goBackHidden {
    _goBackHidden = goBackHidden;
    [self.loadingView setGoBackHidden:goBackHidden];
}

- (void)loadingFailureNormal:(NSString *)error {
    self.loadingView.hidden = false;
    self.status = WexLoadingStatusFailure;
    [self.loadingView setLoadingFailureNormal:[NSString isNullOrWhiteSpace:error] ? @"抱歉，系统错误，请稍后再试。" : error];
}

- (void)loadingFailureNetwork {
    self.loadingView.hidden = false;
    self.status = WexLoadingStatusFailure;
    [self.loadingView setLoadingFailureNetwork:@"网络不给力，轻触屏幕刷新"];
}


#pragma mark - 点击

- (void)handleFailureTouch:(id)sender {
    if (self.status == WexLoadingStatusFailure) {
        [self beginLoading];
    }
}

- (void)handleGoBack:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_loadingGoBackClicked)]) {
        [self.delegate wex_loadingGoBackClicked];
    }
}


@end

//
//  WexLoadingHelper.h
//  Pythia
//
//  Created by 星星 on 17/2/15.
//  Copyright © 2017年 weicaifu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "WexLoadingViewProtocol.h"


typedef NS_ENUM(NSUInteger, WexLoadingType) {
    WexLoadingTypeWCF,   // 微财富刷新动画
    WexLoadingTypePythia // 猫基金刷新动画
};


@protocol WexLoadingDelegate <NSObject>

- (void)wex_loadingAction;

- (void)wex_loadingGoBackClicked;

@optional
- (void)wex_loadingNeedLayout:(UIView<WexLoadingViewProtocol> *)loadingView;

@end


@interface WexLoadingHelper : NSObject

@property (nonatomic, weak) id<WexLoadingDelegate> delegate;

- (instancetype)initWithHandleView:(UIView *)view delegate:(id<WexLoadingDelegate>)delegate;

@property (nonatomic, assign) WexLoadingType type; // default is WexLoadingTypeWCF

/// 返回按钮是否可见
@property (nonatomic, assign) BOOL goBackHidden;



/// 开始动画刷新
- (void)beginLoading;

/// 停止动画刷新
- (void)endLoading;

/// 是否刷新中
- (BOOL)isLoading;

/// 加载失败 - 接口问题
- (void)loadingFailureNormal:(NSString *)error;

/// 加载失败 - 网络问题
- (void)loadingFailureNetwork;


@end

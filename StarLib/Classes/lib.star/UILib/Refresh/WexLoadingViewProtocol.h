//
//  WexLoadingViewProtocol.h
//  Weicaifu
//
//  Created by 星星 on 2017/10/10.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WexLoadingViewProtocol <NSObject>


@property (nonatomic, assign) BOOL goBackHidden;

// 加载中
- (void)setLoading:(NSString *)title;

// 加载失败 - 其他
- (void)setLoadingFailureNormal:(NSString *)title;

// 加载失败 - 断网
- (void)setLoadingFailureNetwork:(NSString *)title;

/// 返回按钮是否可见
- (void)setGoBackHidden:(BOOL)hidden;

// 添加错误页点击事件
- (void)addFailureTouchHandlerWithTarget:(id)target action:(SEL)action;

// 添加返回事件
- (void)addGoBackButtonHandlerWithTarget:(id)target action:(SEL)action;
@end

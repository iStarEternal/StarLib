//
//  WexRefresh.h
//  Pythia
//
//  Created by 星星 on 17/2/15.
//  Copyright © 2017年 weicaifu. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "WexRefreshEnum.h"

@class XCRefreshHelper;
@protocol WexRefreshDelegate <NSObject>

/// 下拉刷新调用
- (void)wex_refreshHeaderAction:(XCRefreshHelper *)refresh;

@optional
/// 上拉刷新调用
- (void)wex_refreshFooterAction:(XCRefreshHelper *)refresh;

@end


@interface XCRefreshHelper : NSObject

@property (nonatomic, weak) id<WexRefreshDelegate> delegate;

+ (instancetype)refreshHelperWithHandleScrollView:(UIScrollView *)scrollView delegate:(id)delegate;
- (instancetype)initWithHandleScrollView:(UIScrollView *)scrollView delegate:(id)delegate;


#pragma mark Refresh Header

/**
 *  安装下拉刷新： Normal
 */
- (void)installRefreshHeader;
- (void)installRefreshHeader:(WexRefreshHeaderType)type;

/**
 *  开始下拉刷新
 */
- (void)beginHeaderRefreshing;

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefreshing;

/**
 *  是否正在下拉刷新
 */
- (BOOL)isHeaderRefreshing;



#pragma mark Refresh Footer

/**
 *  安装上拉刷新
 */
- (void)installRefreshFooter;

- (void)uninstallRefreshFooter;

/**
 *  开始上拉刷新
 */
- (void)beginFooterRefreshing;

/**
 *  结束上拉刷新
 */
- (void)endFooterRefreshing;


/**
 *  是否正在上拉刷新
 */
- (BOOL)isFooterRefreshing;


/**
 *  设置为已经没有更多数据了
 *
 *  @param info 显示的文案
 */
- (void)setRefreshFooterNoMoreData:(NSString *)info;

@end

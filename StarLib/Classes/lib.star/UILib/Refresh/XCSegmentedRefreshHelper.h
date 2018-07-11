//
//  XCSegmentedRefreshHelper.h
//  vodSeal
//
//  Created by 星星 on 2018/7/3.
//  Copyright © 2018年 yinuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XCRefreshHelper.h"


@protocol XCSegumentedRefreshDelegate <NSObject>

- (void)xc_refreshHeaderAction:(XCRefreshHelper *)refresh atIndex:(NSUInteger)index;
- (void)xc_refreshFooterAction:(XCRefreshHelper *)refresh atIndex:(NSUInteger)index;

@end

@interface XCSegmentedRefreshHelper : NSObject

@property (nonatomic, weak) id<XCSegumentedRefreshDelegate> delegate;

@property (nonatomic, strong) NSArray<XCRefreshHelper *> *refreshHelpers;
@property (nonatomic, strong) NSArray<UIScrollView *> *scrollViews;

- (void)setScrollViews:(NSArray<UIScrollView *> *)scrollViews andInstall:(WexRefreshHeaderType)type;




/**
 *  安装下拉刷新： Normal
 */
- (void)installRefreshHeader;
- (void)installRefreshHeader:(WexRefreshHeaderType)type;

/**
 *  开始下拉刷新
 */
- (void)beginHeaderRefreshingAtIndex:(NSUInteger)index;

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefreshingAtIndex:(NSUInteger)index;

/**
 *  是否正在下拉刷新
 */
- (BOOL)isHeaderRefreshingAtIndex:(NSUInteger)index;



#pragma mark Refresh Footer

/**
 *  安装上拉刷新
 */
- (void)installRefreshFooterAtIndex:(NSUInteger)index;

/**
 *  卸载上拉刷新
 */
- (void)uninstallRefreshFooterAtIndex:(NSUInteger)index;

/**
 *  开始上拉刷新
 */
- (void)beginFooterRefreshingAtIndex:(NSUInteger)index;

/**
 *  结束上拉刷新
 */
- (void)endFooterRefreshingAtIndex:(NSUInteger)index;

/**
 *  是否正在上拉刷新
 */
- (BOOL)isFooterRefreshingAtIndex:(NSUInteger)index;

/**
 *  设置为已经没有更多数据了
 *
 *  @param info 显示的文案
 */
- (void)setRefreshFooterNoMoreData:(NSString *)info atIndex:(NSUInteger)index;


@end

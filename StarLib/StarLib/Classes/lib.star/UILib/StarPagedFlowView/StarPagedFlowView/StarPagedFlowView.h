//
//  StarPagedFlowView.h
//  dianshang
//
//  Created by Star on 16/7/13.
//  Copyright © 2016年 Star. All rights reserved.

#import <UIKit/UIKit.h>
#import "StarPagedFlowViewCell.h"

@class StarPagedFlowViewCell;

@protocol StarPagedFlowViewDataSource;
@protocol StarPagedFlowViewDelegate;

/******************************
 
 页面滚动的方向分为横向和纵向
 
 Version 1.0:
 目的:实现类似于选择电影票的效果,并且实现无限/自动轮播
 
 特点:1.无限轮播;2.自动轮播;3.电影票样式的层次感;4.非当前显示view具有缩放和透明的特效
 
 问题:考虑到轮播图的数量不会太大,暂时未做重用处理;对设备性能影响不明显,后期版本会考虑添加重用标识模仿tableview的重用
 
 ******************************/

typedef NS_ENUM(NSUInteger, StarPagedFlowViewOrientation) {
    StarPagedFlowViewOrientationHorizontal = 0,
    StarPagedFlowViewOrientationVertical
};

@interface StarPagedFlowView : UIView<UIScrollViewDelegate>

/// 默认为横向
@property (nonatomic, assign) StarPagedFlowViewOrientation orientation;

///
@property (nonatomic, strong) UIScrollView *scrollView;

///
@property (nonatomic, assign) BOOL needsReload;

/// 一页的尺寸
@property (nonatomic, assign) CGSize pageSize;

/// 总页数
@property (nonatomic, assign) NSInteger pageCount;

///
@property (nonatomic ,strong) NSMutableArray *cells;

///
@property (nonatomic, assign) NSRange visibleRange;

/// 如果以后需要支持reuseIdentifier，这边就得使用字典类型了
@property (nonatomic, strong) NSMutableArray *reusableCells;

/// 数据源
@property (nonatomic, weak) id<StarPagedFlowViewDataSource> dataSource;

/// 代理
@property (nonatomic, weak) id<StarPagedFlowViewDelegate> delegate;

/// 指示器
@property (nonatomic, retain) UIPageControl *pageControl;

/// 非当前页的透明比例
@property (nonatomic, assign) CGFloat minimumPageAlpha;

/// 非当前页的缩放比例
@property (nonatomic, assign) CGFloat minimumPageScale;

/// 是否开启循环播放
@property (nonatomic, assign) BOOL isLooping;

/// 是否开启自动滚动,默认为开启
@property (nonatomic, assign) BOOL isOpenAutoScroll;

/// 当前是第几页
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/// 定时器
@property (nonatomic, weak) NSTimer *timer;

/// 自动切换视图的时间,默认是5.0
@property (nonatomic, assign) NSTimeInterval autoTime;

/// 原始页数
@property (nonatomic, assign) NSInteger orginPageCount;

/// 焦点Index
@property (nonatomic, assign, readonly) NSInteger focusCellIndex;

/// 焦点Cell
@property (nonatomic, assign, readonly) __kindof StarPagedFlowViewCell * focusCell;





/// 刷新视图
- (void)reloadData;

/// 获取可重复使用的Cell
- (__kindof StarPagedFlowViewCell *)dequeueReusableCell;

// 通过Index获取Cell
- (__kindof StarPagedFlowViewCell *)cellForItemAtIndex:(NSInteger)index;

/// 滚动到指定的页面
- (void)scrollToPage:(NSUInteger)pageNumber;

/// 关闭定时器,关闭自动滚动
- (void)stopTimer;

@end


@protocol StarPagedFlowViewDelegate<NSObject>

// Item Size
- (CGSize)sizeForItemsInFlowView:(StarPagedFlowView *)flowView;

@optional

/// 成为焦点, 在滚动过程中，Cell可能会不断的成为焦点，然后失去焦点，而最终的焦点将会停留在targetIndex
- (void)flowView:(StarPagedFlowView *)flowView didBecomeFocusCellAtIndex:(NSUInteger)index targetIndex:(NSUInteger)targetIndex;

/// 失去焦点
- (void)flowView:(StarPagedFlowView *)flowView didResignFocusCellAtIndex:(NSUInteger)index;

/// 点击Cell
- (void)flowView:(StarPagedFlowView *)flowView didSelectCell:(__kindof StarPagedFlowViewCell *)cell atIndex:(NSUInteger)index;

@end


@protocol StarPagedFlowViewDataSource <NSObject>

// Item的个数
- (NSInteger)numberOfItemsInFlowView:(StarPagedFlowView *)flowView;

// Cell
- (UIView *)flowView:(StarPagedFlowView *)flowView cellForPageAtIndex:(NSUInteger)index;

@end

//
//  XCSegmentedRefreshHelper.m
//  vodSeal
//
//  Created by 星星 on 2018/7/3.
//  Copyright © 2018年 yinuo. All rights reserved.
//

#import "XCSegmentedRefreshHelper.h"


@interface XCSegmentedRefreshHelper () <WexRefreshDelegate>

@end

@implementation XCSegmentedRefreshHelper

- (void)setScrollViews:(NSArray<UIScrollView *> *)scrollViews andInstall:(WexRefreshHeaderType)type {
    self.scrollViews = scrollViews;
    [self installRefreshHeader:type];
}


- (void)installRefreshHeader:(WexRefreshHeaderType)type {
    self.refreshHelpers = [self.scrollViews map:^id(UIScrollView *element) {
        XCRefreshHelper *refresh = [XCRefreshHelper refreshHelperWithHandleScrollView:element delegate:self];
        [refresh installRefreshHeader:type];
        return refresh;
    }];
}


- (void)installRefreshHeader {
    [self installRefreshHeader:WexRefreshHeaderTypeNormal];
}

- (void)beginHeaderRefreshingAtIndex:(NSUInteger)index {
    [self.refreshHelpers[index] beginHeaderRefreshing];
}

- (void)endHeaderRefreshingAtIndex:(NSUInteger)index {
    [self.refreshHelpers[index] endHeaderRefreshing];
}


- (BOOL)isHeaderRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] isHeaderRefreshing];
}


- (void)installRefreshFooterAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] installRefreshFooter];
}

- (void)uninstallRefreshFooterAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] uninstallRefreshFooter];
}

- (void)beginFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] beginFooterRefreshing];
}

- (void)endFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] endFooterRefreshing];
}

- (BOOL)isFooterRefreshingAtIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] isFooterRefreshing];
}

- (void)setRefreshFooterNoMoreData:(NSString *)info atIndex:(NSUInteger)index {
    return [self.refreshHelpers[index] setRefreshFooterNoMoreData:info];
}

- (void)wex_refreshHeaderAction:(XCRefreshHelper *)refresh {
    NSUInteger index = [self.refreshHelpers indexOfObject:refresh];
    if (self.delegate && [self.delegate respondsToSelector:@selector(xc_refreshHeaderAction:atIndex:)]) {
        [self.delegate xc_refreshHeaderAction:refresh atIndex:index];
    }
}

- (void)wex_refreshFooterAction:(XCRefreshHelper *)refresh {
    NSUInteger index = [self.refreshHelpers indexOfObject:refresh];
    if (self.delegate && [self.delegate respondsToSelector:@selector(xc_refreshFooterAction:atIndex:)]) {
        [self.delegate xc_refreshFooterAction:refresh atIndex:index];
    }
}





@end

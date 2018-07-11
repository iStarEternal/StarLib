//
//  WexRefresh.m
//  Pythia
//
//  Created by 星星 on 17/2/15.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "XCRefreshHelper.h"
#import "MJRefresh.h"

#import "WexLogoRefreshHeader.h"
#import "WexRefreshHeader.h"


@interface XCRefreshHelper () {}

@property (nonatomic, weak, readonly) UIScrollView *scrollView;

@end

@implementation XCRefreshHelper

+ (instancetype)refreshHelperWithHandleScrollView:(UIScrollView *)scrollView delegate:(id)delegate {
    return [[self alloc] initWithHandleScrollView:scrollView delegate:delegate];
}
- (instancetype)initWithHandleScrollView:(UIScrollView *)scrollView delegate:(id)delegate {
    self = [super init];
    if (self) {
        _scrollView = scrollView;
        _delegate = delegate;
    }
    return self;
}


#pragma mark - Refresh Header

- (void)installRefreshHeader {
    [self installRefreshHeader:WexRefreshHeaderTypeNormal];
}

- (void)installRefreshHeader:(WexRefreshHeaderType)type {
    
    switch (type) {
            
        case WexRefreshHeaderTypeLogo: {
            
            WexLogoRefreshHeader *header = [WexLogoRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            self.scrollView.mj_header = header;
        }
            break;
            
        case WexRefreshHeaderTypeRed: {
            
            WexRefreshHeader *header = [WexRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = @"system_red_color".xc_color;
            header.tintColor = [UIColor whiteColor];
            self.scrollView.mj_header = header;
        }
            break;
            
        case WexRefreshHeaderTypeGold: {
            
            WexRefreshHeader *header = [WexRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = @"system_gold_color".xc_color;
            header.tintColor = [UIColor whiteColor];
            self.scrollView.mj_header = header;
        }
            break;
            
        case WexRefreshHeaderTypeNormal:
        default: {
            WexRefreshHeader *header = [WexRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
            header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            header.backgroundColor = [UIColor clearColor];
            header.tintColor = @"#999999".xc_color;
            self.scrollView.mj_header = header;
        }
            break;
    }
}



- (void)beginHeaderRefreshing {
    [self.scrollView.mj_header beginRefreshing];
}

- (void)endHeaderRefreshing {
    [self.scrollView.mj_header endRefreshing];
}

- (BOOL)isHeaderRefreshing {
    return self.scrollView.mj_header.isRefreshing;
}


#pragma mark Refresh Footer

- (void)installRefreshFooter {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    footer.stateLabel.font = @"14px".xc_font;
    footer.stateLabel.textColor = @"#999999".xc_color;
    footer.tintColor = @"#999999".xc_color;
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    self.scrollView.mj_footer = footer;
}

- (void)uninstallRefreshFooter {
    self.scrollView.mj_footer = nil;
}

- (void)beginFooterRefreshing {
    [self.scrollView.mj_footer beginRefreshing];
}

- (void)endFooterRefreshing {
    [self.scrollView.mj_footer endRefreshing];
}

- (BOOL)isFooterRefreshing {
    return self.scrollView.mj_footer.isRefreshing;
}

- (void)setRefreshFooterNoMoreData:(NSString *)info {
    MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.scrollView.mj_footer;
    if (info) {
        [footer setTitle:info forState:MJRefreshStateNoMoreData];
    }
    [footer setState:MJRefreshStateNoMoreData];
    [footer endRefreshingWithNoMoreData];
}


#pragma mark - 刷新动作

- (void)refreshHeader {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(wex_refreshHeaderAction:)]) {
            [self.delegate wex_refreshHeaderAction:self];
        }
    }
    @catch (NSException *e) {
        
    }
}

- (void)refreshFooter {
    @try {
        if (self.delegate && [self.delegate respondsToSelector:@selector(wex_refreshFooterAction:)]) {
            [self.delegate wex_refreshFooterAction:self];
        }
    }
    @catch (NSException *e) {
        
    }
}




@end

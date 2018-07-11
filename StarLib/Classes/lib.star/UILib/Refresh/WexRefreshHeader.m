//
//  WexRefreshHeader.m
//  MJRefreshExample
//
//  Created by Star on 15/4/24.
//  Copyright (c) 2015年 Star. All rights reserved.
//

#import "WexRefreshHeader.h"
#import <QuartzCore/QuartzCore.h>

#define kTotalViewHeight    400
#define kOpenedViewHeight   44
#define kMinTopPadding      9
#define kMaxTopPadding      5
#define kMinTopRadius       12.5
#define kMaxTopRadius       16
#define kMinBottomRadius    3
#define kMaxBottomRadius    16
#define kMinBottomPadding   4
#define kMaxBottomPadding   6
#define kMinArrowSize       2
#define kMaxArrowSize       3
#define kMinArrowRadius     5
#define kMaxArrowRadius     7
#define kMaxDistance        44

@interface WexRefreshHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
}

@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@property (nonatomic, weak) UIView *backgroundView;
@property (nonatomic, assign) UIEdgeInsets originalContentInset;

@end

@implementation WexRefreshHeader


#pragma mark - 懒加载子控件

- (UIImageView *)arrowView {
    if (!_arrowView) {
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}



- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    super.tintColor = tintColor;
    self.arrowView.tintColor = tintColor;
    self.loadingView.color = tintColor;
    self.stateLabel.tintColor = tintColor;
    self.lastUpdatedTimeLabel.tintColor = tintColor;
    self.stateLabel.textColor = tintColor;
    self.lastUpdatedTimeLabel.textColor = tintColor;
}


#pragma mark - 公共方法

- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle {
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}



#pragma mark 监听scrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 背景纯色
    // 防止白边 多给44高度
    CGFloat givenMoreHeight = 44;
    
    self.backgroundView.mj_w = self.scrollView.mj_w;
    self.backgroundView.mj_h = MAX(-self.scrollView.mj_offsetY, 0) + givenMoreHeight;
    self.backgroundView.mj_x = 0;
    self.backgroundView.mj_y = self.scrollView.mj_offsetY + self.mj_h - givenMoreHeight;
    
    // 下拉刷新逐渐显示状态文字
    CGFloat contentOffsetY = self.scrollView.mj_offsetY;
    CGFloat clearOffset = 44;
    
    if (contentOffsetY >= 0) {
        self.arrowView.alpha = 0;
        self.stateLabel.alpha = 0;
    }
    else {
        CGFloat alpha = fabs(contentOffsetY / clearOffset) - 0.5;
        if (alpha <= 0) {
            alpha = 0.0;
        }
        else if (alpha > 1.0) {
            alpha = 1.0;
        }
        self.arrowView.alpha = alpha;
        self.stateLabel.alpha = alpha;
    }
}



#pragma mark - 重写父类的方法

- (void)prepare {
    
    [super prepare];
    
    UIView *backgroundView = [[UIView alloc] init];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self sendSubviewToBack:self.backgroundView];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.lastUpdatedTimeLabel.hidden = true;
    
    self.stateLabel.font = @"14px".xc_font;
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
}

- (CGFloat)stringWidth:(UILabel *)_label {
    CGFloat stringWidth = 0;
    CGSize size = CGSizeMake(self.mj_w, self.mj_h);
    if (_label.text.length > 0) {
#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        stringWidth =[_label.text
                      boundingRectWithSize:size
                      options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:@{NSFontAttributeName:_label.font}
                      context:nil].size.width;
#else
        
        stringWidth = [_label.text sizeWithFont:_label.font
                              constrainedToSize:size
                                  lineBreakMode:NSLineBreakByCharWrapping].width;
#endif
    }
    
    
    return stringWidth;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        CGFloat offset = 20;
        CGFloat stateWidth = [self stringWidth:self.stateLabel];
        CGFloat timeWidth = 0.0;
        if (!self.lastUpdatedTimeLabel.hidden) {
            timeWidth = [self stringWidth:self.lastUpdatedTimeLabel];
        }
        CGFloat textWidth = MAX(stateWidth, timeWidth);
        arrowCenterX -= textWidth / 2 + offset;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = self.arrowView.image.size;
        self.arrowView.center = arrowCenter;
    }
    
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = CGPointMake(self.mj_w * 0.5, arrowCenterY);
    }
}

- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle)
                    return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.arrowView.hidden = false;
                self.stateLabel.hidden = false;
            }];
        }
        else {
            [self.loadingView stopAnimating];
            self.arrowView.hidden = false;
            self.stateLabel.hidden = false;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    }
    else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.arrowView.hidden = false;
        self.stateLabel.hidden = false;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    }
    else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.arrowView.hidden = true;
        self.stateLabel.hidden = true;
    }
}


@end

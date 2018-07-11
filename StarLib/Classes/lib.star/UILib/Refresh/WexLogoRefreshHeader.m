//
//  WexLogoRefreshHeader.m
//  MJRefreshExample
//
//  Created by Star on 15/4/24.
//  Copyright (c) 2015年 Star. All rights reserved.
//

#import "WexLogoRefreshHeader.h"

#define LogoRefreshIdleText         @"下拉"
#define LogoRefreshPullingText      @"放开"
#define LogoRefreshRefreshingText   @"加载数据中"

@interface WexLogoRefreshHeader()
@property (weak, nonatomic) UILabel *statusLabel;
@property (weak, nonatomic) UIImageView *arrowView;
@property (weak, nonatomic) UIImageView *logoAImageView;
@property (weak, nonatomic) UIImageView *logoBImageView;
@property (weak, nonatomic) UIImageView *logoCImageView;
@property (weak, nonatomic) UIImageView *statusImageView;
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@property (nonatomic, weak) UIView *backgroundView;
@end


@implementation WexLogoRefreshHeader


#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）

- (void)prepare {
    [super prepare];
    
    UIView *backgroundView = [[UIView alloc] init];
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 设置控件的高度
    self.mj_h = 55;
    
    // 添加label
    UILabel *statusLabel = [[UILabel alloc] init];
    [self addSubview:statusLabel];
    self.statusLabel = statusLabel;
    self.statusLabel.textColor = [UIColor colorWithRGB:0x888888];
    self.statusLabel.font = MJRefreshLabelFont;
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.hidden = true;
    
    // 状态文字
    UIImageView *statusImageView = [[UIImageView alloc] init];
    [self addSubview:statusImageView];
    self.statusImageView = statusImageView;
    self.statusImageView.image = @"home-refresh-view-label1".xc_image;
    
    
    // logo
    UIImageView *logoAImageView = [[UIImageView alloc] init];
    logoAImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoAImageView];
    self.logoAImageView = logoAImageView;
    self.logoAImageView.image = @"home-refresh-view-licon1".xc_image;
    
    //
    UIImageView *logoBImageView = [[UIImageView alloc] init];
    logoBImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoBImageView];
    self.logoBImageView = logoBImageView;
    self.logoBImageView.image = @"home-refresh-view-licon2".xc_image;
    
    //
    UIImageView *logoCImageView = [[UIImageView alloc] init];
    logoCImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoCImageView];
    self.logoCImageView = logoCImageView;
    self.logoCImageView.image = @"home-refresh-view-licon3".xc_image;
    
    
    // 箭头
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[NSBundle mj_arrowImage]];
    [self addSubview:arrowView];
    self.arrowView = arrowView;
    self.arrowView.tintColor = self.statusLabel.textColor;
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loadingView = loading;
    
}


#pragma mark 在这里设置子控件的位置和尺寸

- (void)placeSubviews {
    [super placeSubviews];
    
    CGFloat realCenterX = self.boundsCenter.x;
    CGFloat realCenterY = self.boundsCenter.y + 5;
    
    // 状态文字 & 图标
    self.statusLabel.frame = self.bounds;
    self.statusImageView.bounds = CGRectMake(0, 0, 289./2.5, 51./2.5);
    self.statusImageView.center = CGPointMake(realCenterX, realCenterY);
    
    // 三个图标
    self.logoAImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoAImageView.center = CGPointMake(self.mj_w / 3 * 0.5, - self.logoAImageView.mj_h * 0.5);
    
    self.logoBImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoBImageView.center = CGPointMake(realCenterX, - self.logoBImageView.mj_h * 0.5);
    
    self.logoCImageView.bounds = CGRectMake(0, 0, 70, 70);
    self.logoCImageView.center = CGPointMake(self.mj_w - (self.mj_w / 3 * 0.5), - self.logoCImageView.mj_h * 0.5);
    
    
    // 箭头 & 菊花
    CGFloat offset = 30;
    CGFloat statusLabelWidth = [self stringWidth:self.statusLabel];
    CGFloat statusImageWidth = self.statusImageView.mj_w;
    CGFloat textWidth = MAX(statusLabelWidth, statusImageWidth);
    
    CGFloat arrowCenterX = realCenterX;
    arrowCenterX -= textWidth / 2 + offset;
    CGFloat arrowCenterY = realCenterY;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // self.arrowView.mj_size = self.arrowView.image.size;
    self.arrowView.size = CGSizeMake(30./2.5 ,80./2.5);
    self.arrowView.center = arrowCenter;
    self.loadingView.center = arrowCenter;
    
}


#pragma mark 监听scrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    self.backgroundView.mj_w = self.scrollView.mj_w;
    self.backgroundView.mj_x = 0;
    self.backgroundView.mj_h = -self.scrollView.mj_offsetY + 44;
    self.backgroundView.mj_y = self.scrollView.mj_offsetY + self.mj_h - 44;
}


#pragma mark 监听scrollView的contentSize改变

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    
}


#pragma mark 监听scrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
    
}


#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    
    
    switch (state) {
        case MJRefreshStateIdle: {
            
            self.statusLabel.text = LogoRefreshIdleText;
            
            if (oldState == MJRefreshStateRefreshing) {
                self.arrowView.transform = CGAffineTransformIdentity;
                
                [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                    self.loadingView.alpha = 0.0;
                } completion:^(BOOL finished) {
                    
                    if (self.state != MJRefreshStateIdle)
                        return;
                    
                    self.loadingView.alpha = 1.0;
                    [self.loadingView stopAnimating];
                    self.arrowView.hidden = NO;
                }];
            } else {
                [self.loadingView stopAnimating];
                self.arrowView.hidden = NO;
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                    self.arrowView.transform = CGAffineTransformIdentity;
                }];
            }
        }
            break;
        case MJRefreshStatePulling: {
            self.statusLabel.text = LogoRefreshPullingText;
            [self.loadingView stopAnimating];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
            }];
        }
            break;
        case MJRefreshStateRefreshing: {
            self.statusLabel.text = LogoRefreshRefreshingText;
            [self.loadingView startAnimating];
            self.loadingView.alpha = 1.0;
            self.arrowView.hidden = YES;
        }
            break;
        default:
            break;
    }
}


#pragma mark 监听拖拽比例（控件被拖出来的比例）

- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
}



#pragma mark - 自定义方法

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

@end

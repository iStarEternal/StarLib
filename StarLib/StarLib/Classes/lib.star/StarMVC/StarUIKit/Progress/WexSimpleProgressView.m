//
//  WexSimpleProgressView.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/10/27.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexSimpleProgressView.h"

@implementation WexSimpleProgressView

- (void)wex_loadViews {
    [super wex_loadViews];
    self.opaque = false;
    _progressColor = [UIColor orangeColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.frame.size.height * 0.5;
    self.layer.masksToBounds = true;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Fill Line
    rect.size.width *= self.progress;
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    CGContextFillRect(context, rect);
}

@end

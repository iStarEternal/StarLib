//
//  StarFilterPointer.m
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "StarFilterPointer.h"

@implementation StarFilterPointer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _color = [UIColor orangeColor];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.color.CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, 6, 6));
}

@end

//
//  StarFilterPointer.m
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "PythiaFilterPointer.h"

@implementation PythiaFilterPointer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.opaque = false;
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
    CGContextSetFillColorWithColor(context, self.color.CGColor ?: [UIColor clearColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectInset(rect, 6, 6));
}

@end

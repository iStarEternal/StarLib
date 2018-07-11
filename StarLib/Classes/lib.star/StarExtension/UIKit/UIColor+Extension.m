//
//  UIColor+Extension.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor(Extension)

+ (UIColor *)colorWithRGB:(NSInteger)rgb {
    return [self colorWithRGB:rgb alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha {
    
    CGFloat red = ((rgb >> 16) & 0xff) / 255.0;
    CGFloat green = ((rgb >> 8) & 0xff) / 255.0;
    CGFloat blue = ((rgb) & 0xff) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)colorWithRGBA:(NSInteger)rgba {
    
    CGFloat red = ((rgba >> 24) & 0xff) / 255.0;
    CGFloat green = ((rgba >> 16) & 0xff) / 255.0;
    CGFloat blue = ((rgba >> 8) & 0xff) / 255.0;
    CGFloat alpha = ((rgba) & 0xff) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *(^)(CGFloat))colorWithAlpha {
    return ^UIColor *(CGFloat alpha) {
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        [self getRed:&red green:&green blue:&blue alpha:NULL];
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}

- (UIColor *(^)(CGFloat))colorWithDeepen {
    return ^UIColor *(CGFloat deepen) {
        CGFloat red;
        CGFloat green;
        CGFloat blue;
        CGFloat alpha;
        [self getRed:&red green:&green blue:&blue alpha:&alpha];
        
        red = MIN(1., MAX(0, red - deepen));
        green = MIN(1., MAX(0, green - deepen));
        blue = MIN(1., MAX(0, blue - deepen));
        
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    };
}



+ (UIColor *)tempColor {
    return [self colorWithRGB:0xfef28f alpha:0.7];
}

+ (UIColor *)randomColor {
    
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) / 255.0;
    return [self colorWithRed:red green:green blue:blue alpha:1.0];
}

- (NSInteger)rgba {
    
    CGFloat rValue, gValue, bValue, aValue;
    if (![self getRed:&rValue green:&gValue blue:&bValue alpha:&aValue]) {
        return false;
    }
    NSInteger red = rValue * 255.0;
    NSInteger green = gValue * 255.0;
    NSInteger blue = bValue * 255.0;
    NSInteger alpha = aValue * 255.0;
    return (red << 24) + (green << 16) + (blue << 8) + alpha;
}

- (BOOL)isEqualToColor:(UIColor *)color {
    
    if (![color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        return false;
    }
    
    CGFloat redValue, greenValue, blueValue, alphaValue;
    CGFloat rValue, gValue, bValue, aValue;
    
    if (![color getRed:&redValue green:&greenValue blue:&blueValue alpha:&alphaValue]) {
        return false;
    }
    
    if (![self getRed:&rValue green:&gValue blue:&bValue alpha:&aValue]) {
        return false;
    }
    
    return (redValue == rValue && greenValue == gValue && blueValue == bValue && alphaValue == aValue);
}

@end

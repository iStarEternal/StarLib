//
//  UIColor+Extension.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

#define rgba(r,g,b,a) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])
#define xrgb(rgb) [UIColor colorWithRGB:rgb]
#define xrgba(rgba) [UIColor colorWithRGBA:rgba]

@interface UIColor(Extension)

+ (UIColor *)colorWithRGB:(NSInteger)rgb;

+ (UIColor *)colorWithRGB:(NSInteger)rgb alpha:(CGFloat)alpha;

+ (UIColor *)colorWithRGBA:(NSInteger)rgba;

@property (nonatomic, strong, readonly) UIColor *(^colorWithAlpha)(CGFloat alpha);

@property (nonatomic, strong, readonly) UIColor *(^colorWithDeepen)(CGFloat deepen);


@property (class, nonatomic, strong, readonly) UIColor *tempColor;
@property (class, nonatomic, strong, readonly) UIColor *randomColor;
//+ (UIColor *)tempColor;

//+ (UIColor *)randomColor;

- (NSInteger)rgba;

- (BOOL)isEqualToColor:(UIColor *)color;

@end

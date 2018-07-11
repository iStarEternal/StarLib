//
//  XCResourceManager.m
//  WeXFin
//
//  Created by Mark on 15/7/16.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//


//#define RES_LIGHT_FONT_NAME         @"PingFangSC-Thin"
//#define RES_FONT_NAME               @"PingFangSC-Light"
//#define RES_BOLD_FONT_NAME          @"PingFangSC-Regular"

#define RES_LIGHT_FONT_NAME         @"PingFangSC-Light"
#define RES_FONT_NAME               @"PingFangSC-Regular"
#define RES_BOLD_FONT_NAME          @"PingFangSC-Midium"


#import "XCResourceManager.h"
#import "StarExtension.h"


#define PythiaColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define PythiaColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]


@interface XCResourceManager ()


@end

@implementation XCResourceManager

+ (XCResourceManager *)sharedManager {
    
    __strong static id _sharedWexResManagerObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWexResManagerObject = [[self alloc] init];
    });
    return _sharedWexResManagerObject;
}


#pragma mark - 配置解析相关方法

- (void)run {}

#pragma mark -

- (UIColor *)colorWithKey:(NSString *)colorKey {
    if ([colorKey hasPrefix:@"#"]) {
        NSString *colorStr = [colorKey substringFromIndex:1];
        return PythiaColorFromRGB(strtoul([colorStr UTF8String], 0, 16));
    }
    return nil;
}

- (UIImage *)imageWithKey:(NSString *)imageKey {
    UIImage *outputImage = nil;
    outputImage = [UIImage imageNamed:imageKey];
    return outputImage;
}

- (UIFont *)fontWithKey:(NSString *)fontKey {
    
    if (!fontKey && fontKey.isEmpty)
        return nil;
    
    // 15px
    if ([fontKey.lowercaseString hasSuffix:@"px"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 2];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont fontWithName:RES_FONT_NAME size:fontsize] ?: [UIFont systemFontOfSize:fontsize weight:UIFontWeightRegular];
    }
    
    // 15px-bold 15px_bold
    else if ([fontKey.lowercaseString hasSuffix:@"px-bold"] || [fontKey.lowercaseString hasSuffix:@"px_bold"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont fontWithName:RES_BOLD_FONT_NAME size:fontsize] ?: [UIFont systemFontOfSize:fontsize weight:UIFontWeightBold];
    }
    
    // 15px-bold 15px_bold
    if ([fontKey.lowercaseString hasSuffix:@"px-light"] || [fontKey.lowercaseString hasSuffix:@"px_light"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont fontWithName:RES_LIGHT_FONT_NAME size:fontsize] ?: [UIFont systemFontOfSize:fontsize weight:UIFontWeightLight];
    }
    
    return nil;
}

- (UIFont *)systemFontWithKey:(NSString *)fontKey {
    
    if (!fontKey && fontKey.isEmpty)
        return nil;
    
    // 15px
    if ([fontKey.lowercaseString hasSuffix:@"px"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 2];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont systemFontOfSize:fontsize weight:UIFontWeightRegular];
    }
    
    // 15px-bold 15px_bold
    else if ([fontKey.lowercaseString hasSuffix:@"px-bold"] || [fontKey.lowercaseString hasSuffix:@"px_bold"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont systemFontOfSize:fontsize weight:UIFontWeightBold];
    }
    
    // 15px-bold 15px_bold
    if ([fontKey.lowercaseString hasSuffix:@"px-light"] || [fontKey.lowercaseString hasSuffix:@"px_light"]) {
        NSString *fontSize = [fontKey substringToIndex:fontKey.length - 7];
        CGFloat fontsize = fontSize.doubleValue;
        return [UIFont systemFontOfSize:fontsize weight:UIFontWeightLight];
    }
    return nil;
}


@end

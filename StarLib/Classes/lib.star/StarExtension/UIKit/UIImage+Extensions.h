//
//  UIImage+Extensions.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/12.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+ (UIImage *)resizableImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *resizableImage;

+ (UIImage *)originalImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *originalImage;

+ (UIImage *)templateImageNamed:(NSString *)name;
@property (nonatomic, strong, readonly) UIImage *templateImage;

- (UIImage *)equalRatioImageWithMaxWidth:(CGFloat)width;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)roundImageWithColor:(UIColor *)color size:(CGSize)size;

- (UIColor *)colorWithCreatedImage;

- (UIColor *)colorWithPoint:(CGPoint)point;

- (UIImage *)imageWithBrightness:(CGFloat)brightness;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;

@property (nonatomic, strong, readonly) UIImage *(^imageWithAlpha)(CGFloat alpha);

@end


@interface UIColor (StarImageExtension)

@property (nonatomic, strong, readonly) UIImage *solidImage;

@end


@interface StarImageCache : NSObject

+ (instancetype)sharedCache;

- (void)storeImage:(UIImage *)image forColor:(UIColor *)color;

- (UIImage *)imageWithContains:(UIColor *)color;

- (UIImage *)imageFromCacheForColor:(UIColor *)color;

@end

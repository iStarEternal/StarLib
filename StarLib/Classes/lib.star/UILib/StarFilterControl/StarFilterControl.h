//
//  StarFilterControl.h
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "StarFilterPointer.h"

@interface StarFilterControl : UIControl

@property (nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) UIColor *progressColor;
@property (nonatomic, assign, getter=isAllowSlide) BOOL allowSlide;

@property(nonatomic, assign) NSInteger selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;


- (void)setTitlesColor:(UIColor *)color;

- (void)setTitlesFont:(UIFont *)font;

- (void)setPointerColor:(UIColor *)color;

@end

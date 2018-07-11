//
//  StarFilterControl.h
//  StarFilterControl
//
//  Created by Star on 16/10/25.
//  Copyright © 2016年 Star. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PythiaFilterPointer.h"

@interface PythiaFilterControl : UIControl


@property (nonatomic, strong) NSArray *titles;
@property(nonatomic, assign) NSInteger selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@property (nonatomic, weak) PythiaFilterPointer *pointer;

@property (nonatomic, assign) BOOL allowSlide;          // 允许滑动

@property (nonatomic, strong) UIColor *baselineColor;   // 线颜色
@property (nonatomic, assign) BOOL baselineEdgeHidden;  // 线边缘是否隐藏，默认：true
@property (nonatomic, assign) CGFloat baselineHeight;   // 线高，默认：1

@property (nonatomic, strong) UIColor *pointerColor;    // 指示器颜色
@property (nonatomic, strong) UIImage *pointerImage;    // 指示器图标
@property (nonatomic, assign) CGSize pointerSize;       //

@property (nonatomic, strong) UIColor *anchorsColor;    // 锚点颜色
@property (nonatomic, strong) UIImage *anchorsImage;    // 锚点图标
@property (nonatomic, assign) CGSize anchorsSize;

@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIColor *unselectedTitleColor;

@property (nonatomic, strong) UIFont *selectedTitleFont;
@property (nonatomic, strong) UIFont *unselectedTitleFont;

@property (nonatomic, assign) BOOL titleHidden;

@end



/* 用法
 
 StarFilterControl *filterControl = [[StarFilterControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
 [self.contentView addSubview:filterControl];
 self.filterControl = filterControl;
 filterControl.titles        = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
 filterControl.baselineHeight= 2;
 filterControl.pointerColor  = nil;
 filterControl.pointerImage  = @"icon_six_selected".xc_image;
 filterControl.anchorsImage  = @"icon_six_unselected".xc_image;
 filterControl.pointerSize   = filterControl.pointerImage.size;
 filterControl.anchorsSize   = filterControl.anchorsImage.size;
 filterControl.titleHidden   = true;
 
 
 */

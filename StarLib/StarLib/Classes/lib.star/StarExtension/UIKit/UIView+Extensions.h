//
//  UIView+Extensions.h
//  Star
//
//  Created by 星星 on 16/3/21.
//  Copyright © 2016年 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly) CGPoint boundsCenter;

@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


@property (nonatomic, copy, readonly) UIView *(^s_backgroundColor)(UIColor *color);


@end


@interface UIView (Hierarchy)


- (void)bringToFront;

- (void)sendToBack;

- (void)removeSubview:(UIView *)view;

- (void)removeAllSubviews;

@end


@interface UIView (StarBehaviour)

@property (nonatomic, assign, getter=isDisplay) BOOL display;

@end

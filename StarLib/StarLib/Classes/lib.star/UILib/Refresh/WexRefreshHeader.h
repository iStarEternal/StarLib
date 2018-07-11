//
//  WexRefreshHeader.h
//  MJRefreshExample
//
//  Created by Star on 15/4/24.
//  Copyright (c) 2015年 Star. All rights reserved.
//

#import "MJRefreshStateHeader.h"

@interface WexRefreshHeader : MJRefreshStateHeader

@property (nonatomic, weak, readonly) UIImageView *arrowView;
/** 菊花的样式 */
@property (nonatomic, assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property (nonatomic,copy) UIColor *backgroundColor;
@property (nonatomic,copy) UIColor *tintColor;

@end

//
//  StarPagedFlowViewCell.h
//  StarPagedFlowViewDemo
//
//  Created by Star on 16/6/18.
//  Copyright © 2016年 Star. All rights reserved.

#import <UIKit/UIKit.h>

@interface StarPagedFlowViewCell : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@end

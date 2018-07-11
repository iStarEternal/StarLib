//
//  WexLabelCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

typedef NS_ENUM(NSUInteger, WexIconPosition) {
    WexIconPositionLeftTop,
    WexIconPositionLeftMiddle,
};

@interface WexLabelCell : WexTableViewCell

/**
 *  最小行高 default is 44
 */
@property (nonatomic, assign) CGFloat wex_minimumCellHeight;

/**
 *  default is 8
 */
@property (nonatomic, assign) CGFloat wex_topPadding;
/**
 *  defalt is 8
 */
@property (nonatomic, assign) CGFloat wex_bottomPadding;
/**
 *  defalt is 15
 */
@property (nonatomic, assign) CGFloat wex_leftPadding;
/**
 *  default is 15
 */
@property (nonatomic, assign) CGFloat wex_rightPadding;

@property (nonatomic, assign) UIEdgeInsets wex_edgeInsets;


@property (nonatomic, weak) UIView *wex_bgview;
@property (nonatomic, weak) WexLabel *wex_titleLabel;
@property (nonatomic, copy) NSString *wex_title;
@property (nonatomic, copy) UIColor *wex_titleColor;
@property (nonatomic, copy) UIFont *wex_titleFont;


@end

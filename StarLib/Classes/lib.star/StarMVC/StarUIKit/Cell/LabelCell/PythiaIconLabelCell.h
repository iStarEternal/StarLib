//
//  PythiaIconLabelCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/26.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaLabelCell.h"




@interface PythiaIconLabelCell : PythiaLabelCell

/**
 *  默认值： WexIconPositionLeftMiddle
 */
@property (nonatomic, assign) WexIconPosition iconPosition;

/**
 *  图标左边距，默认值是0
 *  如果设置为0，该属性无效，leftPadding生效，
 *  default is 0, 0 is invalid
 */
@property (nonatomic, assign) CGFloat iconHorizontal;

@property (nonatomic, weak) WexImageView *wex_iconView;

@property (nonatomic, strong) UIImage *wex_icon;

// CGSizeZero is invalid, default is CGSizeZero
@property (nonatomic, assign) CGSize wex_iconSize;

@end

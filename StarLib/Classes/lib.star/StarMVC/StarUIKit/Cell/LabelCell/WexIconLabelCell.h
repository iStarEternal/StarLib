//
//  WexIconLabelCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/26.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexLabelCell.h"


@interface WexIconLabelCell : WexLabelCell

/**
 *  default is WexIconPositionLeftMiddle
 */
@property (nonatomic, assign) WexIconPosition iconPosition;

/**
 *  default is 0, 0 is Invalid 
 */
@property (nonatomic, assign) CGFloat iconHorizontal;

@property (nonatomic, weak) WexImageView *wex_iconView;

@property (nonatomic, strong) UIImage *wex_icon;

@end

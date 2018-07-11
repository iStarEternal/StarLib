//
//  WexSeparatorCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

@interface WexSeparatorLayerCell : WexTableViewCell

@property (nonatomic, assign) CGFloat wex_cellHeight;

@property (nonatomic, assign) UIColor *wex_layerColor;

- (instancetype)initWithCellHeight:(CGFloat)height;
@end

//
//  PythiaEmptyCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/22.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

@interface PythiaEmptyCell : WexTableViewCell

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat wex_topMargin;

@end

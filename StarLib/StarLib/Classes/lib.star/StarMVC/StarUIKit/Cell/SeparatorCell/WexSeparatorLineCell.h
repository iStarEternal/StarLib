//
//  WexSeparatorLineCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

@interface WexSeparatorLineCell : WexTableViewCell


@property (nonatomic, assign) CGFloat wex_leftMargin;

@property (nonatomic, strong) UIImage *wex_lineImage;

- (instancetype)initWithLeftMargin:(CGFloat)leftMargin;

@end

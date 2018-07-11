//
//  WexBaseTableViewCell.h
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarExtension.h"
#import "WexView.h"
#import "WexControl.h"
#import "WexLabel.h"
#import "WexImageView.h"
#import "StarExtension.h"

@interface WexTableViewCell : UITableViewCell<WexViewProtocol>

@property (nonatomic, weak)     WexImageView   *wex_separator;
@property (nonatomic, assign)   UIEdgeInsets    wex_separatorEdgeInset;     // Default: top is invalid, left is 15, bottom is 0, right is 0
@property (nonatomic, assign)   CGFloat         wex_separatorHeight;        // Default is 1.f
@property (nonatomic, strong)   UIColor        *wex_separatorColor;         // 默认色：#F4F4F4, rgba(237,237,237,1)
@property (nonatomic, assign, getter=wex_isSeparatorHidden) BOOL wex_separatorHidden;   // Default is true

@property (nonatomic, strong)   UIColor        *wex_backgroundColor;

+ (CGFloat)heightForEntity:(id)entity;

@end

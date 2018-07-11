//
//  WexTableViewHeaderFooterView.h
//  Pythia
//
//  Created by 星星 on 2017/4/12.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarExtension.h"
#import "WexView.h"
#import "WexControl.h"
#import "WexLabel.h"
#import "WexImageView.h"

@interface WexTableViewHeaderFooterView : UITableViewHeaderFooterView<WexViewProtocol>

@property (nonatomic, weak)     WexImageView   *wex_separator;
@property (nonatomic, assign)   UIEdgeInsets    wex_separatorEdgeInset;     // Default: top is invalid, left is 15, bottom is 0, right is 0
@property (nonatomic, assign)   CGFloat         wex_separatorHeight;        // Default is 1.f
@property (nonatomic, strong)   UIColor        *wex_separatorColor;         //
@property (nonatomic, assign, getter=wex_isSeparatorHidden) BOOL wex_separatorHidden;   // Default is true

@property (nonatomic, strong)   UIColor        *wex_backgroundColor;
@end

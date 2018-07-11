//
//  WexTableView.h
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexTableViewCell.h"
#import "UITableView+StarTemplateLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"


@class WexTableView;

@protocol WexTableViewDelegate <NSObject, UITableViewDelegate>

@optional

- (void)wex_tableViewTouchesBegan:(WexTableView *)sender;

@end


@interface WexTableView : UITableView

@property (nonatomic, weak) id<WexTableViewDelegate> delegate;

@end

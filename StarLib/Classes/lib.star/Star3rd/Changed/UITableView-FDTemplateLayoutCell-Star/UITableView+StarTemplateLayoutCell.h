//
//  UITableView+StarTemplateLayoutCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/9/18.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (StarTemplateLayoutCell)


- (CGFloat)fd_heightForCellWithStaticCell:(UITableViewCell *)staticCell configuration:(void (^)(id cell))configuration;

@end

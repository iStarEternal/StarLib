//
//  UITableView+StarTemplateLayoutCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/9/18.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UITableView+StarTemplateLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

@implementation UITableView (StarTemplateLayoutCell)

// Static Cell by Star
- (CGFloat)fd_heightForCellWithStaticCell:(UITableViewCell *)staticCell configuration:(void (^)(id cell))configuration {
    
    if (!staticCell) {
        return 0;
    }
    
    UITableViewCell *templateLayoutCell = staticCell;
    
    // Manually calls to ensure consistent behavior with actual cells. (that are displayed on screen)
    [templateLayoutCell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    return [self fd_systemFittingHeightForConfiguratedCell:templateLayoutCell];
}
@end

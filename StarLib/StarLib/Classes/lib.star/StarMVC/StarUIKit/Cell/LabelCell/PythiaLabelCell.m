//
//  PythiaLabelCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaLabelCell.h"

@implementation PythiaLabelCell

#pragma mark - 页面构造
- (instancetype)init {
    self = [super init];
    if (self) {
        self.wex_backgroundColor = [UIColor clearColor];
        self.wex_minimumCellHeight = 0;
        self.wex_edgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
        self.wex_title = @"";
        self.wex_titleColor = rgba(186,186,186,1);
        self.wex_titleFont = @"13px".xc_font;
    }
    return self;
}
@end








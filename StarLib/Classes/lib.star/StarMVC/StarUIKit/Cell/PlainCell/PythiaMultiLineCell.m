//
//  PythiaMultiLineCell.m
//  Pythia
//
//  Created by 星星 on 2017/5/26.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "PythiaMultiLineCell.h"

@implementation PythiaMultiLineCell


- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.selectionStyle          = 0;
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _titleLabel = label;
        label.textColor     = rgba(35,37,45,1);
        label.font          = @"15px".xc_font;
    }
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _contentLabel = label;
        label.textColor     = rgba(165,165,165,1);
        label.numberOfLines = 0;
        label.font          = @"15px".xc_font;
    }
}


- (void)wex_layoutConstraints {
    
    [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.bottom.lessThanOrEqualTo(-10);
        make.left.equalTo(15);
        make.hugging.priorityRequired();
        make.compression.priorityRequired();
    }];
    
    [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.bottom.lessThanOrEqualTo(-10);
        make.right.equalTo(-15);
        make.centerY.equalTo(0);
        make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(8);
    }];
}

@end

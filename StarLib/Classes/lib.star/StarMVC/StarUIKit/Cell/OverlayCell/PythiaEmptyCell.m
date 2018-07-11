//
//  PythiaEmptyCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/22.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaEmptyCell.h"

@interface PythiaEmptyCell ()

@end


@implementation PythiaEmptyCell

- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _wex_topMargin = 88;
    
    {
        UIImageView *imgV = [[UIImageView alloc] init];
        self.iconImageView = imgV;
        [self.contentView addSubview:imgV];
        imgV.image = @"icon_trade_record_empty".xc_image;
    }
    {
        UILabel *label = [[UILabel alloc] init];
        self.titleLabel = label;
        [self.contentView addSubview:label];
        label.font = @"15px".xc_font;
        label.textColor = rgba(165,165,165,1);
    }
    
}

- (void)wex_layoutConstraints {
    
    [self.iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_wex_topMargin);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
}

- (void)setWex_topMargin:(CGFloat)wex_topMargin {
    _wex_topMargin = wex_topMargin;
    [self wex_layoutConstraints];
}

@end

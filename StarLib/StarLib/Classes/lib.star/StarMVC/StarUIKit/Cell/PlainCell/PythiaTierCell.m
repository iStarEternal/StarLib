//
//  PythiaTierCell.m
//  Pythia
//
//  Created by 星星 on 16/11/22.
//  Copyright © 2016年 weicaifu. All rights reserved.
//

#import "PythiaTierCell.h"


@interface PythiaTierCell()


@end

@implementation PythiaTierCell

- (void)wex_loadViews {
    [super wex_loadViews];
    
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _titleLabel = label;
        label.textColor = @"#383838".xc_color;
        label.font      = @"15px".xc_font;
        label.numberOfLines = 0;
    }
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _contentLabel = label;
        label.textColor = @"#383838".xc_color;
        label.font      = @"15px".xc_font;
    }
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _descLabel = label;
        label.textColor = @"#999999".xc_color;
        label.font      = @"13px".xc_font;
        label.numberOfLines = 0;
        label.minimumScaleFactor = 0.8;
        label.adjustsFontSizeToFitWidth = true;
    }
    
}

- (void)wex_layoutConstraints {
    
    //    [self.contentView remakeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(0);
    //        make.width.equalTo(self.contentView.superview);
    //    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.left.equalTo(15);
        make.width.equalTo(ScreenWidth - 15 - 120);
    }];
    
    [self.contentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(12);
        make.right.equalTo(-15);
        make.hugging.priorityRequired();
        make.compression.priorityRequired();
    }];
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.width.equalTo(ScreenWidth - 30);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
        make.bottom.equalTo(-12);
    }];
}


@end

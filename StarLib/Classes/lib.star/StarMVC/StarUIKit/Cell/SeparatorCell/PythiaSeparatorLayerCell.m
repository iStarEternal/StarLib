//
//  WexSeparatorCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaSeparatorLayerCell.h"


@interface PythiaSeparatorLayerCell ()
{}
@property (nonatomic, weak) WexView *separatorView;
@end

@implementation PythiaSeparatorLayerCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadSeparoator];
    }
    return self;
}

- (instancetype)initWithCellHeight:(CGFloat)height {
    self = [self init];
    if (self) {
        self.wex_cellHeight = height;
    }
    return self;
}

- (void)loadSeparoator {
    
    WexView *separatorView = [[WexView alloc] init];
    [self.contentView addSubview:separatorView];
    self.separatorView = separatorView;
    
    [self.separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(10).priorityHigh();
    }];
}

- (void)setWex_cellHeight:(CGFloat)wex_cellHeight {
    if (self->_wex_cellHeight != wex_cellHeight) {
        self->_wex_cellHeight = wex_cellHeight;
        [self.separatorView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(wex_cellHeight).priorityHigh();
        }];
    }
}

- (UIColor *)wex_layerColor {
    return self.contentView.backgroundColor;
}

- (void)setWex_layerColor:(UIColor *)wex_layerColor {
    self.contentView.backgroundColor = wex_layerColor;
}


@end

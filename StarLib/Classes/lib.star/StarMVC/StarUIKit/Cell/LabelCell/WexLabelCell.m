//
//  WexLabelCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexLabelCell.h"

@implementation WexLabelCell


#pragma mark - 页面构造

// 创建控件
- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.wex_backgroundColor = @"white_color".xc_color;
    
    _wex_minimumCellHeight = 44;
    
    _wex_leftPadding = 15;
    _wex_topPadding = 8;
    _wex_bottomPadding = 8;
    _wex_rightPadding = 15;
    
    
    {
        UIView *v = [[UIView alloc] init];
        self.wex_bgview = v;
        [self.contentView addSubview:v];
    }
    {
        WexLabel *lbl = [[WexLabel alloc] init];
        self.wex_titleLabel = lbl;
        [self.wex_bgview addSubview:lbl];
        lbl.numberOfLines = 0;
        lbl.textAlignment = NSTextAlignmentLeft;
        lbl.adjustsFontSizeToFitWidth = true;
        lbl.minimumScaleFactor = 0.8;
    }
    
    self.wex_title = @"";
    self.wex_titleColor = @"label_strong_color".xc_color;
    self.wex_titleFont = @"label_17px_font".xc_font;
}


// 布局
- (void)wex_layoutConstraints {
    [super wex_layoutConstraints];
    
    [self.wex_bgview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.mas_greaterThanOrEqualTo(self.wex_minimumCellHeight).priorityHigh();
    }];
    
    [self.wex_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wex_leftPadding);
        make.right.equalTo(-self.wex_rightPadding);
        make.top.equalTo(self.wex_topPadding).priorityMedium();
        make.bottom.equalTo(-self.wex_bottomPadding).priorityMedium();
        make.centerY.equalTo(0).priorityLow();
    }];
}


#pragma mark - Getter and Setter

#pragma mark 行

- (void)setWex_minimumCellHeight:(CGFloat)wex_minimumCellHeight {
    _wex_minimumCellHeight = wex_minimumCellHeight;
    [self wex_layoutConstraints];
}


#pragma mark 外边距

- (void)setWex_topPadding:(CGFloat)wex_topPadding {
    self->_wex_topPadding = wex_topPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_bottomPadding:(CGFloat)wex_bottomPadding {
    self->_wex_bottomPadding = wex_bottomPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_leftPadding:(CGFloat)wex_leftPadding {
    self->_wex_leftPadding = wex_leftPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_rightPadding:(CGFloat)wex_rightPadding {
    self->_wex_rightPadding = wex_rightPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_edgeInsets:(UIEdgeInsets)wex_edgeInsets {
    self.wex_topPadding = wex_edgeInsets.top;
    self.wex_leftPadding = wex_edgeInsets.left;
    self.wex_bottomPadding = wex_edgeInsets.bottom;
    self.wex_rightPadding = wex_edgeInsets.right;
}

- (UIEdgeInsets)wex_edgeInsets {
    return UIEdgeInsetsMake(self.wex_topPadding, self.wex_leftPadding, self.wex_bottomPadding, self.wex_rightPadding);
}

#pragma mark 属性

- (NSString *)wex_title {
    return self.wex_titleLabel.text;
}

- (void)setWex_title:(NSString *)wex_title {
    self.wex_titleLabel.text = wex_title;
}

- (UIColor *)wex_titleColor {
    return self.wex_titleLabel.textColor;
}

- (void)setWex_titleColor:(UIColor *)wex_titleColor {
    self.wex_titleLabel.textColor = wex_titleColor;
}

- (UIFont *)wex_titleFont {
    return self.wex_titleLabel.font;
}

- (void)setWex_titleFont:(UIFont *)wex_titleFont {
    self.wex_titleLabel.font = wex_titleFont;
}

@end








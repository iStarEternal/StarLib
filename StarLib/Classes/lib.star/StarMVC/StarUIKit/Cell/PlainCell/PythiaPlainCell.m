//
//  PythiaPlainCell.m
//  Pythia
//
//  Created by 星星 on 16/11/22.
//  Copyright © 2016年 weicaifu. All rights reserved.
//

#import "PythiaPlainCell.h"


static void *PythiaPlainCellLeftImageChanged   = &PythiaPlainCellLeftImageChanged;
static void *PythiaPlainCellRightImageChanged  = &PythiaPlainCellRightImageChanged;

@interface PythiaPlainCell()


@end

@implementation PythiaPlainCell

- (void)wex_loadViews {
    [super wex_loadViews];
    
    _wex_cellHeight = 44;
    _wex_rightSpace = 8;
    
    {
        WexImageView *imgv = [[WexImageView alloc] init];
        [self.contentView addSubview:imgv];
        _leftImageView = imgv;
    }
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _titleLabel = label;
        label.textColor = rgba(35,37,45,1);
        label.font      = @"15px".xc_font;
    }
    {
        WexLabel *label = [[WexLabel alloc] init];
        [self.contentView addSubview:label];
        _contentLabel = label;
        label.textColor = rgba(165,165,165,1);
        label.font      = @"15px".xc_font;
    }
    {
        WexImageView *imgv = [[WexImageView alloc] init];
        [self.contentView addSubview:imgv];
        _rightImageView = imgv;
    }
    
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"leftImageView.image" options:options context:PythiaPlainCellLeftImageChanged];
    [self addObserver:self forKeyPath:@"rightImageView.image" options:options context:PythiaPlainCellRightImageChanged];
}

- (void)wex_layoutConstraints {
    
    [self.contentView remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.height.greaterThanOrEqualTo(self.wex_cellHeight);
        make.width.equalTo(self.contentView.superview);
    }];
    
    // 左侧
    [self.leftImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(15);
    }];
    
    if (self.leftView) {
        self.leftView.hidden = false;
        self.leftImageView.hidden = true;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftView.mas_right).offset(8);
            make.centerY.equalTo(0);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
        
        [self.leftView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
        }];
    }
    else if (self.leftImageView.image) {
        self.leftView.hidden = true;
        self.leftImageView.hidden = false;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImageView.mas_right).offset(8);
            make.centerY.equalTo(0);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
    }
    else {
        self.leftView.hidden = true;
        self.leftImageView.hidden = true;
        [self.titleLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(15);
            make.centerY.equalTo(0);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
    }
    
    
    // 右侧
    [self.rightImageView remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.right.equalTo(-self.wex_rightSpace);
    }];
    
    if (self.rightView) {
        self.rightImageView.hidden = true;
        self.rightView.hidden = false;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(self.rightView.mas_left).offset(-8);
        }];
        
        [self.rightView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.right.equalTo(-self.wex_rightSpace);
        }];
    }
    else if (self.rightImageView.image) {
        self.rightImageView.hidden = true;
        self.rightImageView.hidden = false;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(self.rightImageView.mas_left).offset(-8);
        }];
    }
    else {
        self.rightView.hidden = true;
        self.rightImageView.hidden = true;
        [self.contentLabel remakeConstraints:^(MASConstraintMaker *make) {
            make.top.greaterThanOrEqualTo(8);
            make.bottom.lessThanOrEqualTo(-8);
            make.left.greaterThanOrEqualTo(self.titleLabel.mas_right).offset(15);
            make.centerY.equalTo(0);
            make.right.equalTo(-15);
        }];
    }
}

- (void)setWex_cellHeight:(CGFloat)wex_cellHeight {
    _wex_cellHeight = wex_cellHeight;
    [self wex_layoutConstraints];
}

- (void)setWex_rightSpace:(CGFloat)wex_rightSpace {
    _wex_rightSpace = wex_rightSpace;
    [self wex_layoutConstraints];
}

- (void)setLeftView:(UIView *)leftView {
    if (_leftView) {
        [_leftView removeFromSuperview];
    }
    _leftView = leftView;
    [self.contentView addSubview:leftView];
    [self wex_layoutConstraints];
}

- (void)setRightView:(UIView *)rightView {
    if (_rightView) {
        [_rightView removeFromSuperview];
    }
    _rightView = rightView;
    [self.contentView addSubview:rightView];
    [self wex_layoutConstraints];
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == PythiaPlainCellLeftImageChanged || context == PythiaPlainCellRightImageChanged) {
        [self wex_layoutConstraints];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"leftImageView.image" context:PythiaPlainCellLeftImageChanged];
    [self removeObserver:self forKeyPath:@"rightImageView.image" context:PythiaPlainCellRightImageChanged];
}

@end

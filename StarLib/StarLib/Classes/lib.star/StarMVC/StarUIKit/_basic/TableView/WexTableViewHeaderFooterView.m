//
//  WexTableViewHeaderFooterView.m
//  Pythia
//
//  Created by 星星 on 2017/4/12.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexTableViewHeaderFooterView.h"

@implementation WexTableViewHeaderFooterView


- (void)awakeFromNib {
    [self wex_loadViews];
    [self wex_layoutConstraints];
    [super awakeFromNib];
}


#pragma mark - 构造函数

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self wex_loadViews];
        [self wex_layoutConstraints];
    }
    return self;
}



#pragma mark - Subview处理函数

- (void)wex_loadViews {

    self.contentView.backgroundColor = [UIColor clearColor];
    
    _wex_separatorColor = [UIColor colorWithRGB:0xF4F4F4];
    _wex_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _wex_separatorHeight = 1.f;
    
    WexImageView *wex_separator = [[WexImageView alloc] init];
    [self.contentView addSubview:wex_separator];
    _wex_separator = wex_separator;
    _wex_separator.image = self.wex_separatorColor.solidImage;
    [self.wex_separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wex_separatorEdgeInset.left);
        make.right.equalTo(-self.wex_separatorEdgeInset.right);
        make.bottom.equalTo(-self.wex_separatorEdgeInset.bottom);
        make.height.equalTo(self.wex_separatorHeight).priorityHigh();
    }];
    
    self.wex_separatorHidden = true;
}

- (void)wex_layoutConstraints {
    
}


#pragma mark - Getter Setter

- (UIColor *)wex_backgroundColor {
    return self.contentView.backgroundColor;
}

- (void)setWex_backgroundColor:(UIColor *)wex_backgroundColor {
    self.contentView.backgroundColor = wex_backgroundColor;
}

- (void)setWex_separatorHidden:(BOOL)wex_separatorHidden {
    self->_wex_separatorHidden = wex_separatorHidden;
    self.wex_separator.hidden = wex_separatorHidden;
}

- (void)setWex_separatorEdgeInset:(UIEdgeInsets)wex_separatorEdgeInset {
    _wex_separatorEdgeInset = wex_separatorEdgeInset;
    [self.wex_separator updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wex_separatorEdgeInset.left);
        make.right.equalTo(-wex_separatorEdgeInset.right);
        make.bottom.equalTo(-wex_separatorEdgeInset.bottom);
    }];
}

- (void)setWex_separatorHeight:(CGFloat)wex_separatorHeight {
    _wex_separatorHeight = wex_separatorHeight;
    [self.wex_separator updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.wex_separatorHeight).priorityHigh();
    }];
}

- (void)setWex_separatorColor:(UIColor *)wex_separatorColor {
    _wex_separatorColor = wex_separatorColor;
    self.wex_separator.image = wex_separatorColor.solidImage;
}


@end

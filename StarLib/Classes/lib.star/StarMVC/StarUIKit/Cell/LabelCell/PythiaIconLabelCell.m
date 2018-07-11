//
//  PythiaIconLabelCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/26.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaIconLabelCell.h"

@interface PythiaIconLabelCell ()
@property (nonatomic, strong) MASConstraint *titleCenterXConstaint;
@end

@implementation PythiaIconLabelCell


- (void)wex_loadViews {
    [super wex_loadViews];
    self.wex_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    WexImageView *wex_iconView = [[WexImageView alloc] init];
    [self.wex_bgview addSubview:wex_iconView];
    self.wex_iconView = wex_iconView;
    
    _iconPosition = WexIconPositionLeftMiddle;
    _iconHorizontal = 0;
}

- (void)wex_layoutConstraints {
    [super wex_layoutConstraints];
    
    switch (self.iconPosition) {
            
        case WexIconPositionLeftTop: {
            
            [self.wex_iconView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.wex_leftPadding);
                make.top.equalTo(self.wex_titleLabel.mas_top).offset(1);
                if (!CGSizeEqualToSize(CGSizeZero, self.wex_iconSize)) {
                    make.size.equalTo(self.wex_iconSize);
                }
                make.compression.priorityRequired();
                make.hugging.priorityHigh();
            }];
            [self.wex_titleLabel remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wex_iconView.mas_right).offset(8);
                make.right.equalTo(-self.wex_rightPadding);
                make.top.equalTo(self.wex_topPadding);
                make.bottom.equalTo(-self.wex_bottomPadding);
                self.titleCenterXConstaint = make.centerX.equalTo(0);
                make.centerY.equalTo(0).priorityLow();
            }];
        }
            break;
            
        case WexIconPositionLeftMiddle: {
            
            [self.wex_iconView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.wex_leftPadding);
                make.centerY.equalTo(self.wex_titleLabel.mas_centerY).offset(0);
                if (!CGSizeEqualToSize(CGSizeZero, self.wex_iconSize)) {
                    make.size.equalTo(self.wex_iconSize);
                }
                make.compression.priorityRequired();
                make.hugging.priorityHigh();
            }];
            
            [self.wex_titleLabel remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wex_iconView.mas_right).offset(8);
                make.right.equalTo(-self.wex_rightPadding);
                make.top.equalTo(self.wex_topPadding);
                make.bottom.equalTo(-self.wex_bottomPadding);
                self.titleCenterXConstaint = make.centerX.equalTo(0);
                make.centerY.equalTo(0).priorityLow();
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
    if (self.iconHorizontal) {
        [self.wex_iconView updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconHorizontal);
        }];
        self.wex_titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.titleCenterXConstaint uninstall];
    }
    else {
        [self.wex_iconView updateConstraints:^(MASConstraintMaker *make) {
            make.left.greaterThanOrEqualTo(self.wex_leftPadding);
        }];
        self.wex_titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleCenterXConstaint install];
    }
    
    
}


- (UIImage *)wex_icon {
    return self.wex_iconView.image;
}

- (void)setWex_icon:(UIImage *)wex_icon {
    self.wex_iconView.image = wex_icon;
    [self wex_layoutConstraints];
}

- (void)setWex_iconSize:(CGSize)wex_iconSize {
    _wex_iconSize = wex_iconSize;
    [self wex_layoutConstraints];
}

- (void)setIconPosition:(WexIconPosition)iconPosition {
    self->_iconPosition = iconPosition;
    [self wex_layoutConstraints];
}

- (void)setIconHorizontal:(CGFloat)iconHorizontal {
    self->_iconHorizontal = iconHorizontal;
    [self wex_layoutConstraints];
}

@end

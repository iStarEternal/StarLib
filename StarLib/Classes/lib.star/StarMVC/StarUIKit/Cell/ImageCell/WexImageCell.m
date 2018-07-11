//
//  WexImageCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/11.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexImageCell.h"

@interface WexImageCell ()



@end


@implementation WexImageCell

- (void)wex_loadViews {
    [super wex_loadViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _alignment = WexImageCellAlignmentFill;
    _wex_imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView];
    self.wex_imageView = imgView;
    
}

- (void)wex_layoutConstraints {
    
    switch (self.alignment) {
            
        case WexImageCellAlignmentLeft: {
            [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wex_imageEdgeInsets.left).priorityHigh();
                make.right.lessThanOrEqualTo(-self.wex_imageEdgeInsets.right);
                make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case WexImageCellAlignmentCenter: {
            [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.wex_imageEdgeInsets.left);
                make.right.lessThanOrEqualTo(-self.wex_imageEdgeInsets.right);
                make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
                make.centerX.equalTo(0).priorityHigh();
            }];
        }
            break;
            
        case WexImageCellAlignmentRight: {
            [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.greaterThanOrEqualTo(self.wex_imageEdgeInsets.left);
                make.right.equalTo(-self.wex_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case WexImageCellAlignmentFill: {
            [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wex_imageEdgeInsets.left).priorityHigh();
                make.right.equalTo(-self.wex_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        case WexImageCellAlignmentExtend: {
            [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.wex_imageEdgeInsets.left).priorityHigh();
                make.right.equalTo(-self.wex_imageEdgeInsets.right).priorityHigh();
                make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
                make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
            }];
        }
            break;
            
        default:
            break;
    }
    if (self.wex_image && self.alignment != WexImageCellAlignmentExtend) {
        CGFloat ratio = self.wex_image.size.height / self.wex_image.size.width;
        [self.wex_imageView updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.wex_imageView.mas_width).multipliedBy(ratio);
        }];
    }
    
    if (self.alignment == WexImageCellAlignmentExtend) {
        [self.wex_imageView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wex_imageEdgeInsets.left).priorityHigh();
            make.right.equalTo(-self.wex_imageEdgeInsets.right).priorityHigh();
            make.top.equalTo(self.wex_imageEdgeInsets.top).priorityHigh();
            make.bottom.equalTo(-self.wex_imageEdgeInsets.bottom).priorityHigh();
        }];
    }
}


- (UIImage *)wex_image {
    return self.wex_imageView.image;
}

- (void)setWex_image:(UIImage *)wex_image {
    self.wex_imageView.image = wex_image;
    [self wex_layoutConstraints];
}

- (void)setAlignment:(WexImageCellAlignment)alignment {
    _alignment = alignment;
    [self wex_layoutConstraints];
}

- (void)setWex_imageEdgeInsets:(UIEdgeInsets)wex_imageEdgeInsets {
    _wex_imageEdgeInsets = wex_imageEdgeInsets;
    [self wex_layoutConstraints];
}

@end

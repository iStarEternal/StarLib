//
//  WexSeparatorLineCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexSeparatorLineCell.h"

@interface WexSeparatorLineCell ()

@property (nonatomic, weak) WexImageView *wex_lineImageView;

@end


@implementation WexSeparatorLineCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = @"white_color".xc_color;
        [self loadLineImageView];
        self.wex_lineImage = @"cell_separator_line_bottom".xc_image;
    }
    return self;
}

- (instancetype)initWithLeftMargin:(CGFloat)leftMargin {
    self = [super init];
    if (self) {
        self.wex_leftMargin = leftMargin;
    }
    return self;
}

- (void)loadLineImageView {
    
    WexImageView *imageView = [[WexImageView alloc] init];
    [self.contentView addSubview:imageView];
    
    self.wex_lineImageView = imageView;
    
    [self.wex_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1).priorityHigh();
    }];
}

- (void)setWex_leftMargin:(CGFloat)wex_leftMargin {
    self->_wex_leftMargin = wex_leftMargin;
    [self.wex_lineImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(wex_leftMargin);
    }];
}

- (UIImage *)wex_lineImage {
    return self.wex_lineImageView.image;
}

- (void)setWex_lineImage:(UIImage *)wex_lineImage {
    self.wex_lineImageView.image = wex_lineImage;
    
}

@end

//
//  StarPagedFlowViewCell.m
//  StarPagedFlowViewDemo
//
//  Created by Star on 16/6/18.
//  Copyright © 2016年 Star. All rights reserved.

#import "StarPagedFlowViewCell.h"

@implementation StarPagedFlowViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
    }
    return self;
}

- (UIImageView *)mainImageView {
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] initWithFrame:self.bounds];
        // _coverView.backgroundColor = [UIColor blackColor];
    }
    return _coverView;
}

@end

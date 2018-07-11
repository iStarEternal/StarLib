//
//  WexView.m
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexControl.h"

@implementation WexControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self wex_loadViews];
        [self wex_layoutConstraints];
    }
    return self;
}




#pragma mark - Subview处理函数

- (void)wex_loadViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (void)wex_layoutConstraints {
    
}


@end

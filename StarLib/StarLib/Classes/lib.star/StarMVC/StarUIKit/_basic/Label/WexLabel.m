//
//  WexLabel.m
//  WeXFin
//
//  Created by Mark on 15/7/16.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexLabel.h"

@implementation WexLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        // iOS6默认不是透明色，这里强制设置
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (void)layoutSubviews {
    // 固定宽度，高度自适应，iOS8以下需要
    self.preferredMaxLayoutWidth = self.frame.size.width;
    [super layoutSubviews];
}

@end

//
//  WexTableView.m
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexTableView.h"

@implementation WexTableView

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    // 转发点击事件
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_tableViewTouchesBegan:)]) {
        [self.delegate wex_tableViewTouchesBegan:self];
    }
}

@end

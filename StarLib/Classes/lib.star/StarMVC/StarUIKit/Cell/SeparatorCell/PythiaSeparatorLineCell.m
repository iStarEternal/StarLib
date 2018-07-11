//
//  PythiaSeparatorLineCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaSeparatorLineCell.h"

@interface WexDashLine : UIView

@property (nonatomic, strong) UIColor *color;

@end

@implementation WexDashLine

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context, rect.size.height);
    CGContextSetStrokeColorWithColor(context, self.color.CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    
    CGContextMoveToPoint(context, 0, CGRectGetHeight(rect) * 0.5);
    CGContextAddLineToPoint(context, rect.size.width, CGRectGetHeight(rect) * 0.5);
    
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end


@interface PythiaSeparatorLineCell ()

@end


@implementation PythiaSeparatorLineCell

@dynamic wex_separatorHeight;


- (void)wex_loadViews {
    [super wex_loadViews];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.wex_separatorHidden = false;
}

- (void)wex_layoutConstraints {
    
    [self.wex_separator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wex_separatorEdgeInset.left);
        make.right.equalTo(-self.wex_separatorEdgeInset.right);
        make.top.equalTo(self.wex_separatorEdgeInset.top).priorityMedium();
        make.bottom.equalTo(-self.wex_separatorEdgeInset.bottom);
        make.height.equalTo(self.wex_separatorHeight).priority(1000);
    }];
    
    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(0);
        make.width.equalTo(self.contentView.superview);
        make.height.greaterThanOrEqualTo(1);
    }];
}

- (void)setWex_separatorHeight:(CGFloat)wex_separatorHeight {
    super.wex_separatorHeight = wex_separatorHeight;
    [self wex_layoutConstraints];
}

@end

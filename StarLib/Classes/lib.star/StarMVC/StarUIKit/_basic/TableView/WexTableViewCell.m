//
//  WexBaseTableViewCell.m
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

#import <objc/runtime.h>

@interface WexTableViewCell ()

@end

@implementation WexTableViewCell

- (void)awakeFromNib {
    [self wex_loadViews];
    [self wex_layoutConstraints];
    [super awakeFromNib];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (!self.wex_isSeparatorHidden && self.selectionStyle != UITableViewCellSelectionStyleNone) {
        NSTimeInterval duration = animated ? 0.25 : 0.;
        [UIView animateWithDuration:duration delay:0. options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.wex_separator.alpha = highlighted ? 0.1 : 1.;
        } completion:^(BOOL finished) {}];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (!self.wex_isSeparatorHidden && self.selectionStyle != UITableViewCellSelectionStyleNone) {
        
        NSTimeInterval duration = animated ? 0.25 : 0.;
        [UIView animateWithDuration:duration delay:0. options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.wex_separator.alpha = selected ? 0.1 : 1.;
        } completion:^(BOOL finished) {}];
    }
}

#pragma mark - 构造函数

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self wex_loadViews];
        [self wex_layoutConstraints];
    }
    return self;
}



#pragma mark - Subview处理函数

- (void)wex_loadViews {
    
//    UIView *bview = [[UIView alloc] init];
//    [self.contentView addSubview:bview];
//    bview.hidden = true;
//
//    [self.contentView makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(0);
//    }];
//
//
    self.backgroundColor = [UIColor clearColor];
    
    _wex_separatorColor = [UIColor colorWithRGB:0xF4F4F4];
    _wex_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _wex_separatorHeight = .5f;
    
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
    [self.wex_separator bringToFront];
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
        make.height.equalTo(self.wex_separatorHeight).priority(1000);
    }];
}

- (void)setWex_separatorColor:(UIColor *)wex_separatorColor {
    _wex_separatorColor = wex_separatorColor;
    self.wex_separator.image = wex_separatorColor.solidImage;
}

+ (CGFloat)heightForEntity:(id)entity {
    return 44;
}


// 钩子
+ (void)load {
    
    // 因为10.2中存在计算高度的bug，所以特意加上钩子添加约束
    SEL originalSelector = @selector(systemLayoutSizeFittingSize:);
    SEL swizzledSelector = NSSelectorFromString([@"star_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
    Method originalMethod = class_getInstanceMethod(UIView.class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(UIView.class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}




@end

// Version比较: sv: system_version tv: targer_version
#define VERSION_GREATER(sv, tv) ({\
NSArray *sr = [sv componentsSeparatedByString:@"."];\
NSArray *tr = [tv componentsSeparatedByString:@"."];\
NSInteger s1 = sr.count > 0 ? [sr[0] integerValue] : 0;\
NSInteger s2 = sr.count > 1 ? [sr[1] integerValue] : 0;\
NSInteger s3 = sr.count > 2 ? [sr[2] integerValue] : 0;\
NSInteger t1 = tr.count > 0 ? [tr[0] integerValue] : 0;\
NSInteger t2 = tr.count > 1 ? [tr[1] integerValue] : 0;\
NSInteger t3 = tr.count > 2 ? [tr[2] integerValue] : 0;\
s1 != t1 ? (s1 > t1) : s2 != t2 ? (s2 > t2) : s3 > t3;\
}) // sv > tv
#define VESSION_LESS(sv, tv) VERSION_GREATER(tv, sv) // sv < tv
#define VERSION_GREATER_OR_EQUAL(sv, tv) ([sv isEqualToString:tv] || VERSION_GREATER(sv, tv))  // sv >= tv
#define VESSION_LESS_OR_EQUAL(sv, tv) ([sv isEqualToString:tv] || VESSION_LESS(sv, tv))        // sv <= tv

@implementation UIView (swizzled)

- (CGSize)star_systemLayoutSizeFittingSize:(CGSize)targetSize {
    NSString *sversion = [UIDevice currentDevice].systemVersion; //sversion = @"10.2.9";
    
    // 系统版本>=10.2 并且<10.3, 并且是WexTableCell的contentView
    if (VERSION_GREATER_OR_EQUAL(sversion, @"10.2") && VESSION_LESS(sversion, @"10.3")
        && [self.superview isKindOfClass:[WexTableViewCell class]]
        && [self isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        
        __block MASConstraint *width = nil;
        [self makeConstraints:^(MASConstraintMaker *make) {
            width = make.width.equalTo(UIScreen.mainScreen.bounds.size.width);
        }];
        // NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:];
        CGSize size = [self star_systemLayoutSizeFittingSize:targetSize];
        [width uninstall];
        return size;
    }
    return [self star_systemLayoutSizeFittingSize:targetSize];
}


@end




//
//  PythiaLinkCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaLinkCell.h"
#import "PythiaLinkString.h"



static void *PythiaLinkCellFrameChanged = &PythiaLinkCellFrameChanged;

@interface PythiaLinkCell()

@property (nonatomic, strong) NSAttributedString *richContent;

@end

@implementation PythiaLinkCell


#pragma mark - 析构函数

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame" context:PythiaLinkCellFrameChanged];
}


#pragma mark - 页面构造

- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _wex_minimumCellHeight = 44;
    
    _wex_leftPadding = 15;
    _wex_topPadding = 8;
    _wex_bottomPadding = 8;
    _wex_rightPadding = 15;
    
    
    UILabel *autoLayoutLabel = [[UILabel alloc] init];
    [self.contentView addSubview:autoLayoutLabel];
    self.autoLayoutLabel = autoLayoutLabel;
    self.autoLayoutLabel.numberOfLines = 0;
    self.autoLayoutLabel.hidden = true;
    
    YYLabel *richLabel = [[YYLabel alloc] init];
    [self.contentView addSubview:richLabel];
    self.richLabel = richLabel;
    self.richLabel.numberOfLines = 0;
    self.richLabel.textVerticalAlignment = YYTextVerticalAlignmentCenter;
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:@"frame" options:options context:PythiaLinkCellFrameChanged];
    
}

- (void)wex_layoutConstraints {
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.equalTo(self.contentView.superview);
        make.height.mas_greaterThanOrEqualTo(self.wex_minimumCellHeight).priorityHigh();
    }];
    
    [self.autoLayoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wex_leftPadding);
        make.right.equalTo(-self.wex_rightPadding);
        make.top.equalTo(self.wex_topPadding).priorityMedium();
        make.bottom.equalTo(-self.wex_bottomPadding).priorityMedium();
        make.centerY.equalTo(0).priorityLow();
    }];
    
    [self.richLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.autoLayoutLabel).offset(0);
    }];
}



#pragma mark - Getter and Setter

#pragma mark 行

- (void)setWex_minimumCellHeight:(CGFloat)wex_minimumCellHeight {
    _wex_minimumCellHeight = wex_minimumCellHeight;
    [self wex_layoutConstraints];
}


#pragma mark 外边距

- (void)setWex_topPadding:(CGFloat)wex_topPadding {
    self->_wex_topPadding = wex_topPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_bottomPadding:(CGFloat)wex_bottomPadding {
    self->_wex_bottomPadding = wex_bottomPadding;
    [self wex_layoutConstraints];
}

- (void)setWex_leftPadding:(CGFloat)wex_leftPadding {
    self->_wex_leftPadding = wex_leftPadding;
    [self wex_layoutConstraints];
}










#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.richLabel && self.richContent && self.richLabel.width) {
        
        YYTextLinePositionSimpleModifier *modifier = [[YYTextLinePositionSimpleModifier alloc] init];
        modifier.fixedLineHeight = 20;
        YYTextContainer *container = [[YYTextContainer alloc] init];
        container.size = CGSizeMake(self.richLabel.width, CGFLOAT_MAX);
        container.linePositionModifier = modifier;
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self.richContent];
        self.richLabel.textLayout = layout;
    }
}



#pragma mark - Setter And Getter

- (NSMutableArray *)attrStringArray {
    if (!_attrStringArray) {
        _attrStringArray = [NSMutableArray array];
    }
    return _attrStringArray;
}



#pragma mark - RichString 操作

- (void)appendNormalText:(NSString *)text {
    [self appendRichStringWithText:text textColor:@"#999999".xc_color textFont:@"13px".xc_font isLink:false linkFlag:nil];
}

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag {
    [self appendRichStringWithText:text textColor:@"#2D99FA".xc_color textFont:@"13px".xc_font isLink:true linkFlag:linkFlag];
}

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font {
    [self appendRichStringWithText:text textColor:textColor textFont:font isLink:false linkFlag:nil];
}

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag {
    
    PythiaLinkString *richString = [[PythiaLinkString alloc] init];
    richString.string = text;
    richString.color = textColor;
    richString.font = font;
    richString.isLink = isLink;
    richString.linkFlag = linkFlag;
    [self appendRichString:richString];
}

- (void)appendButton:(UIButton *)button font:(UIFont *)font {
    PythiaLinkString *richString = [[PythiaLinkString alloc] init];
    richString.font = font;
    richString.button = button;
    [self appendRichString:richString];
}

- (void)appendRichString:(PythiaLinkString *)richString {
    [self.attrStringArray addObject:richString];
    self.richContent = [self createAttributedStringWithAttributedStringArray:[self.attrStringArray copy]];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}


- (void)removeRichString {
    [self.attrStringArray removeAllObjects];
    self.richContent = [[NSAttributedString alloc] init];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}



#pragma mark - 创建 AttributedString

- (NSAttributedString *)createAttributedStringWithAttributedStringArray:(NSArray *)attributedStringArray {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    
    for (PythiaLinkString *richString in attributedStringArray) {
        
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] init];
        
        if (richString.string) {
            [attrString yy_appendString:richString.string];
        }
        if (richString.color) {
            attrString.yy_color = richString.color;
        }
        if (richString.font) {
            attrString.yy_font = richString.font;
        }
        if (richString.isLink) {
            __weak typeof(self) weakSelf = self;
            
            NSString *linkFlag = richString.linkFlag;
            YYTextHighlight *highlight = [[YYTextHighlight alloc] init];
            highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
                [weakSelf handleAttributedStringLinkTapWithLinkFlag:linkFlag];
            };
            [attrString yy_setTextHighlight:highlight range:attrString.yy_rangeOfAll];
        }
        if (richString.button) {
            attrString = [NSMutableAttributedString yy_attachmentStringWithContent:richString.button contentMode:UIViewContentModeBottom attachmentSize:richString.button.size alignToFont:richString.font alignment:YYTextVerticalAlignmentCenter];
        }
        
        
        [string appendAttributedString:attrString];
    }
    
    string.yy_minimumLineHeight = 20;
    return [string copy];
}



#pragma mark - Handle

- (void)handleAttributedStringLinkTapWithLinkFlag:(NSString *)linkFlag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(linkCell:didSelectLinkWithFlag:)]) {
        [self.delegate linkCell:self didSelectLinkWithFlag:linkFlag];
    }
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == PythiaLinkCellFrameChanged) {
        [self layoutSubviews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




@end








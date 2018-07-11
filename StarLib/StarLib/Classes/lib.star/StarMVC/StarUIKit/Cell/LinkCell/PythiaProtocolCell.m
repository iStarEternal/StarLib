//
//  PythiaProtocolCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "PythiaProtocolCell.h"

static void *FrameChanged = &FrameChanged;


@interface PythiaProtocolCell()

@property (nonatomic, strong) NSAttributedString *richContent;

@end


@implementation PythiaProtocolCell

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"frame" context:FrameChanged];
}


#pragma mark - 页面构造

- (void)wex_loadViews {
    [super wex_loadViews];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WexCheckButton *checkButton = [[WexCheckButton alloc] init];
    [self.contentView addSubview:checkButton];
    
    self.wex_checkButton = checkButton;
    self.wex_checkButton.checkedImage = @"icon_checked".xc_image;
    self.wex_checkButton.uncheckedImage = @"icon_unchecked".xc_image;
    [self.wex_checkButton addTarget:self action:@selector(handleCheckButtonCheckedChanged:) forControlEvents:UIControlEventTouchUpInside];
    
    WexLabel *autoLayoutLabel = [[WexLabel alloc] init];
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
    [self addObserver:self forKeyPath:@"frame" options:options context:FrameChanged];
}

- (void)wex_layoutConstraints {
    [self.wex_checkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.height.equalTo(16 + 14);
        make.width.equalTo(16 + 14);
        make.centerY.equalTo(self.autoLayoutLabel.mas_top).offset(11);
        // make.top.equalTo(self.autoLayoutLabel.mas_top).offset(-2);
    }];
    
    [self.autoLayoutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.wex_checkButton.mas_right).offset(1);
        make.right.mas_equalTo(-15);
        make.top.equalTo(8);
        make.bottom.equalTo(-8);
    }];
}



#pragma mark - Setter And Getter

- (NSMutableArray *)attrStringArray {
    if (!_attrStringArray) {
        _attrStringArray = [NSMutableArray array];
    }
    return _attrStringArray;
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
                [weakSelf handleLinkTapWithText:text flag:linkFlag];
            };
            [attrString yy_setTextHighlight:highlight range:attrString.yy_rangeOfAll];
        }
        [string appendAttributedString:attrString];
    }
    
    string.yy_minimumLineHeight = 20;
    return [string copy];
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.richLabel && self.richContent && self.autoLayoutLabel.width) {
        
        self.richLabel.frame = self.autoLayoutLabel.frame;
        
        YYTextLinePositionSimpleModifier *modifier = [[YYTextLinePositionSimpleModifier alloc] init];
        modifier.fixedLineHeight = 20;
        YYTextContainer *container = [[YYTextContainer alloc] init];
        container.size = CGSizeMake(self.autoLayoutLabel.width, CGFLOAT_MAX);
        container.linePositionModifier = modifier;
        YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:self.richContent];
        self.richLabel.textLayout = layout;
        
    }
}



#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == FrameChanged) {
        [self layoutSubviews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}








#pragma mark - Handle

- (void)handleCheckButtonCheckedChanged:(WexCheckButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_protocolCell:didSelectCheckButtonWithChecked:)]) {
        [self.delegate wex_protocolCell:self didSelectCheckButtonWithChecked:sender.checked];
    }
}

- (void)handleLinkTapWithText:(NSAttributedString *)text flag:(NSString *)flag {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_protocolCell:didSelectLink:flag:)]) {
        [self.delegate wex_protocolCell:self didSelectLink:text.string flag:flag];
    }
}


#pragma mark - RichString 操作

- (void)appendNormalText:(NSString *)text {
    [self appendRichStringWithText:text textColor:rgba(186,186,186,1) textFont:@"13px".xc_font isLink:false linkFlag:nil];
}

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag {
    [self appendRichStringWithText:text textColor:rgba(0,148,236,1) textFont:@"13px".xc_font isLink:true linkFlag:linkFlag];
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

- (void)appendRichString:(PythiaLinkString *)richString {
    [self.attrStringArray addObject:richString];
    self.richContent = [self createAttributedStringWithAttributedStringArray:[self.attrStringArray copy]];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}

- (void)clean {
    [self.attrStringArray removeAllObjects];
    self.richContent = [[NSAttributedString alloc] init];
    self.richLabel.attributedText = self.richContent;
    self.autoLayoutLabel.attributedText = self.richContent;
}



@end

//
//  WexSegmentedCell.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexSegmentedCell.h"

@interface WexSegmentedCell ()
{}

@end

@implementation WexSegmentedCell


- (void)wex_loadViews {
    [super wex_loadViews];
    
    _selectedFont = @"15px".xc_font;
    _selectedColor = @"#ffb824".xc_color;
    
    _normalFont = @"15px".xc_font;
    _normalColor = @"#666666".xc_color;
    
    _selectionIndicatorColor = @"#ffb824".xc_color;
    
    self.selectionStyle = 0;
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] init];
    [self.contentView addSubview:segmentedControl];
    
    self.wex_segmentedControl = segmentedControl;
    self.wex_segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.wex_segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.wex_segmentedControl.selectionIndicatorHeight = 2;
    self.wex_segmentedControl.borderColor   = @"#ECEEF0".xc_color;
    self.wex_segmentedControl.borderType    = HMSegmentedControlBorderTypeBottom;
    self.wex_segmentedControl.borderWidth   = 0.5;

    [self setStyle];
}

- (void)wex_layoutConstraints {
    [self.wex_segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
        make.height.mas_equalTo(44).priorityHigh();
    }];
}

- (void)setWex_sectionTitles:(NSArray *)wex_sectionTitles {
    self.wex_segmentedControl.sectionTitles = wex_sectionTitles;
}

- (NSArray *)wex_sectionTitles {
    return self.wex_segmentedControl.sectionTitles;
}

- (IndexChangeBlock)indexChangeBlock {
    return self.wex_segmentedControl.indexChangeBlock;
}

- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock {
    self.wex_segmentedControl.indexChangeBlock = indexChangeBlock;
}

- (void)setStyle {
    
    self.wex_segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : self.normalColor, NSFontAttributeName : self.normalFont};
    self.wex_segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : self.selectedColor, NSFontAttributeName : self.selectedFont};
    self.wex_segmentedControl.selectionIndicatorColor = self.selectionIndicatorColor;
}


- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
    [self setStyle];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    [self setStyle];
}

- (void)setSelectedFont:(UIFont *)selectedFont {
    _selectedFont = selectedFont;
    [self setStyle];
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    _selectedColor = selectedColor;
    [self setStyle];
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    _selectionIndicatorColor = selectionIndicatorColor;
    [self setStyle];
}

@end

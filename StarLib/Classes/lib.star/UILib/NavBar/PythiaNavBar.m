//
//  PythiaNavBar.m
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "PythiaNavBar.h"
#import "WexImageView.h"
#import "WexLabel.h"



@interface PythiaNavBar () {}

@end

@implementation PythiaNavBar


#pragma mark - 页面构造

- (void)wex_loadViews {
    [super wex_loadViews];
    
    UIImageView *imgView = [[UIImageView alloc] init];
    [self addSubview:imgView];
    self.backgroundView = imgView;
    
    {
        // Rule
        WexView *ruleView = [[WexView alloc] init];
        [self addSubview:ruleView];
        self.ruleView = ruleView;
        self.ruleView.backgroundColor = [UIColor whiteColor];
        self.ruleView.hidden = true;
        
        WexImageView *ruleIconView = [[WexImageView alloc] init];
        [self.ruleView addSubview:ruleIconView];
        self.ruleIconView = ruleIconView;
        self.ruleIconView.image = @"icon_safe_shield_border".xc_image;
        
        WexLabel *ruleLabel = [[WexLabel alloc] init];
        [self.ruleView addSubview:ruleLabel];
        self.ruleLabel = ruleLabel;
        self.ruleLabel.textColor = @"#55C360".xc_color;
        self.ruleLabel.font = @"13px".xc_font;
        self.ruleLabel.text = @"正在通过盈米财富进行基金安全交易";
        
        UIButton *ruleExitButton = [[UIButton alloc] init];
        [self.ruleView addSubview:ruleExitButton];
        self.ruleExitButton = ruleExitButton;
        [self.ruleExitButton addTarget:self action:@selector(handleRuleExitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.ruleExitButton.layer.cornerRadius = 2;
        self.ruleExitButton.layer.borderWidth = 1;
        self.ruleExitButton.layer.masksToBounds = true;
        self.ruleExitButton.layer.borderColor = @"#55C360".xc_color.CGColor;
        self.ruleExitButton.wex_normalTitle = @"退出";
        self.ruleExitButton.wex_font = @"13px".xc_font;
        self.ruleExitButton.wex_normalTitleColor = @"#55C360".xc_color;
        
        WexView *ruleSeparator = [[WexView alloc] init];
        [self.ruleView addSubview:ruleSeparator];
        self.ruleSeparator = ruleSeparator;
        self.ruleSeparator.backgroundColor = @"#F4F4F4;".xc_color;
    }
    {
        // Normal
        WexView *navigationView = [[WexView alloc] init];
        [self addSubview:navigationView];
        self.navigationView = navigationView;
        
        self.titleLabel = [[WexLabel alloc] init];
        [self.navigationView addSubview:self.titleLabel];
        self.titleLabel.numberOfLines = 1;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = @"17px-bold".xc_font;
        
        self.leftButton = [[UIButton alloc] init];
        [self.navigationView addSubview:self.leftButton];
        [self.leftButton addTarget:self action:@selector(handleLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftButton.hidden = true;
        
        self.leftSecondButton = [[UIButton alloc] init];
        [self.navigationView addSubview:self.leftSecondButton];
        [self.leftSecondButton addTarget:self action:@selector(handleLeftSecondButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.leftSecondButton.hidden = true;
        
        self.rightButton = [[UIButton alloc] init];
        [self.navigationView addSubview:self.rightButton];
        [self.rightButton addTarget:self action:@selector(handleRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        self.rightButton.hidden = true;
        
        self.separator = [[WexView alloc] init];
        [self.navigationView addSubview:self.separator];
        self.separator.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        //    self.separator.hidden = true;
        self.separator.backgroundColor = @"#e4e4e4".xc_color;
    }
}

- (void)wex_layoutConstraints {
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    // RULE
    
    {
        [self.ruleView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.top.equalTo(0);
            make.height.equalTo(StatusBarHeight + 44);
        }];
        [self.ruleIconView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(13);
            make.centerY.equalTo(StatusBarHeight / 2);
            make.hugging.compression.priorityRequired();
        }];
        
        [self.ruleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ruleIconView.mas_right).offset(6);
            make.centerY.equalTo(StatusBarHeight / 2);
            make.right.equalTo(self.rightButton.mas_left).offset(-8);
        }];
        
        [self.ruleExitButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(StatusBarHeight / 2);
            make.right.equalTo(-15);
            make.width.equalTo(36);
            make.height.equalTo(22);
        }];
        
        [self.ruleSeparator makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(0.5);
            make.left.right.bottom.equalTo(0);
        }];
    }
    
    // NAVIGATION
    
    {
        [self.navigationView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(StatusBarHeight);
            make.height.equalTo(44);
            make.left.right.bottom.equalTo(0);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(0);
            make.left.greaterThanOrEqualTo(self.leftSecondButton.mas_right).offset(8);
            make.right.lessThanOrEqualTo(self.rightButton.mas_left).offset(-8);
            make.hugging.priorityRequired();
            make.compression.priorityLow();
        }];
        
        
        [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.height.equalTo(44);
            make.width.equalTo(44);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
        
        [self.leftSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.leftButton.mas_right).equalTo(8);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
        
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.hugging.priorityRequired();
            make.compression.priorityRequired();
        }];
    }
    
    [self.separator makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(0.5);
    }];
}

#pragma mark -

- (void)setType:(PythiaNavBarType)type {
    _type = type;
    [self clearBackground];
    
    if (type == PythiaNavBarTypeClear) {
        self.backgroundColor        = [UIColor clearColor];
        self.tintColor              = @"#23252D".xc_color;
        
        self.titleLabel.font        = @"17px-bold".xc_font;
        self.titleLabel.textColor   = self.tintColor;
        
        self.separator.hidden       = true;
    }
    else if (type == PythiaNavBarTypeLight) {
        self.backgroundColor        = @"#FFFFFF".xc_color;
        self.tintColor              = @"#23252D".xc_color;
        
        self.titleLabel.font        = @"17px-bold".xc_font;
        self.titleLabel.textColor   = self.tintColor;
        
        self.separator.hidden       = false;
    }
    
    // 微财富
    else if (type == PythiaNavBarTypeWCFRed) {
        self.backgroundColor        = [UIColor redColor];
        self.backgroundImage        = @"wcf_navbar_red".xc_image;
        self.tintColor              = @"#FFFFFF".xc_color;
        
        self.titleLabel.font        = @"18px-bold".xc_font;
        self.titleLabel.textColor   = self.tintColor;
        
        self.separator.hidden       = true;
    }
    else if (type == PythiaNavBarTypeWCFGold) {
        self.backgroundImage        = @"wcf_navbar_au".xc_image;
        self.tintColor              = @"#FFFFFF".xc_color;
        
        self.titleLabel.font        = @"18px-bold".xc_font;
        self.titleLabel.textColor   = self.tintColor;
        
        self.separator.hidden       = true;
    }
    [self setLeftButtonType:self.leftButtonType];
    [self setRightButtonType:self.rightButtonType];
}

- (void)setLeftButtonType:(PythiaNavBarLeftButtonType)leftButtonType {
    _leftButtonType = leftButtonType;
    
    [self clearLeftButton];
    
    self.leftButton.wex_normalTitleColor        = self.tintColor;
    self.leftButton.wex_highlightedTitleColor   = self.tintColor.colorWithAlpha(0.7);
    
    if (leftButtonType == PythiaNavBarLeftButtonTypeBack) {
        self.leftButton.hidden = false;
        self.leftButton.userInteractionEnabled = true;
        self.leftButton.wex_normalImage = @"wcf_navbar_btn_back".xc_image.templateImage;
        switch (self.type) {
            case PythiaNavBarTypeClear:
            case PythiaNavBarTypeLight:
                self.leftButton.tintColor                   = @"#999999".xc_color;
                self.leftButton.wex_normalTitleColor        = @"#999999".xc_color;
                self.leftButton.wex_highlightedTitleColor   = @"#999999".xc_color.colorWithAlpha(0.7);
                
                break;
            case PythiaNavBarTypeWCFGold:
            case PythiaNavBarTypeWCFRed:
                self.leftButton.tintColor                   = self.tintColor;
                self.leftButton.wex_normalTitleColor        = self.tintColor;
                self.leftButton.wex_highlightedTitleColor   = self.tintColor.colorWithAlpha(0.7);
            default:
                
                break;
        }
    }
    else if (leftButtonType == PythiaNavBarLeftButtonTypeCancel) {
        self.leftButton.hidden                       = false;
        self.leftButton.userInteractionEnabled       = true;
        self.leftButton.wex_font                     = @"15px".xc_font;
        self.leftButton.wex_normalTitle              = [self constructTitle:@" 取消 "];
    }
    else {
        self.leftButton.hidden = true;
        self.leftButton.userInteractionEnabled = false;
    }
    
    switch (self.type) {
        case PythiaNavBarTypeClear:
        case PythiaNavBarTypeLight:
            // self.leftButton.tintColor                   = @"#999999".xc_color;
            self.leftButton.wex_normalTitleColor        = @"#999999".xc_color;
            self.leftButton.wex_highlightedTitleColor   = @"#999999".xc_color.colorWithAlpha(0.7);
            
            break;
        case PythiaNavBarTypeWCFGold:
        case PythiaNavBarTypeWCFRed:
            // self.leftButton.tintColor                   = self.tintColor;
            self.leftButton.wex_normalTitleColor        = self.tintColor;
            self.leftButton.wex_highlightedTitleColor   = self.tintColor.colorWithAlpha(0.7);
        default:
            
            break;
    }
    
    
    
}

- (void)setRightButtonType:(PythiaNavBarRightButtonType)rightButtonType {
    _rightButtonType = rightButtonType;
    [self clearRightButton];
    
    self.rightButton.hidden                     = false;
    self.rightButton.userInteractionEnabled     = true;
    
    if (rightButtonType == PythiaNavBarRightButtonTypeShare) {
        self.rightButton.wex_normalImage        = @"wcf_navbar_btn_share".xc_image.templateImage;
        self.rightButton.wex_highlightedImage   = @"wcf_navbar_btn_share".xc_image.imageWithAlpha(0.7).templateImage;
    }
    else if (rightButtonType == PythiaNavBarRightButtonTypeDetail) {
        self.rightButton.wex_normalImage        = @"wcf_navbar_btn_detail".xc_image.templateImage;
        self.rightButton.wex_highlightedImage   = @"wcf_navbar_btn_detail".xc_image.imageWithAlpha(0.7).templateImage;
    }
    else if (rightButtonType == PythiaNavBarRightButtonTypeSearch) {
        self.rightButton.wex_normalImage        = @"wcf_navbar_btn_search".xc_image.templateImage;
        self.rightButton.wex_highlightedImage   = @"wcf_navbar_btn_search".xc_image.imageWithAlpha(0.7).templateImage;
    }
    else if (rightButtonType == PythiaNavBarRightButtonTypeSort) {
        self.rightButton.wex_normalImage        = @"wcf_navbar_btn_sort".xc_image.templateImage;
        self.rightButton.wex_highlightedImage   = @"wcf_navbar_btn_sort".xc_image.imageWithAlpha(0.7).templateImage;
    }
    else if (rightButtonType == PythiaNavBarRightButtonTypeMore) {
        self.rightButton.wex_normalImage        = @"wcf_navbar_btn_more".xc_image.templateImage;
        self.rightButton.wex_highlightedImage   = @"wcf_navbar_btn_more".xc_image.imageWithAlpha(0.7).templateImage;
    }
    else {
        self.rightButton.hidden                 = true;
        self.rightButton.userInteractionEnabled = false;
    }
    
    switch (self.type) {
        case PythiaNavBarTypeClear:
        case PythiaNavBarTypeLight:
            self.rightButton.tintColor                  = @"#999999".xc_color;
            self.rightButton.wex_normalTitleColor       = @"#999999".xc_color;
            self.rightButton.wex_highlightedTitleColor  = @"#999999".xc_color.colorWithAlpha(0.7);
            
            break;
        case PythiaNavBarTypeWCFGold:
        case PythiaNavBarTypeWCFRed:
            self.rightButton.tintColor                  = self.tintColor;
            self.rightButton.wex_normalTitleColor       = self.tintColor;
            self.rightButton.wex_highlightedTitleColor  = self.tintColor.colorWithAlpha(0.7);
        default:
            
            break;
    }
    
}



#pragma mark -


- (NSString *)title {
    return [self.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)leftButtonTitle  {
    return [self.leftButton.wex_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)leftSecondButtonTitle {
    return [self.leftSecondButton.wex_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSString *)rightButtonTitle {
    return [self.rightButton.wex_normalTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}



- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    [self clearLeftButton];
    leftButtonTitle = [self constructTitle:leftButtonTitle];
    self.leftButton.hidden = false;
    self.leftButton.userInteractionEnabled    = true;
    self.leftButton.wex_font                  = @"15px".xc_font;
    self.leftButton.wex_normalTitleColor      = self.tintColor;
    self.leftButton.wex_highlightedTitleColor = self.tintColor.colorWithAlpha(0.7);
    self.leftButton.wex_normalTitle           = leftButtonTitle;
}

- (void)setLeftSecondButtonTitle:(NSString *)leftSecondButtonTitle {
    [self clearLeftSecondButton];
    self.leftSecondButton.hidden = false;
    self.leftSecondButton.userInteractionEnabled      = true;
    self.leftSecondButton.wex_font                    = @"15px".xc_font;
    self.leftSecondButton.wex_normalTitleColor        = self.tintColor;
    self.leftSecondButton.wex_highlightedTitleColor   = self.tintColor.colorWithAlpha(0.7);
    self.leftSecondButton.wex_normalTitle             = leftSecondButtonTitle;
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    
    [self clearRightButton];
    rightButtonTitle = [self constructTitle:rightButtonTitle];
    
    self.rightButton.hidden                       = false;
    self.rightButton.userInteractionEnabled       = true;
    self.rightButton.wex_font                     = @"15px".xc_font;
    self.rightButton.wex_normalTitle              = rightButtonTitle;
    self.rightButton.wex_normalTitleColor         = self.tintColor;
    self.rightButton.wex_highlightedTitleColor    = self.tintColor.colorWithAlpha(0.7);
    
    switch (self.type) {
        case PythiaNavBarTypeClear:
        case PythiaNavBarTypeLight:
            self.rightButton.wex_normalTitleColor       = @"#999999".xc_color;
            self.rightButton.wex_highlightedTitleColor  = @"#999999".xc_color.colorWithAlpha(0.7);
            
            break;
        case PythiaNavBarTypeWCFGold:
        case PythiaNavBarTypeWCFRed:
            self.rightButton.wex_normalTitleColor       = self.tintColor;
            self.rightButton.wex_highlightedTitleColor  = self.tintColor.colorWithAlpha(0.7);
        default:
            
            break;
    }
    
}


- (NSString *)constructTitle:(NSString *)title {
    title  = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [NSString stringWithFormat:@"  %@  ", title];
}


#pragma mark - Self Getter & Setter

- (void)clearBackground {
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.image = nil;
}

- (UIColor *)backgroundColor {
    return self.backgroundView.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundView.backgroundColor = backgroundColor;
}

- (UIImage *)backgroundImage {
    return self.backgroundView.image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundView.image = backgroundImage;
}



#pragma mark - Left Button Setup

- (void)clearLeftButton {
    
    [self.leftButton setTitle:nil forState:UIControlStateNormal];
    [self.leftButton setTitleColor:nil forState:UIControlStateNormal];
    [self.leftButton setImage:nil forState:UIControlStateNormal];
    [self.leftButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.leftButton.hidden = true;
}

- (void)clearLeftSecondButton {
    
    [self.leftSecondButton setTitle:nil forState:UIControlStateNormal];
    [self.leftSecondButton setTitleColor:nil forState:UIControlStateNormal];
    [self.leftSecondButton setImage:nil forState:UIControlStateNormal];
    [self.leftSecondButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.leftSecondButton.hidden = true;
}

- (void)clearRightButton {
    
    [self.rightButton setTitle:nil forState:UIControlStateNormal];
    [self.rightButton setTitleColor:nil forState:UIControlStateNormal];
    [self.rightButton setImage:nil forState:UIControlStateNormal];
    [self.rightButton setBackgroundImage:nil forState:UIControlStateNormal];
    self.rightButton.hidden = true;
}



#pragma mark - 按钮事件

- (void)handleLeftButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_navBarLeftButtonClicked:)]) {
        [self.delegate wex_navBarLeftButtonClicked:sender];
    }
}

- (void)handleLeftSecondButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_navBarLeftSecondButtonClicked:)]) {
        [self.delegate wex_navBarLeftSecondButtonClicked:sender];
    }
}

- (void)handleRightButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wex_navBarRightButtonClicked:)]) {
        [self.delegate wex_navBarRightButtonClicked:sender];
    }
}

- (void)handleRuleExitButtonClicked:(id)sender {
    if (self.ruleExitButtonClicked)
        self.ruleExitButtonClicked();
}


#pragma mark - 合规性

- (void)setRuling:(BOOL)ruling {
    self.ruleView.hidden = !ruling;
    if (ruling) {
        [self.navigationView remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(44);
            make.top.equalTo(self.ruleView.mas_bottom);
            make.left.right.bottom.equalTo(0);
        }];
    }
    else {
        [self.navigationView remakeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(44);
            make.top.equalTo(StatusBarHeight);
            make.left.right.bottom.equalTo(0);
        }];
    }
}

- (void)setRuleHint:(NSString *)ruleHint clicked:(void(^)())clicked {
    _ruleHint = ruleHint;
    _ruleExitButtonClicked = clicked;
    if ([NSString isNullOrWhiteSpace:ruleHint]) {
        [self setRuling:false];
    }
    else {
        self.ruleLabel.text = ruleHint;
        [self setRuling:true];
    }
}

@end

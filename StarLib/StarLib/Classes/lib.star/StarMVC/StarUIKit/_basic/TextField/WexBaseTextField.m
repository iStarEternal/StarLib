//
//  WexBaseTextField.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/22.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexBaseTextField.h"

@implementation WexBaseTextField


- (void)setPlaceHolderFont:(UIFont *)placeHolderFont {
    _placeHolderFont = placeHolderFont;
    [self wex_setPlanceHolder];
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _placeHolderColor = placeHolderColor;
    [self wex_setPlanceHolder];
}


- (void)wex_setPlanceHolder {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.placeholder ?: @""];
    if (self.placeHolderFont) {
        [attr addAttribute:NSFontAttributeName value:self.placeHolderFont range:[attr.string rangeOfString:attr.string]];
    }
    if (self.placeHolderColor) {
        [attr addAttribute:NSForegroundColorAttributeName value:self.placeHolderColor range:[attr.string rangeOfString:attr.string]];
    }
    self.attributedPlaceholder = attr.copy;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (self.placeHolderFont && self.placeHolderColor) {
        [self wex_setPlanceHolder];
    }
}

@end

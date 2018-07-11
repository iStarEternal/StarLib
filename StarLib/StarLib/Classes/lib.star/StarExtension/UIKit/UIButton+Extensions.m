//
//  UIButton+Extensions.m
//  AFNetworking
//
//  Created by 星星 on 2018/7/11.
//

#import "UIButton+Extensions.h"

@implementation UIButton (Extensions)

- (UIFont *)wex_font {
    return self.titleLabel.font;
}

- (void)setWex_font:(UIFont *)wex_font {
    self.titleLabel.font = wex_font;
}


#pragma mark - normal

- (NSString *)wex_normalTitle {
    return [self titleForState:UIControlStateNormal];
}
- (void)setWex_normalTitle:(NSString *)wex_normalTitle {
    [self setTitle:wex_normalTitle forState:UIControlStateNormal];
}

- (UIColor *)wex_normalTitleColor {
    return [self titleColorForState:UIControlStateNormal];
}
- (void)setWex_normalTitleColor:(UIColor *)wex_normalTitleColor {
    [self setTitleColor:wex_normalTitleColor forState:UIControlStateNormal];
}

- (UIImage *)wex_normalImage {
    return [self imageForState:UIControlStateNormal];
}
- (void)setWex_normalImage:(UIImage *)wex_normalImage {
    [self setImage:wex_normalImage forState:UIControlStateNormal];
}

- (UIImage *)wex_normalBackgroundImage {
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void)setWex_normalBackgroundImage:(UIImage *)wex_normalBackgroundImage {
    [self setBackgroundImage:wex_normalBackgroundImage forState:UIControlStateNormal];
}


#pragma mark - hignlighted

- (NSString *)wex_highlightedTitle {
    return [self titleForState:UIControlStateHighlighted];
}
- (void)setWex_highlightedTitle:(NSString *)wex_highlightedTitle {
    [self setTitle:wex_highlightedTitle forState:UIControlStateHighlighted];
}

- (UIColor *)wex_highlightedTitleColor {
    return [self titleColorForState:UIControlStateHighlighted];
}
- (void)setWex_highlightedTitleColor:(UIColor *)wex_highlightedTitleColor {
    [self setTitleColor:wex_highlightedTitleColor forState:UIControlStateHighlighted];
}

- (UIImage *)wex_highlightedImage {
    return [self imageForState:UIControlStateHighlighted];
}
- (void)setWex_highlightedImage:(UIImage *)wex_highlightedImage {
    [self setImage:wex_highlightedImage forState:UIControlStateHighlighted];
}

- (UIImage *)wex_highlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void)setWex_highlightedBackgroundImage:(UIImage *)wex_highlightedBackgroundImage {
    [self setBackgroundImage:wex_highlightedBackgroundImage forState:UIControlStateHighlighted];
}


#pragma mark - selected

- (NSString *)wex_selectedTitle {
    return [self titleForState:UIControlStateSelected];
}
- (void)setWex_selectedTitle:(NSString *)wex_selectedTitle {
    [self setTitle:wex_selectedTitle forState:UIControlStateSelected];
}

- (UIColor *)wex_selectedTitleColor {
    return [self titleColorForState:UIControlStateSelected];
}
- (void)setWex_selectedTitleColor:(UIColor *)wex_selectedTitleColor {
    [self setTitleColor:wex_selectedTitleColor forState:UIControlStateSelected];
}

- (UIImage *)wex_selectedImage {
    return [self imageForState:UIControlStateSelected];
}
- (void)setWex_selectedImage:(UIImage *)wex_selectedImage {
    [self setImage:wex_selectedImage forState:UIControlStateSelected];
}

- (UIImage *)wex_selectedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected];
}
- (void)setWex_selectedBackgroundImage:(UIImage *)wex_selectedBackgroundImage {
    [self setBackgroundImage:wex_selectedBackgroundImage forState:UIControlStateSelected];
}



#pragma mark - selected

- (NSString *)wex_selectedHighlightedTitle {
    return [self titleForState:UIControlStateSelected|UIControlStateHighlighted];
}
- (void)setWex_selectedHighlightedTitle:(NSString *)wex_selectedHighlightedTitle {
    [self setTitle:wex_selectedHighlightedTitle forState:UIControlStateSelected|UIControlStateHighlighted];
}

- (UIColor *)wex_selectedHighlightedTitleColor {
    return [self titleColorForState:UIControlStateSelected|UIControlStateHighlighted];
}
- (void)setWex_selectedHighlightedTitleColor:(UIColor *)wex_selectedHighlightedTitleColor {
    [self setTitleColor:wex_selectedHighlightedTitleColor forState:UIControlStateSelected|UIControlStateHighlighted];
}

- (UIImage *)wex_selectedHighlightedImage {
    return [self imageForState:UIControlStateSelected|UIControlStateHighlighted];
}
- (void)setWex_selectedHighlightedImage:(UIImage *)wex_selectedHighlightedImage {
    [self setImage:wex_selectedHighlightedImage forState:UIControlStateSelected|UIControlStateHighlighted];
}

- (UIImage *)wex_selectedHighlightedBackgroundImage {
    return [self backgroundImageForState:UIControlStateSelected|UIControlStateHighlighted];
}
- (void)setWex_selectedHighlightedBackgroundImage:(UIImage *)wex_selectedHighlightedBackgroundImage {
    [self setBackgroundImage:wex_selectedHighlightedBackgroundImage forState:UIControlStateSelected|UIControlStateHighlighted];
}



#pragma mark - disable

- (NSString *)wex_disabledTitle {
    return [self titleForState:UIControlStateDisabled];
}
- (void)setWex_disabledTitle:(NSString *)wex_disabledTitle {
    [self setTitle:wex_disabledTitle forState:UIControlStateDisabled];
}

- (UIColor *)wex_disabledTitleColor {
    return [self titleColorForState:UIControlStateDisabled];
}
- (void)setWex_disabledTitleColor:(UIColor *)wex_disabledTitleColor {
    [self setTitleColor:wex_disabledTitleColor forState:UIControlStateDisabled];
}

- (UIImage *)wex_disabledImage {
    return [self imageForState:UIControlStateDisabled];
}
- (void)setWex_disabledImage:(UIImage *)wex_disabledImage {
    [self setImage:wex_disabledImage forState:UIControlStateDisabled];
}

- (UIImage *)wex_disabledBackgroundImage {
    return [self backgroundImageForState:UIControlStateDisabled];
}
- (void)setWex_disabledBackgroundImage:(UIImage *)wex_disabledBackgroundImage {
    [self setBackgroundImage:wex_disabledBackgroundImage forState:UIControlStateDisabled];
}
@end

//
//  UIButton+Extensions.h
//  AFNetworking
//
//  Created by 星星 on 2018/7/11.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extensions)

@property (nonatomic, strong) UIFont *wex_font;

@property (nonatomic, copy) NSString  *wex_normalTitle;
@property (nonatomic, strong) UIColor *wex_normalTitleColor;
@property (nonatomic, strong) UIImage *wex_normalImage;
@property (nonatomic, strong) UIImage *wex_normalBackgroundImage;

@property (nonatomic, copy) NSString  *wex_highlightedTitle;
@property (nonatomic, strong) UIColor *wex_highlightedTitleColor;
@property (nonatomic, strong) UIImage *wex_highlightedImage;
@property (nonatomic, strong) UIImage *wex_highlightedBackgroundImage;

@property (nonatomic, copy) NSString  *wex_selectedTitle;
@property (nonatomic, strong) UIColor *wex_selectedTitleColor;
@property (nonatomic, strong) UIImage *wex_selectedImage;
@property (nonatomic, strong) UIImage *wex_selectedBackgroundImage;

@property (nonatomic, copy) NSString  *wex_selectedHighlightedTitle;
@property (nonatomic, strong) UIColor *wex_selectedHighlightedTitleColor;
@property (nonatomic, strong) UIImage *wex_selectedHighlightedImage;
@property (nonatomic, strong) UIImage *wex_selectedHighlightedBackgroundImage;

@property (nonatomic, copy) NSString  *wex_disabledTitle;
@property (nonatomic, strong) UIColor *wex_disabledTitleColor;
@property (nonatomic, strong) UIImage *wex_disabledImage;
@property (nonatomic, strong) UIImage *wex_disabledBackgroundImage;

@end

//
//  PythiaNavBar.h
//  WeXFin
//
//  Created by Mark on 15/7/20.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WexView.h"
#import "WexImageView.h"
#import "WexLabel.h"

// 亮色
typedef NS_ENUM(NSInteger, PythiaNavBarType) {
    PythiaNavBarTypeLight,      // 白色 - 默认
    PythiaNavBarTypeClear,      // 透明NavBar
    PythiaNavBarTypeWCFGold,    // 微财富金
    PythiaNavBarTypeWCFRed,     // 微财富红
};

typedef NS_ENUM(NSInteger, PythiaNavBarLeftButtonType) {
    PythiaNavBarLeftButtonTypeBack,        // 返回 - 默认
    PythiaNavBarLeftButtonTypeCancel,      // 取消
    PythiaNavBarLeftButtonTypeNone,        // 无按钮
};

typedef NS_ENUM(NSInteger, PythiaNavBarRightButtonType) {
    PythiaNavBarRightButtonTypeNone,           // 没有按钮 - 默认
    PythiaNavBarRightButtonTypeShare,          // 分享
    PythiaNavBarRightButtonTypeDetail,         // 详情
    PythiaNavBarRightButtonTypeSearch,         // 搜索
    PythiaNavBarRightButtonTypeSort,           // 排序
    PythiaNavBarRightButtonTypeMore,           // 更多
};



@protocol PythiaNavBarDelegate <NSObject>

@optional

- (void)wex_navBarLeftButtonClicked:(id)sender;

- (void)wex_navBarLeftSecondButtonClicked:(id)sender;

- (void)wex_navBarRightButtonClicked:(id)sender;

@end

@interface PythiaNavBar : WexView


@property (nonatomic, assign) PythiaNavBarType type;
@property (nonatomic, assign) PythiaNavBarLeftButtonType leftButtonType;
@property (nonatomic, assign) PythiaNavBarRightButtonType rightButtonType;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *leftButtonTitle;
@property (nonatomic, strong) NSString *leftSecondButtonTitle;
@property (nonatomic, strong) NSString *rightButtonTitle;


@property (nonatomic, weak) UIImageView *backgroundView;


@property (nonatomic, weak) UIView *statusBarView;

// 规则Navigation
@property (nonatomic, weak) WexView *ruleView;
@property (nonatomic, weak) WexImageView *ruleIconView;
@property (nonatomic, weak) WexLabel *ruleLabel;
@property (nonatomic, weak) UIButton *ruleExitButton;
@property (nonatomic, weak) WexView *ruleSeparator;

// 默认Navigation
@property (nonatomic, weak) WexView *navigationView;
@property (nonatomic, strong) WexLabel *titleLabel;
@property (nonatomic, strong) WexView *separator;

@property (nonatomic, assign) id<PythiaNavBarDelegate> delegate;


- (void)clearLeftButton;
- (void)clearLeftSecondButton;
- (void)clearRightButton;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *leftSecondButton;
@property (nonatomic, strong) UIButton *rightButton;


#pragma mark - Self Properties
- (void)clearBackground;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *backgroundImage;


#pragma mark - Rule Properties

@property (nonatomic, strong) NSString *ruleHint;
@property (nonatomic, copy) void(^ruleExitButtonClicked)();
- (void)setRuleHint:(NSString *)ruleHint clicked:(void(^)())clicked;

@end

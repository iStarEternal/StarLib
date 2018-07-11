//
//  WexNewViewController.h
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>


#import "WexLoadingHelper.h"

#import "StarNavigationControllerServices.h"

#import "KeyboardHelper.h"


#import "WexNavigationController.h"


@class WexNewViewController;

/** 数据代理 */
@protocol WexViewControllerDataDelegate <NSObject>

- (instancetype)initWithViewController:(WexNewViewController *)viewController;

/// 通用刷新页面
- (void)viewController:(WexNewViewController *)viewController loadingWithParameters:(id)parameters;

/// 通用获取数据
- (void)viewController:(WexNewViewController *)viewController fetchDataForKey:(NSString *)key parameters:(id)parameters complete:(void(^)(id data, NSError *error))complete;

@end


/// An abstract class representing a view model.
@interface WexNewViewController : UIViewController <PythiaNavBarDelegate, WexLoadingDelegate, KeyboardHelperDelegate, WexNavigationControllerDelegate>

/// 数据代理
@property (nonatomic, strong) id<WexViewControllerDataDelegate> dataDelegate;


- (BOOL)popGestureEnabled;


/**
 *  1：加载navBar，重写该函数应调用[super wex_loadNavigationBar];
 */
- (void)wex_loadNavigationBar;

/**
 *  2：加载view，在[self wex_loadNavigationBar]后调用，重写该函数应调用 [super wex_loadViews];
 */
- (void)wex_loadViews NS_REQUIRES_SUPER;

/**
 *  2.1：适配iPhoneX的ButtonBar
 */
- (void)wex_loadButtonBar;

/**
 *  3：对view进行布局，在[self wex_loadViews]后调用，重写该函数应调用 [super wex_layoutConstraints];
 */
- (void)wex_layoutConstraints;



#pragma mark - 导航栏 NavigationBar

@property (nonatomic, weak) PythiaNavBar *navBar;

- (void)setNavBarType:(PythiaNavBarType)type;

- (void)setNavBarLeftButtonType:(PythiaNavBarLeftButtonType)leftButtonType;

- (void)setNavBarLeftSecondButtonTitle:(NSString *)title;

- (void)setNavBarRightButtonType:(PythiaNavBarRightButtonType)rightButtonType;

- (void)setNavBarRightButtonTitle:(NSString *)title;

- (void)setNavBarRightImage:(UIImage *)image;

- (void)setNavBarTitle:(NSString *)title;

- (void)setNavBarHidden:(BOOL)hidden;


@property (nonatomic, strong) WexButtonBar *buttonBar;


#pragma mark - 键盘处理

/// 键盘Helper
@property (nonatomic, strong) KeyboardHelper *keyboardHelper;

/// 是否启用键盘默认处理逻辑,默认启用
- (BOOL)isUseDefaultKeyboardHandle;



#pragma mark - 页面刷新

/// 刷新控件
@property (nonatomic, strong, readonly) WexLoadingHelper *loading;

/// 刷新触发
- (void)wex_loadingAction;

/// 刷新页面点击返回
- (void)wex_loadingGoBackClicked;



#pragma mark - 页面数据

/// 页面数据源
@property (nonatomic, strong) id viewData;

/// 给页面赋值
- (void)setLoadingSuccess:(id)data;

/// 加载出错
- (void)setLoadingFailure:(NSError *)error;

@end





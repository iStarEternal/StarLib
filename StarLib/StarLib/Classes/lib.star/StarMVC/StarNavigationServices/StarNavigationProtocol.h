//
//  StarNavigationProtocol.h
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol StarNavigationProtocol <NSObject>


// MARK: resetRootViewController

/// 重设keyWindow的RootViewController
- (void)resetRootViewController:(UIViewController *)viewController;


// MARK: - viewControllers

/// The current view model stack.
@property(nonatomic, copy, readonly) NSArray<__kindof UIViewController *> *viewControllers;

/// Set view models
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated;


// MARK: -

/// Push到指定控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Push到指定控制器，但会将fromViewController之上的所有控制器从栈中移除
- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated;

/// Push到指定控制器，但会将excludeViewController及之上的所有控制器从栈中移除
- (void)pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated;

///
- (void)showViewController:(UIViewController *)vc sender:(nullable id)sender;


// MARK: - 原生Pop

///
- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated;

///
- (nullable NSArray<__kindof UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated;

/// Pop 到栈顶开始数第一个与class相同的控制器，如果没有找到，则不pop，并且返回nil
- (nullable NSArray<__kindof UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated;


// MARK: 自定义Pop

///
- (nullable NSArray<__kindof UIViewController *> *)popToViewControllerClass:(Class)aClass animated:(BOOL)animated;

/// Pop到一个栈中没有的控制器，直到Pop掉excludeViewController
- (nullable NSArray<__kindof UIViewController *> *)popToExternalViewController:(UIViewController *)externalViewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated;

/// Pop到一个栈中没有的控制器，保留toViewController
- (nullable NSArray<__kindof UIViewController *> *)popToExternalViewController:(UIViewController *)externalViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated;

/// Pop到viewController之前的一个viewController
- (nullable NSArray<__kindof UIViewController *> *)popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (nullable NSArray<__kindof UIViewController *> *)popToViewControllerPowerful:(UIViewController *)viewController animated:(BOOL)animated;


// MARK: - Present

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^ __nullable)(void))completion;

- (void)dismissViewControllerAnimated:(BOOL)animated completion: (void (^ __nullable)(void))completion;



// MARK: -

- (UINavigationController *)requireNavigationController;

@property(nullable, nonatomic, strong, readonly) UIViewController *topViewController;
@property(nullable, nonatomic, strong, readonly) UIViewController *visibleViewController;





- (NSArray<UIViewController *> *)tailViewControllersWithoutViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END

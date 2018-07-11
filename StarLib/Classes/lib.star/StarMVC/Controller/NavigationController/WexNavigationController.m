//
//  WexNavigationController.m
//  WexWeiCaiFu
//
//  Created by Mark on 15/10/27.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import "WexNavigationController.h"

@interface WexNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSDate *lastInputDate;

@property (nonatomic, assign) BOOL isPush;

@end

@implementation WexNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setNavigationBarHidden:true animated:false];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super setViewControllers:viewControllers animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return  [super popToRootViewControllerAnimated:animated];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    // 在VC栈中
    if ([self.viewControllers containsObject:viewController]) {
        return [super popToViewController:viewController animated:animated];
        
    }
    // vc.tabBarController在VC栈中
    if (viewController.tabBarController && [self.viewControllers containsObject:viewController.tabBarController]) {
        return [super popToViewController:viewController.tabBarController animated:animated];
    }
    // 都不在不允许POP
    return nil;
}


#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (!self.isPush) {
    }
    self.isPush = false;
}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        self.isPush = true;
    }
    else {
        self.isPush = false;
    }
    return nil;
}

#pragma mark UINavigationControllerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        if (self.viewControllers.count <= 1 || self.visibleViewController == self.viewControllers.firstObject) {
            return false;
        }
        if ([self.visibleViewController conformsToProtocol:@protocol(WexNavigationControllerDelegate)]) {
            id<WexNavigationControllerDelegate> delegate = (id)self.visibleViewController;
            if ([delegate respondsToSelector:@selector(popGestureEnabled)]) {
                return [delegate popGestureEnabled];
            }
        }
    }
    return true;
}



@end

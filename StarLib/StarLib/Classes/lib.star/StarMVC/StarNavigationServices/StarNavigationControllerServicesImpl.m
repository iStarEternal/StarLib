//
//  StarNavigationControllerServicesImpl.m
//  Pythia
//
//  Created by 星星 on 17/2/15.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "StarNavigationControllerServicesImpl.h"



@interface StarNavigationControllerServicesImpl ()

@property (nonatomic, strong) NSMutableArray<UINavigationController *> *navigationControllers;

@property (nonatomic, weak, readonly) UINavigationController *topNavigationController;


@end

@implementation StarNavigationControllerServicesImpl


#pragma mark -

- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationControllers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController {
    if ([self.navigationControllers containsObject:navigationController]) return;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController {
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController {
    return self.navigationControllers.lastObject;
}



#pragma mark -

- (UINavigationController *)requireNavigationController {
    return self.topNavigationController;
}

- (UIViewController *)topViewController {
    return self.topNavigationController.topViewController;
}

- (UIViewController *)visibleViewController {
    return self.topNavigationController.visibleViewController;
}



#pragma mark - ResetRootViewController

- (void)resetRootViewController:(UIViewController *)viewController {
    
    if (![viewController isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [self pushNavigationController:navigationController];
        
        UIApplication.sharedApplication.delegate.window.rootViewController = navigationController;
        //        APP_ROOT_VC = navigationController;
    }
    else {
        [self pushNavigationController:(UINavigationController *)viewController];
        UIApplication.sharedApplication.delegate.window.rootViewController = viewController;
        //        APP_ROOT_VC = viewController;
    }
    [UIApplication.sharedApplication.delegate.window makeKeyAndVisible];
    //    [APP_ROOT_WINDOW makeKeyAndVisible];
    
}



#pragma mark - viewControllers

- (NSArray<UIViewController *> *)viewControllers {
    return self.topNavigationController.viewControllers;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [self.topNavigationController setViewControllers:viewControllers animated:animated];
}




#pragma mark - Push

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.topNavigationController pushViewController:viewController animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated {
    
    NSMutableArray *vcsM = [NSMutableArray array];
    
    for (UIViewController *controller in self.viewControllers) {
        [vcsM addObject:controller];
        if ([controller isEqual:fromViewController]) {
            break;
        }
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated {
    
    NSMutableArray *vcsM = [NSMutableArray array];
    
    for (UIViewController *controller in self.viewControllers) {
        if ([controller isEqual:excludeViewController]) {
            break;
        }
        [vcsM addObject:controller];
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:animated];
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender {
    [self.topNavigationController showViewController:vc sender:sender];
}



#pragma mark - 原有Pop

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.topNavigationController popViewControllerAnimated:true];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    return [self.topNavigationController popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.topNavigationController popToRootViewControllerAnimated:animated];
}


#pragma mark - 自定义Pop

- (NSArray<UIViewController *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isMemberOfClass:class]) {
            return [self popToViewController:viewController animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)popToExternalViewController:(UIViewController *)externalViewController excludeViewController:(UIViewController *)excludeViewController animated:(BOOL)animated {
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.viewControllers) {
        if (vc == excludeViewController) {
            break;
        }
        [vcs addObject:vc];
    }
    
    [vcs addObject:externalViewController];
    [vcs addObject:excludeViewController];
    [self setViewControllers:vcs.copy animated:false];
    
    [vcs removeLastObject];
    [self setViewControllers:vcs.copy animated:animated];
    
    return self.viewControllers;
}

- (NSArray<UIViewController *> *)popToExternalViewController:(UIViewController *)externalViewController toViewController:(UIViewController *)toViewController animated:(BOOL)animated {
    
    if (self.viewControllers.lastObject == toViewController) {
        NSAssert(false, @"调用popToExternalViewController:toViewController:animated:时，当前栈顶控制器不能是toViewController");
    }
    
    NSMutableArray *vcs = [[NSMutableArray alloc] init];
    for (UIViewController *vc in self.viewControllers) {
        if (vc == toViewController) {
            [vcs addObject:vc];
            break;
        }
        [vcs addObject:vc];
    }
    [vcs addObject:externalViewController];
    [vcs addObject:self.viewControllers.lastObject];
     [self setViewControllers:vcs.copy animated:false];
    
    [vcs removeLastObject];
    [self setViewControllers:vcs.copy animated:animated];
    
    return self.viewControllers;
}

- (NSArray<UIViewController *> *)popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL continued = false;
    for (UIViewController *vc in self.viewControllers.reverseObjectEnumerator.allObjects) {
        if (vc == viewController) {
            continued = true;
            continue;
        }
        if (continued) {
            return [self popToViewController:vc animated:animated];
        }
    }
    return nil;
}

- (NSArray<UIViewController *> *)popToViewControllerPowerful:(UIViewController *)viewController animated:(BOOL)animated {
    UIViewController *displayVC = self.viewControllers.lastObject;
    
    [self setViewControllers:@[viewController, displayVC] animated:false];
    [self setViewControllers:@[viewController] animated:animated];
    
    return self.viewControllers;
}






#pragma mark - Present

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)())completion {
    
    UINavigationController *presentingViewController = self.topNavigationController;
    
    if (![viewControllerToPresent isKindOfClass:UINavigationController.class]) {
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewControllerToPresent];
        [self pushNavigationController:navigationController];
        
        [presentingViewController presentViewController:navigationController animated:animated completion:completion];
    }
    else {
        [self pushNavigationController:(UINavigationController *)viewControllerToPresent];
        [presentingViewController presentViewController:viewControllerToPresent animated:animated completion:completion];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)animated completion:(void (^)())completion {
    [self popNavigationController];
    [self.topNavigationController dismissViewControllerAnimated:animated completion:completion];
}




- (NSArray<UIViewController *> *)tailViewControllersWithoutViewController:(UIViewController *)viewController {
    
    NSMutableArray *arr_m = [NSMutableArray array];
    for (UIViewController *vc in self.viewControllers) {
        if (vc!=viewController && arr_m.count==0)
            continue;
        [arr_m addObject:vc];
    }
    if (arr_m.count) [arr_m removeObjectAtIndex:0];
    return arr_m;
}

@end
































//
//  UINavigationController+WexNavigationProcess.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/23.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UINavigationController+NavigationProcess.h"


@implementation UINavigationController (NavigationProcess)

- (NSArray<__kindof UIViewController *> *)powerfulPopToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIViewController *displayVC = self.viewControllers.lastObject;
    
    [self setViewControllers:@[viewController, displayVC] animated:false];
    [self setViewControllers:@[viewController] animated:animated];
    
    return self.viewControllers;
}

- (NSArray<__kindof UIViewController *> *)popToViewControllerClass:(Class)class animated:(BOOL)animated {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isMemberOfClass:class]) {
            return [self popToViewController:viewController animated:animated];
        }
    }
    return nil;
}

- (NSArray<__kindof UIViewController *> *)popToPreviousViewControllerFromSender:(UIViewController *)sender animated:(BOOL)animated {
    
    BOOL continued = false;
    for (UIViewController *viewController in self.viewControllers.reverseObjectEnumerator.allObjects) {
        if (viewController == sender) {
            continued = true;
            continue;
        }
        if (continued) {
            return [self popToViewController:viewController animated:animated];
        }
    }
    return nil;
}
- (NSArray<__kindof UIViewController *> *)popToPreviousViewControllerForViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
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

- (void)directPushViewController:(UIViewController *)viewController fromSenderViewController:(UIViewController *)senderViewController {
    
    NSMutableArray *vcsM = [NSMutableArray array];
    
    for (UIViewController *controller in self.viewControllers) {
        [vcsM addObject:controller];
        if ([controller isEqual:senderViewController]) {
            break;
        }
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:true];
}
- (void)pushViewCOntroller:(UIViewController *)viewController fromViewController:(UIViewController *)fromViewController animated:(BOOL)animated {
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

- (void)pushViewController:(UIViewController *)viewController excludeSenderViewController:(UIViewController *)senderViewController {
    
    NSMutableArray *vcsM = [NSMutableArray array];
    
    for (UIViewController *controller in self.viewControllers) {
        if ([controller isEqual:senderViewController]) {
            break;
        }
        [vcsM addObject:controller];
    }
    [vcsM addObject:viewController];
    [self setViewControllers:[vcsM copy] animated:true];
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

@end


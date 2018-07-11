//
//  PythiaNavBarHelper.h
//  WeXFin
//
//  Created by Mark on 15/7/21.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PythiaNavBar.h"



@interface PythiaNavBarHelper : NSObject

+ (PythiaNavBar *)installNavBarInView:(UIView *)parentView;

+ (void)initNavBar:(PythiaNavBar *)navBar type:(PythiaNavBarType)type;

+ (void)initNavBar:(PythiaNavBar *)navBar title:(NSString *)title;


+ (void)initNavBar:(PythiaNavBar *)navBar leftButtonType:(PythiaNavBarLeftButtonType)leftButtonType;

+ (void)initNavBar:(PythiaNavBar *)navBar leftButtonTitle:(NSString *)title;

+ (void)initNavBar:(PythiaNavBar *)navBar leftSecondButtonTitle:(NSString *)title;


+ (void)initNavBar:(PythiaNavBar *)navBar rightButtonType:(PythiaNavBarRightButtonType)rightButtonType;

+ (void)initNavBar:(PythiaNavBar *)navBar rightButtonTitle:(NSString *)title;


@end

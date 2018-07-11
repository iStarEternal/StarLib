//
//  PythiaNavBarHelper.m
//  WeXFin
//
//  Created by Mark on 15/7/21.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "PythiaNavBarHelper.h"

@implementation PythiaNavBarHelper

+ (PythiaNavBar *)installNavBarInView:(UIView *)parentView {
    
    PythiaNavBar *navBar = [[PythiaNavBar alloc] init];
    [parentView addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
    }];
    
    navBar.type = PythiaNavBarTypeLight;
    navBar.leftButtonType = PythiaNavBarLeftButtonTypeBack;
    
    return navBar;
}

+ (void)initNavBar:(PythiaNavBar *)navBar type:(PythiaNavBarType)type {
    navBar.type = type;
}

+ (void)initNavBar:(PythiaNavBar *)navBar title:(NSString *)title {
    navBar.titleLabel.text = title;
}

+ (void)initNavBar:(PythiaNavBar *)navBar leftButtonType:(PythiaNavBarLeftButtonType)leftButtonType {
    navBar.leftButtonType = leftButtonType;
}

+ (void)initNavBar:(PythiaNavBar *)navBar leftButtonTitle:(NSString *)title {
    navBar.leftButtonTitle = title;
}

+ (void)initNavBar:(PythiaNavBar *)navBar leftSecondButtonTitle:(NSString *)title {
    navBar.leftSecondButtonTitle = title;
}

+ (void)initNavBar:(PythiaNavBar *)navBar rightButtonTitle:(NSString *)title {
    
    navBar.rightButtonTitle = title;
}


+ (void)initNavBar:(PythiaNavBar *)navBar rightButtonType:(PythiaNavBarRightButtonType)rightButtonType {
    navBar.rightButtonType = rightButtonType;
}

+ (NSString *)constructTitle:(NSString *)title {
    title  = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [NSString stringWithFormat:@"  %@  ", title];
}

@end

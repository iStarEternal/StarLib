//
//  WexHUD.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/28.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexHUD.h"
#import "SVProgressHUD.h"
#import "WexInfoHudView.h"

@implementation WexHUD





+ (void)config {
    
    [SVProgressHUD setFadeInAnimationDuration:0.15];
    [SVProgressHUD setFadeOutAnimationDuration:0.15];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
}


+ (void)showWaitHUD {
    [self showWaitHUDWithStatus:@"加载中，请稍候..."];
}
// 实
+ (void)showWaitHUDWithStatus:(NSString *)status {
    [self config];
    [SVProgressHUD showWithStatus:status];
}


+ (void)mustShowWaitHUD {
    [self mustShowWaitHUDWithStatus:@"加载中，请稍候..."];
}
// 实
+ (void)mustShowWaitHUDWithStatus:(NSString *)status {
    [self config];
    
    [SVProgressHUD setFadeOutAnimationDuration:0];
    [SVProgressHUD setFadeInAnimationDuration:0];
    
    [SVProgressHUD showWithStatus:status];
}


+ (void)showErrorHUD {
    [self showWaitHUDWithStatus:@"很抱歉>_<服务器开小差了..."];
}
// 实
+ (void)showErrorHUDWithStatus:(NSString *)status {
    [self config];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showErrorWithStatus:status];
}


+ (void)showSuccessHUD {
    [self showSuccessHUDWithStatus:@""];
}

+ (void)showSuccessHUDWithStatus:(NSString *)status {
    [self showSuccessHUDWithStatus:status maskType:SVProgressHUDMaskTypeNone];
}
// 实
+ (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType {
    [self config];
    [SVProgressHUD setDefaultMaskType:maskType];
    [SVProgressHUD showSuccessWithStatus:status];
}


+ (void)showInfo:(NSString *)info {
    [WexInfoHudView showTitle:info];
}
// 实
+ (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration {
    [WexInfoHudView showTitle:info duration:duration];
}


+ (void)showProgress:(float)progress {
    [self showProgress:progress status:nil];
}
// 实
+ (void)showProgress:(float)progress status:(NSString *)status {
    [self config];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD showProgress:progress status:status];
}

// 实
+ (void)dismiss {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    [SVProgressHUD dismiss];
}

@end

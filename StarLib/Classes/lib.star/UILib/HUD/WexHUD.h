//
//  WexHUD.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/28.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface WexHUD : NSObject


+ (void)showWaitHUD;
+ (void)showWaitHUDWithStatus:(NSString *)status;

+ (void)mustShowWaitHUD;
+ (void)mustShowWaitHUDWithStatus:(NSString *)status;

+ (void)showErrorHUD;
+ (void)showErrorHUDWithStatus:(NSString *)status;

+ (void)showSuccessHUD;
+ (void)showSuccessHUDWithStatus:(NSString *)status;
+ (void)showSuccessHUDWithStatus:(NSString *)status maskType:(SVProgressHUDMaskType)maskType;


+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress status:(NSString *)status;

+ (void)dismiss;

+ (void)showInfo:(NSString *)info;
+ (void)showInfo:(NSString *)info duration:(NSTimeInterval)duration;

@end


static void inline ShowWaitHUD() {
    [WexHUD showWaitHUD];
}
static void inline ShowWaitHUDWithStatus(NSString *status) {
    [WexHUD showWaitHUDWithStatus:status];
}

static void inline MustShowWaitHUD() {
    [WexHUD mustShowWaitHUD];
}
static void inline MustShowWaitHUDWithStatus(NSString *status) {
    [WexHUD mustShowWaitHUDWithStatus:status];
}

static void inline ShowErrorHUD() {
    [WexHUD showErrorHUD];
}
static void inline ShowErrorHUDWithStatus(NSString *status) {
    [WexHUD showErrorHUDWithStatus:status];
}

static void inline ShowSuccessHUD() {
    [WexHUD showSuccessHUD];
}
static void inline ShowSuccessHUDWithStatus(NSString *status) {
    [WexHUD showSuccessHUDWithStatus:status];
}

static void inline ShowProgressHUD(float progress) {
    [WexHUD showProgress:progress];
}
static void inline ShowProgressHUDWithStatus(float progress, NSString *status) {
    [WexHUD showProgress:progress status:status];
}

static void inline DismissHUD() {
    [WexHUD dismiss];
}

static void inline ShowInfoHUD(NSString *info) {
    //[lsg_HandleUtil showMessage:info status:false];
    [WexHUD showInfo:info];
}
static void inline ShowInfoHUDWithDuration(NSString *info, NSTimeInterval duration) {
    [WexHUD showInfo:info duration:duration];
}




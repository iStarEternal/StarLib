//
//  WexNormalAlertView.m
//  WeXFin
//
//  Created by nyezz on 15/9/23.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexAlertHelper.h"

static WexAlertHelper *currentAlertViewCommon = nil;

@interface WexAlertHelper () <UIAlertViewDelegate>

@property (nonatomic, strong) UIAlertView *alertView;
@property (nonatomic, strong) UIAlertController *alertViewController;

@property (nonatomic, copy) void(^cancelButtonClicked)();
@property (nonatomic, copy) void(^otherHandler1)();
@property (nonatomic, copy) void(^otherHandler2)();

@end

@implementation WexAlertHelper

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitle:(NSString *)otherButtonTitle
                           tag:(NSInteger)tag
                      delegate:(id<WexAlertHelperDelegate>)delegate
                    controller:(UIViewController *)controller {
    
    self.delegate = delegate;
    
    if (title == nil) {
        title = @"";
    }
    
    if (IOS8_OR_LATER) { //
        self.alertViewController = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        self.alertViewController.view.tag = tag;
        
        __weak typeof(self) weakSelf = self;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
            [weakSelf cancelButtonClick:self.alertViewController.view.tag];
        }];
        [self.alertViewController addAction:cancelAction];
        
        if (otherButtonTitle != nil) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
                [weakSelf otherButton1Clicked:self.alertViewController.view.tag];
            }];
            [self.alertViewController addAction:otherAction];
        }
        [controller presentViewController:self.alertViewController animated:YES completion:nil];
    }
    else {
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitle, nil];
        self.alertView.tag = tag;
        [self.alertView show];
    }
    currentAlertViewCommon = self;
}


- (void)showAlertViewInViewController:(UIViewController *)controller
                                title:(NSString *)title
                              message:(NSString *)message
                    cancelButtonTitle:(NSString *)cancelButtonTitle
                   confirmButtonTitle:(NSString *)confirmButtonTitle
                  cancelButtonClicked:(void(^)())cancelButtonClicked
                 confirmButtonClicked:(void(^)())confirmButtonClicked {
    
    [self showAlertViewInViewController:controller
                                  title:title
                                message:message
     
                           cancelButton:cancelButtonTitle
                           otherButton1:confirmButtonTitle
                           otherButton2:nil
     
                          cancelHandler:cancelButtonClicked
                          otherHandler1:confirmButtonClicked
                          otherHandler2:nil];
}

- (void)showAlertViewInViewController:(UIViewController *)controller
                                title:(NSString *)title
                              message:(NSString *)message
                         cancelButton:(NSString *)cancelButton
                         otherButton1:(NSString *)otherButton1
                         otherButton2:(NSString *)otherButton2
                        cancelHandler:(void(^)())cancelHandler
                        otherHandler1:(void(^)())otherHandler1
                        otherHandler2:(void(^)())otherHandler2 {
    
    
    self.cancelButtonClicked = cancelHandler;
    self.otherHandler1 = otherHandler1;
    self.otherHandler2 = otherHandler2;
    
    if (title == nil) {
        title = @"";
    }
    
    if (IOS8_OR_LATER) {
        
        self.alertViewController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        StarWeakSelf
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButton style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            [weakSelf cancelButtonClick:self.alertViewController.view.tag];
        }];
        [self.alertViewController addAction:cancelAction];
        
        if (otherButton1 != nil) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButton1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [weakSelf otherButton1Clicked:self.alertViewController.view.tag];
            }];
            [self.alertViewController addAction:otherAction];
        }
        if (otherButton2 != nil) {
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButton2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                [weakSelf otherButton2Clicked:self.alertViewController.view.tag];
            }];
            [self.alertViewController addAction:otherAction];
        }
        
        
        currentAlertViewCommon = self;
        
        [controller presentViewController:self.alertViewController animated:YES completion:nil];
    }
    else {
        self.alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self
                                          cancelButtonTitle:otherButton1
                                          otherButtonTitles:otherButton1, otherButton2, nil];
        currentAlertViewCommon = self;
        
        [self.alertView show];
    }
}


+ (void)showTitle:(NSString *)title
          message:(NSString *)message
     cancelButton:(NSString *)cancelButton
    confirmButton:(NSString *)confirmButton
    cancleHandler:(void (^)())cancelHandler
   confirmHandler:(void (^)())confirmHandler {
    
    [[[WexAlertHelper alloc] init] showAlertViewInViewController:APP_ROOT_VC title:title message:message cancelButtonTitle:cancelButton confirmButtonTitle:confirmButton cancelButtonClicked:cancelHandler confirmButtonClicked:confirmHandler];
}
+ (void)showMessage:(NSString *)message
       cancelButton:(NSString *)cancelButton
      confirmButton:(NSString *)confirmButton
      cancleHandler:(void (^)())cancelHandler
     confirmHandler:(void (^)())confirmHandler {
    
    [[[WexAlertHelper alloc] init] showAlertViewInViewController:APP_ROOT_VC title:kWexAlertNormalTitle message:message cancelButtonTitle:cancelButton confirmButtonTitle:confirmButton cancelButtonClicked:cancelHandler confirmButtonClicked:confirmHandler];
}

+ (void)showTitle:(NSString *)title
          message:(NSString *)message
     cancelButton:(NSString *)cancelButton
     otherButton1:(NSString *)otherButton1
     otherButton2:(NSString *)otherButton2
    cancleHandler:(void (^)())cancelHandler
    otherHandler1:(void (^)())otherHandler1
    otherHandler2:(void (^)())otherHandler2 {
    
    [[[WexAlertHelper alloc] init] showAlertViewInViewController:APP_ROOT_VC
                                                           title:title
                                                         message:message
     
                                                    cancelButton:cancelButton
                                                    otherButton1:otherButton1
                                                    otherButton2:otherButton2
     
                                                   cancelHandler:cancelHandler
                                                   otherHandler1:otherHandler1
                                                   otherHandler2:otherHandler2];
}

+ (void)showMessage:(NSString *)message
       cancelButton:(NSString *)cancelButton
       otherButton1:(NSString *)otherButton1
       otherButton2:(NSString *)otherButton2
      cancleHandler:(void (^)())cancelHandler
      otherHandler1:(void (^)())otherHandler1
      otherHandler2:(void (^)())otherHandler2 {
    
    [[[WexAlertHelper alloc] init] showAlertViewInViewController:APP_ROOT_VC
                                                           title:kWexAlertNormalTitle
                                                         message:message
     
                                                    cancelButton:cancelButton
                                                    otherButton1:otherButton1
                                                    otherButton2:otherButton2
     
                                                   cancelHandler:cancelHandler
                                                   otherHandler1:otherHandler1
                                                   otherHandler2:otherHandler2];
}


+ (void)closeCurrentAlertView {
    if (IOS8_OR_LATER) { //
        [currentAlertViewCommon.alertViewController dismissViewControllerAnimated:NO completion:^{
            
        }];
    } else {
        [currentAlertViewCommon.alertView dismissWithClickedButtonIndex:-1 animated:NO];
    }
}






#pragma mark -- UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    __weak typeof(self) weakSelf = self;
    if (buttonIndex == 0) {
        [weakSelf cancelButtonClick:alertView.tag];
    }
    else if (buttonIndex == 1){
        [weakSelf otherButton1Clicked:alertView.tag];
    }
    else {
        [weakSelf otherButton2Clicked:alertView.tag];
    }
}



#pragma mark -- WexAlertHelperDelegate

- (void)cancelButtonClick:(NSInteger)tag {
    
    if (self.cancelButtonClicked)
        self.cancelButtonClicked();
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexAlertHelper:didSelectCancelButtonWithTag:)]) {
        [self.delegate wexAlertHelper:self didSelectCancelButtonWithTag:tag];
    }
}

- (void)otherButton1Clicked:(NSInteger)tag {
    
    if (self.otherHandler1)
        self.otherHandler1();
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexAlertHelper:didSelectOtherButtonWithTag:)]) {
        [self.delegate wexAlertHelper:self didSelectOtherButtonWithTag:tag];
    }
}
- (void)otherButton2Clicked:(NSInteger)tag {
    if (self.otherHandler2)
        self.otherHandler2();
}




@end

//
//  WexNormalAlertView.h
//  WeXFin
//
//  Created by nyezz on 15/9/23.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WexMacroDefinition.h"


#define kWexAlertNormalTitle @"温馨提示"

@class WexAlertHelper;

@protocol WexAlertHelperDelegate <NSObject>

@optional
- (void)wexAlertHelper:(WexAlertHelper *)alertHelper didSelectCancelButtonWithTag:(NSInteger)tag;
- (void)wexAlertHelper:(WexAlertHelper *)alertHelper didSelectOtherButtonWithTag:(NSInteger)tag;

@end


@interface WexAlertHelper : NSObject

@property (nonatomic, weak) id<WexAlertHelperDelegate> delegate;

- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
             cancelButtonTitle:(NSString *)cancelButtonTitle
              otherButtonTitle:(NSString *)otherButtonTitle
                           tag:(NSInteger)tag
                      delegate:(id<WexAlertHelperDelegate>)delegate
                    controller:(UIViewController *)controller;

+ (void)closeCurrentAlertView;


+ (void)showTitle:(NSString *)title
          message:(NSString *)message
     cancelButton:(NSString *)cancelButton
    confirmButton:(NSString *)confirmButton
    cancleHandler:(void (^)())cancelHandler
   confirmHandler:(void (^)())confirmHandler;

+ (void)showMessage:(NSString *)message
       cancelButton:(NSString *)cancelButton
      confirmButton:(NSString *)confirmButton
      cancleHandler:(void (^)())cancelHandler
     confirmHandler:(void (^)())confirmHandler;




+ (void)showTitle:(NSString *)title
          message:(NSString *)message
     cancelButton:(NSString *)cancelButton
     otherButton1:(NSString *)otherButton1
     otherButton2:(NSString *)otherButton2
    cancleHandler:(void (^)())cancelHandler
    otherHandler1:(void (^)())otherHandler1
    otherHandler2:(void (^)())otherHandler2;

+ (void)showMessage:(NSString *)message
       cancelButton:(NSString *)cancelButton
       otherButton1:(NSString *)otherButton1
       otherButton2:(NSString *)otherButton2
      cancleHandler:(void (^)())cancelHandler
      otherHandler1:(void (^)())otherHandler1
      otherHandler2:(void (^)())otherHandler2;
@end



static void inline AlertTA(NSString *title, NSString *message, NSString *aButton, void(^aHandler)(void)) {
    [WexAlertHelper showTitle:title message:message cancelButton:aButton confirmButton:nil cancleHandler:aHandler confirmHandler:NULL];
}
static void inline AlertA(NSString *message, NSString *aButton, void(^aHandler)(void)) {
    [WexAlertHelper showMessage:message cancelButton:aButton confirmButton:nil cancleHandler:aHandler confirmHandler:NULL];
}
static void inline AlertTB(NSString *title, NSString *message, NSString *cancelButton, NSString *confirmButton, void(^cancelHandler)(void), void(^confirmHandler)(void)){
    [WexAlertHelper showTitle:title message:message cancelButton:cancelButton otherButton1:confirmButton otherButton2:nil cancleHandler:cancelHandler otherHandler1:confirmHandler otherHandler2:NULL];
}
static void inline AlertB(NSString *message, NSString *cancelButton, NSString *confirmButton, void(^cancelHandler)(void), void(^confirmHandler)(void)){
    [WexAlertHelper showMessage:message cancelButton:cancelButton otherButton1:confirmButton otherButton2:nil cancleHandler:cancelHandler otherHandler1:confirmHandler otherHandler2:NULL];
}
static void inline AlertC(NSString *message, NSString *cancelButton, NSString *otherButton1, NSString *otherButton2, void(^cancelHandler)(void), void(^otherHandler1)(void), void(^otherHandler2)(void)){
    [WexAlertHelper showMessage:message cancelButton:cancelButton otherButton1:otherButton1 otherButton2:otherButton2 cancleHandler:cancelHandler otherHandler1:otherHandler1 otherHandler2:otherHandler2];
}


















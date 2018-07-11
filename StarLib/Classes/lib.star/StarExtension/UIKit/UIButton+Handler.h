//
//  WexButton_Handler.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/9/27.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (StarButtonEnabledHandler)

@property (nonatomic, strong) NSArray<UIButton *> *star_handleCheckButtons;
@property (nonatomic, copy)  BOOL(^star_handleCheckButtonsBlock)(NSArray<UIButton *> *star_handleCheckButtons);

@property (nonatomic, strong) NSArray<UITextField *> *star_handleTextFields;
@property (nonatomic, copy)  BOOL(^star_handleTextFieldsBlock)(NSArray<UITextField *> *star_handleTextFields);

@property (nonatomic, copy)  BOOL(^star_handleBlock)();


- (void)star_addHandleCheckButtons:(NSArray<UIButton *> *)star_handleCheckButtons;
/// 会存在内存泄漏隐患，一定要用weakSelf
- (void)star_addHandleCheckButtons:(NSArray<UIButton *> *)star_handleCheckButtons
           handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *star_handleCheckButtons))star_handleCheckButtonsBlock;


- (void)star_addHandleTextFields:(NSArray<UITextField *> *)star_handleTextFields;
/// 会存在内存泄漏隐患，一定要用weakSelf
- (void)star_addHandleTextFields:(NSArray<UITextField *> *)star_handleTextFields
           handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *star_handleTextFields))star_handleTextFieldsBlock;


// 触发
- (void)star_triggerHandler;

@end

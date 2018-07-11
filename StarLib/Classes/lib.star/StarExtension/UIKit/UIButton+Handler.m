//
//  WexButton_Handler.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/9/27.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "UIButton+Handler.h"
#import <objc/runtime.h>
#import "StarExtension.h"

@implementation UIButton (StarButtonEnabledHandler)

#pragma mark - Getter & Setter

static NSString *StarHandleCheckButtonsKey = @"Mark.By.Star.HandleCheckButtons";
- (NSArray<UIButton *> *)star_handleCheckButtons {
    return objc_getAssociatedObject(self, &StarHandleCheckButtonsKey);
}
- (void)setStar_handleCheckButtons:(NSArray<UIButton *> *)star_handleCheckButtons {
    objc_setAssociatedObject(self, &StarHandleCheckButtonsKey, star_handleCheckButtons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


static NSString *StarHandleCheckButtonsBlockKey = @"Mark.By.Star.HandleCheckButtonsBlock";
- (BOOL (^)(NSArray<UIButton *> *))star_handleCheckButtonsBlock {
    id obj = objc_getAssociatedObject(self, &StarHandleCheckButtonsBlockKey);
    return obj;
}
- (void)setStar_handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *))star_handleCheckButtonsBlock {
    objc_setAssociatedObject(self, &StarHandleCheckButtonsBlockKey, star_handleCheckButtonsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


static NSString *StarHandleTextFieldsKey = @"Mark.By.Star.HandleTextFields";
- (NSArray<UITextField *> *)star_handleTextFields {
    return objc_getAssociatedObject(self, &StarHandleTextFieldsKey);
}
- (void)setStar_handleTextFields:(NSArray<UITextField *> *)star_handleTextFields {
    objc_setAssociatedObject(self, &StarHandleTextFieldsKey, star_handleTextFields, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


static NSString *StarHandleTextFieldsBlockKey = @"Mark.By.Star.HandleTextFieldsBlock";
- (BOOL (^)(NSArray<UITextField *> *))star_handleTextFieldsBlock {
    return objc_getAssociatedObject(self, &StarHandleTextFieldsBlockKey);
}
- (void)setStar_handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *))star_handleTextFieldsBlock {
    objc_setAssociatedObject(self, &StarHandleTextFieldsBlockKey, star_handleTextFieldsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


static void *StarHandleBlockKey = &StarHandleBlockKey;
- (BOOL (^)())star_handleBlock {
    return objc_getAssociatedObject(self, &StarHandleBlockKey);
}
- (void)setStar_handleBlock:(BOOL (^)())star_handleBlock {
    objc_setAssociatedObject(self, &StarHandleBlockKey, star_handleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (void)star_addHandleCheckButtons:(NSArray<UIButton *> *)star_handleCheckButtons {
    [self star_addHandleCheckButtons:star_handleCheckButtons handleCheckButtonsBlock:NULL];
}
- (void)star_addHandleCheckButtons:(NSArray<UIButton *> *)star_handleCheckButtons
           handleCheckButtonsBlock:(BOOL (^)(NSArray<UIButton *> *))star_handleCheckButtonsBlock {
    
    self.star_handleCheckButtons = star_handleCheckButtons;
    self.star_handleCheckButtonsBlock = star_handleCheckButtonsBlock;
    for (UIButton *checkButton in star_handleCheckButtons) {
        [checkButton addTarget:self action:@selector(wex_handleCheckButtonValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self star_triggerHandler];
}

- (void)star_addHandleTextFields:(NSArray<UITextField *> *)star_handleTextFields {
    [self star_addHandleTextFields:star_handleTextFields handleTextFieldsBlock:NULL];
}
- (void)star_addHandleTextFields:(NSArray<UITextField *> *)star_handleTextFields
           handleTextFieldsBlock:(BOOL (^)(NSArray<UITextField *> *))star_handleTextFieldsBlock {
    
    self.star_handleTextFieldsBlock = star_handleTextFieldsBlock;
    self.star_handleTextFields = star_handleTextFields;
    for (UITextField *textField in star_handleTextFields) {
        [textField addTarget:self action:@selector(wex_handleTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    [self star_triggerHandler];
}


- (void)wex_handleCheckButtonValueChanged:(UIButton *)sender {
    [self star_triggerHandler];
}
- (void)wex_handleTextFieldEditingChanged:(UITextField *)sender {
    [self star_triggerHandler];
}


#pragma mark -

- (void)star_triggerHandler {
    
    BOOL enabled = true;
    
    // 通用
    if (self.star_handleBlock) {
        enabled = self.star_handleBlock();
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    // 复选按钮
    if (self.star_handleCheckButtons) {
        if (self.star_handleCheckButtonsBlock) {
            enabled = self.star_handleCheckButtonsBlock(self.star_handleCheckButtons);
        }
        else {
            enabled = [self star_EnabledForCheckButtons];
        }
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    // 输入框
    if (self.star_handleTextFields) {
        if (self.star_handleTextFieldsBlock) {
            enabled = self.star_handleTextFieldsBlock(self.star_handleTextFields);
        }
        else {
            enabled = [self star_EnabledForTextFields];
        }
    }
    if (!enabled) {
        self.enabled = enabled;
        return;
    }
    
    
    
    // 最后
    self.enabled = enabled;
}

- (BOOL)star_EnabledForCheckButtons {
    for (UIButton *checkButton in self.star_handleCheckButtons) {
        if (!checkButton.isSelected) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)star_EnabledForTextFields {
    for (UITextField *textField in self.star_handleTextFields) {
        if ([NSString isNullOrWhiteSpace:textField.text]) {
            return false;
        }
    }
    return YES;
}


@end

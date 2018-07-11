//
//  WexTextField.m
//  WeXFin
//
//  Created by Mark on 15/7/21.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexTextField.h"

#pragma mark - WexTextFieldHelper

@interface WexTextFieldHelper() <UITextFieldDelegate>

@property (nonatomic, weak) WexTextField* textField;

@end

@implementation WexTextFieldHelper

- (instancetype)initWithTextField:(WexTextField*)textField {
    self = [super init];
    
    if (self)
    {
        self.textField = textField;
        self.textField.delegate = self;
    }
    
    return self;
}

#pragma mark - UITextFieldDelegate

//
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)])
    {
        return [pDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    // 判断是否达到输入上限
    WexTextField* wexTextField = (WexTextField*)textField;
    
    
    // 达到上限就禁止继续输入
    if ([wexTextField isReachMaxCountWithCharactersInRange:range replacementString:string])
    {
        return NO;
    }
    
    return YES;
}

// 下面函数都是转发UITextFieldDelegate。。。
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [pDelegate textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        return [pDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexTextField*)textField).wexTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [pDelegate textFieldDidEndEditing:textField];
    }
}

@end


#pragma mark - WexTextField

@interface WexTextField ()

@property (nonatomic, strong) WexTextFieldHelper* helper;

@end

@implementation WexTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

+ (instancetype)wexTextField {
    return [[self alloc] init];
}

+ (instancetype)wexTextFieldWithDelegate:(id)delegate {
    
    WexTextField* textField = [[self alloc] init];
    
    textField.wexTextFieldDelegate = delegate;
    
    return textField;
}


// 是否达到输入的上限
- (BOOL)isReachMaxCountWithCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    if (_maxCount == 0)
    {
        return NO;
    }
    
    NSString* aString = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    if (aString.length > _maxCount)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - Private Methods

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _maxCount = 0;
    _helper = [[WexTextFieldHelper alloc] initWithTextField:self];
}

- (void)textFieldChanged:(UITextField *)textField {
    
}

@end

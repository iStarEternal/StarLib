//
//  WexAmountTextField.m
//  AmountTextFieldTest
//
//  Created by Mark on 15/9/15.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexAmountTextField.h"




#pragma mark - WexAmountTextFieldHelper

@interface WexAmountTextFieldHelper() <UITextFieldDelegate>

@property (nonatomic, weak) WexAmountTextField* textField;

@end


@implementation WexAmountTextFieldHelper

- (instancetype)initWithTextField:(WexAmountTextField*)textField {
    self = [super init];
    
    if (self)
    {
        self.textField = textField;
        self.textField.delegate = self;
    }
    
    return self;
}

// 获得整数部分
- (NSString *)getIntegerPart:(NSString*)amount {
    NSRange range = [amount rangeOfString:@"."];
    
    if (range.location != NSNotFound)
    {
        return [amount substringToIndex:range.location];
    }
    else
    {
        return amount;
    }
}

// 获得小数部分
- (NSString *)getDecimalPart:(NSString*)amount {
    NSRange range = [amount rangeOfString:@"."];
    
    if (range.location != NSNotFound)
    {
        return [amount substringWithRange:NSMakeRange(range.location + 1, amount.length - range.location - 1)];
    }
    else
    {
        return @"";
    }
}

#pragma mark - UITextFieldDelegate

// 在WexAmountTextField，此delegate函数不会被转发，请注意！
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    WexAmountTextField* amountTextField = (WexAmountTextField*)textField;
    
    NSString* aString = [amountTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    // 最多只能包含一个"."
    if ([string isEqualToString:@"."])
    {
        if ([amountTextField.text rangeOfString:@"."].location != NSNotFound)
        {
            return NO;
        }
    }
    
    // 整数部分不能超过上限，在maxIntegerCount不为0的时候判断
    if (amountTextField.maxIntegerCount != 0)
    {
        NSString* amountIntegerPart = [self getIntegerPart:aString];
        if (amountIntegerPart.length > amountTextField.maxIntegerCount)
        {
            return NO;
        }
    }
    
    // 小数部分不能超过上限，在maxDecimalCount不为0的时候判断（默认maxDecimalCount为2）
    if (amountTextField.maxDecimalCount != 0)
    {
        NSString* amountDecimalPart = [self getDecimalPart:aString];
        if (amountDecimalPart.length > amountTextField.maxDecimalCount)
        {
            return NO;
        }
    }
    
    return YES;
}

// 下面函数都是转发UITextFieldDelegate。。。
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)])
    {
        return [pDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldClear:)])
    {
        return [pDelegate textFieldShouldClear:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)])
    {
        return [pDelegate textFieldShouldEndEditing:textField];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldShouldReturn:)])
    {
        return [pDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)])
    {
        [pDelegate textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    id<UITextFieldDelegate> pDelegate = ((WexAmountTextField*)textField).amountTextFieldDelegate;
    
    if([pDelegate respondsToSelector:@selector(textFieldDidEndEditing:)])
    {
        [pDelegate textFieldDidEndEditing:textField];
    }
}

@end



#pragma mark - WexAmountTextField

@interface WexAmountTextField ()

@property (nonatomic, strong) WexAmountTextFieldHelper* helper;

@end

@implementation WexAmountTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (NSString*)getAmountText {
    if ([self.text isEqualToString:@""])
    {
        return @"0";
    }
    else if ([self.text isEqualToString:@"."])
    {
        return @"0";
    }
    else
    {
        NSRange range = [self.text rangeOfString:@"."];
        
        if (range.location == 0)
        {
            NSMutableString* str = [[NSMutableString alloc] initWithString:@"0"];
            [str appendString:self.text];
            
            return str;
        }
        else if (range.location == (self.text.length - 1))
        {
            NSMutableString* str = [[NSMutableString alloc] initWithString:self.text];
            [str appendString:@"0"];
            
            return str;
        }
        
        return self.text;
    }
}

- (void)setTextFieldMaxIntegerCount:(NSInteger)count {
    _maxIntegerCount = count;
}


#pragma mark - Private Methods

- (void)commonInit {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.borderStyle = UITextBorderStyleNone;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _maxIntegerCount = 0;
    _maxDecimalCount = 2;
    
    _helper = [[WexAmountTextFieldHelper alloc] initWithTextField:self];
}

- (void)textFieldChanged:(UITextField *)textField {
   
}


@end

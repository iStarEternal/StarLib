//
//  PythiaPlainCell.m
//  Pythia
//
//  Created by 星星 on 16/11/22.
//  Copyright © 2016年 weicaifu. All rights reserved.
//

#import "PythiaPlainTextFieldCell.h"

#import "WexIdentityCardKeyboard.h"

@interface PythiaPlainTextFieldCell() <WexIdentityCardKeyboardDelegate>

@property (assign, nonatomic) NSRange selectRange;

@end

@implementation PythiaPlainTextFieldCell

- (void)wex_loadViews {
    [super wex_loadViews];
    
    _contentTextFieldLeftSpace = 0;
    _textFieldType = PythiaPlainTextFieldTypeNormal;
    
    [self resetTextField];
}

- (void)resetTextField {

    
    UITextField *temptf = self.contentTextField;
    
    if (!temptf) {
        
        
    }
    
    
    [self.contentTextField removeFromSuperview];
    
    switch (self.textFieldType) {
            
        case PythiaPlainTextFieldTypeNormal: {
            
            WexTextField *textField = [[WexTextField alloc] init];
            self.contentTextField = textField;
            [self.contentView addSubview:textField];
            textField.textColor         = @"#383838".xc_color;
            textField.font              = @"15px".xc_font;
            textField.placeHolderFont   = @"15px".xc_font;
            textField.placeHolderColor  = @"#DDDDDD".xc_color;
            textField.placeholder       = @"请输入".localizedString;
            textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
            
        }
            break;
            
        case PythiaPlainTextFieldTypeAmount: {
            WexAmountTextField *textField = [[WexAmountTextField alloc] init];
            self.contentTextField = textField;
            [self.contentView addSubview:textField];
            textField.textColor         = @"#383838".xc_color;
            textField.font              = @"15px".xc_font;
            textField.placeHolderFont   = @"15px".xc_font;
            textField.placeHolderColor  = @"#DDDDDD".xc_color;
            textField.placeholder       = @"请输入金额".localizedString;
            textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
        }
            break;
            
        case PythiaPlainTextFieldTypeIDCard: {
            WexTextField *textField = [[WexTextField alloc] init];
            [self.contentView addSubview:textField];
            self.contentTextField = textField;
            textField.textColor         = @"#383838".xc_color;
            textField.font              = @"15px".xc_font;
            textField.placeHolderFont   = @"15px".xc_font;
            textField.placeHolderColor  = @"#DDDDDD".xc_color;
            textField.placeholder       = @"请输入身份证号码".localizedString;
            textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
            textField.keyboardType      = UIKeyboardTypeASCIICapable;
            textField.maxCount          = 18;
            
            WexIdentityCardKeyboard *keyboard = [[WexIdentityCardKeyboard alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 216)];
            keyboard.delegate = self;
            textField.inputView = keyboard;
        }
            break;
            
        case PythiaPlainTextFieldTypePhone: {
            
            WexPhoneTextField *textField = [[WexPhoneTextField alloc] init];
            [self.contentView addSubview:textField];
            self.contentTextField = textField;
            textField.textColor         = @"#383838".xc_color;
            textField.font              = @"15px".xc_font;
            textField.placeHolderFont   = @"15px".xc_font;
            textField.placeHolderColor  = @"#DDDDDD".xc_color;
            textField.placeholder       = @"请输入手机号".localizedString;
            textField.clearButtonMode   = UITextFieldViewModeWhileEditing;
        }
            break;
            
        default:
            break;
    }
}



- (void)wex_layoutConstraints {
    [super wex_layoutConstraints];
    
    [self.contentTextField remakeConstraints:^(MASConstraintMaker *make) {
        if (self.contentTextFieldLeftSpace) {
            make.left.equalTo(self.contentTextFieldLeftSpace);
        }
        else {
            make.left.equalTo(self.titleLabel.mas_right).offset(8);
        }
        make.right.equalTo(self.contentLabel);
        make.top.bottom.equalTo(0);
    }];
}

- (void)setContentTextFieldLeftSpace:(CGFloat)contentTextFieldLeftSpace {
    _contentTextFieldLeftSpace = contentTextFieldLeftSpace;
    [self wex_layoutConstraints];
}

- (void)setTextFieldType:(PythiaPlainTextFieldType)textFieldType {
    _textFieldType = textFieldType;
    [self resetTextField];
    [self wex_layoutConstraints];
}


- (WexTextField *)p_normalTextField {
    if (self.textFieldType == PythiaPlainTextFieldTypeNormal) {
        return (id)self.contentTextField;
    }
    return nil;
}

- (WexPhoneTextField *)p_phoneTextField {
    if (self.textFieldType == PythiaPlainTextFieldTypePhone) {
        return (id)self.contentTextField;
    }
    return nil;
}

- (WexAmountTextField *)p_amountTextField {
    if (self.textFieldType == PythiaPlainTextFieldTypeAmount) {
        return (id)self.contentTextField;
    }
    return nil;
}

- (WexTextField *)p_IDCardTextField {
    if (self.textFieldType == PythiaPlainTextFieldTypeIDCard) {
        return (id)self.contentTextField;
    }
    return nil;
}





#pragma mark - WexIdentityCardKeyboard delegate

- (void)numberKeyboardBackspace {
    
    if (self.p_IDCardTextField && self.p_IDCardTextField.text.length != 0) {
        _selectRange = [self.p_IDCardTextField selectedRange];
        if (_selectRange.location > 0) {
            NSMutableString *textStr = [NSMutableString stringWithString:self.p_IDCardTextField.text];
            [textStr replaceCharactersInRange:NSMakeRange(_selectRange.location - 1, 1) withString:@""];
            self.p_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(_selectRange.location - 1, 1);
            [self.p_IDCardTextField insertSelectedRange:_selectRange];
        }
    }
    [self.p_IDCardTextField sendActionsForControlEvents:UIControlEventEditingChanged];
}

- (void)numberKeyboardInput:(NSString *)number {
    
    if (self.p_IDCardTextField && self.p_IDCardTextField.text.length < 18 ) {
        _selectRange = [self.p_IDCardTextField selectedRange];
        NSMutableString *textStr = [NSMutableString stringWithString:self.p_IDCardTextField.text];
        if (!_selectRange.location) {
            [textStr insertString:[NSString stringWithFormat:@"%@",number] atIndex:0];
            self.p_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(1, 1);
            [self.p_IDCardTextField insertSelectedRange:_selectRange];
        }
        else{
            [textStr insertString:[NSString stringWithFormat:@"%@",number] atIndex:_selectRange.location];
            self.p_IDCardTextField.text = textStr;
            _selectRange = NSMakeRange(_selectRange.location + 1, 1);
            [self.p_IDCardTextField insertSelectedRange:_selectRange];
        }
    }
    [self.p_IDCardTextField sendActionsForControlEvents:UIControlEventEditingChanged];
}

@end

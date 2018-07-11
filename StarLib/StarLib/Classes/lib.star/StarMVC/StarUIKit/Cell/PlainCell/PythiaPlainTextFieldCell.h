//
//  PythiaPlainTextFieldCell.h
//  Pythia
//
//  Created by 星星 on 16/11/22.
//  Copyright © 2016年 weicaifu. All rights reserved.
//


#import "PythiaPlainCell.h"


typedef NS_ENUM(NSUInteger, PythiaPlainTextFieldType) {
    PythiaPlainTextFieldTypeNormal, // 默认输入 WexTextField
    PythiaPlainTextFieldTypeIDCard, // 身份证输入框
    PythiaPlainTextFieldTypeAmount, // 金额输入框
    PythiaPlainTextFieldTypePhone,  // 手机输入框
};

@interface PythiaPlainTextFieldCell : PythiaPlainCell

@property (nonatomic, strong) UITextField *contentTextField;            // 在原有基础上取代contentLabel
@property (nonatomic, assign) CGFloat contentTextFieldLeftSpace;        // 距离左侧距离，默认为0，
@property (nonatomic, assign) PythiaPlainTextFieldType textFieldType;   // 输入框类型


// MARK: - 返回对应的TextField元控件
@property (nonatomic, strong, readonly) WexTextField        *p_normalTextField; // PythiaPlainTextFieldTypeNormal
@property (nonatomic, strong, readonly) WexAmountTextField  *p_amountTextField; // PythiaPlainTextFieldTypeAmount
@property (nonatomic, strong, readonly) WexTextField        *p_IDCardTextField; // PythiaPlainTextFieldTypeIDCard
@property (nonatomic, strong, readonly) WexPhoneTextField   *p_phoneTextField;  // PythiaPlainTextFieldTypePhone

@end

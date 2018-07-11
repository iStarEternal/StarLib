//
//  WexTextField.h
//  WeXFin
//
//  Created by Mark on 15/7/21.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexBaseTextField.h"

#pragma mark - Helper

@interface WexTextFieldHelper : NSObject

@end


#pragma mark - TextField

@interface WexTextField : WexBaseTextField

// maxCount 长度上限，默认为0，也就是不做长度限制
// maxCount的实现依赖于下面的delegate函数
// - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
// 如果自行实现改delegate函数，则可调用isReachMaxCountWithCharactersInRange函数来做判断
@property (nonatomic) NSInteger maxCount;

@property (nonatomic, weak) id<UITextFieldDelegate> wexTextFieldDelegate;

// 是否达到输入的上限
- (BOOL)isReachMaxCountWithCharactersInRange:(NSRange)range replacementString:(NSString*)string;

@end

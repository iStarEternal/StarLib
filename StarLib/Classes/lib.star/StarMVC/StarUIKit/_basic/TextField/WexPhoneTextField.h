//
//  WexPhoneTextField.h
//  WexWeiCaiFu
//
//  Created by Mark on 15/10/20.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexBaseTextField.h"

@interface WexPhoneTextFieldHelper : NSObject

@end


@interface WexPhoneTextField : WexBaseTextField

/** 委托 */
@property (nonatomic, weak) id<UITextFieldDelegate> phoneTextFieldDelegate;

@property (nonatomic, copy) NSString *phoneText;
@property (nonatomic, strong) NSString *previousTextFieldContent;
@property (nonatomic, strong) UITextRange *previousSelection;

@end


//
//  WexAmountTextField.h
//  AmountTextFieldTest
//
//  Created by Mark on 15/9/15.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WexBaseTextField.h"


#pragma mark - WexAmountTextFieldHelper

@interface WexAmountTextFieldHelper : NSObject

@end


#pragma mark - WexAmountTextField

@interface WexAmountTextField : WexBaseTextField

@property (nonatomic) NSInteger maxIntegerCount;
@property (nonatomic) NSInteger maxDecimalCount;
@property (nonatomic, weak) id<UITextFieldDelegate> amountTextFieldDelegate;

- (void)setTextFieldMaxIntegerCount:(NSInteger)count;

- (NSString*)getAmountText;

@end

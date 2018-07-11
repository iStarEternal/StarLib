//
//  WexEquation.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/2.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WexEquation : NSObject


+ (BOOL)isNullOrWhiteSpace:(NSString *)string;

//+ (BOOL)isNotNullOrWhiteSpace:(NSString *)string;

+ (BOOL)isMobilePhone:(NSString *)string;

+ (BOOL)isEmail:(NSString *)string;

+ (BOOL)isBankCard:(NSString *)string;

+ (BOOL)isSMSCode:(NSString *)string;

+ (BOOL)isPassword:(NSString *)string;

+ (BOOL)isName:(NSString *)name;

+ (BOOL)isIDCard:(NSString *)string;

@end

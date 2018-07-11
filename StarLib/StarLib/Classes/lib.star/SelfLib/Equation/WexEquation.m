//
//  WexEquation.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/2.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexEquation.h"
#import "StarExtension.h"


#define MinLength_Password_Login (6) // 支付密码 (登录)
#define MaxLength_Password_Login (20) // 支付密码 (登录)
#define MinLength_RealName (2) // 真实姓名
#define MaxLength_RealName (10) // 真实姓名

#define Regular_MobilePhone (@"^([1])([0-9]{10})$") //手机号，首位为1
#define Regular_Email       (@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b") //邮箱
#define Regular_BankCardNo  (@"^[0-9\\-]{15,25}$")// 银行卡号 15~25位数字
#define Regular_SMSCode     (@"^[0-9]{6}$")
#define Regular_IDCard      (@"^(\\d{18}$|^\\d{17}(\\d|X|x))$") // 身份证

@implementation WexEquation


+ (BOOL)isNullOrWhiteSpace:(NSString *)string {
    return [NSString isNullOrWhiteSpace:string];
}

+ (BOOL)isNotNullOrWhiteSpace:(NSString *)string {
    return ![NSString isNullOrWhiteSpace:string];
}

+ (BOOL)isMobilePhone:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [self checkString:string usingRegularExpression:Regular_MobilePhone];
}

+ (BOOL)isEmail:(NSString *)string {
    return [self checkString:string usingRegularExpression:Regular_Email];
}

+ (BOOL)isBankCard:(NSString *)string {
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [self checkString:string usingRegularExpression:Regular_BankCardNo];
}

+ (BOOL)isSMSCode:(NSString *)string {
    return [self checkString:string usingRegularExpression:Regular_SMSCode];
}

+ (BOOL)isPassword:(NSString *)string {
    if (string.length < MinLength_Password_Login) {
        return NO;
    }
    
    if (string.length > MaxLength_Password_Login) {
        return NO;
    }
    return YES;
}

+ (BOOL)isName:(NSString *)name {
    if (name.length < MinLength_RealName) {
        return NO;
    }
    
    if (name.length > MaxLength_RealName) {
        return NO;
    }
    return YES;
}

+ (BOOL)isIDCard:(NSString *)string {
    return [self checkString:string usingRegularExpression:Regular_IDCard];
}

// 使用正则表达式校验字符串
+ (BOOL)checkString:(NSString *)string usingRegularExpression:(NSString *)regularExpression {
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regularExpression options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger number = [regExp numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    return (number > 0);
}

@end

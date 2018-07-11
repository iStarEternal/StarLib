//
//  NSString+Price.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "NSString+Money.h"


@implementation NSString (Price)

#pragma mark - 金额比较

// 金额大小比较
- (NSComparisonResult)comparePrice:(NSString*)price {
    NSDecimalNumber* priceNumber1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber* priceNumber2 = [NSDecimalNumber decimalNumberWithString:price];
    NSComparisonResult result = [priceNumber1 compare:priceNumber2];
    return result;
}

- (BOOL)isEqualToPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedSame;
}

- (BOOL)isGreaterThanPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedDescending;
}

- (BOOL)isGreaterThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedDescending || comparResult == NSOrderedSame;
}

- (BOOL)isLessThanPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedAscending;
}

- (BOOL)isLessThanOrEqualToPrice:(NSString *)price {
    NSComparisonResult comparResult = [self comparePrice:price];
    return comparResult == NSOrderedAscending || comparResult == NSOrderedSame;
}



#pragma mark - 加减乘除 各保留两位

// 保留小数，默认保存两位
- (unsigned short)pointOmit {
    return 2;
}

// 保留小数的Format -- 暂未使用
- (NSString *)pointOmitFormat {
    switch ([self pointOmit]) {
            
        case 0:
            return @"%.0f";
            break;
            
        case 1:
            return @"%.1f";
            break;
            
        case 2:
            return @"%.2f";
            break;
            
        case 3:
            return @"%.3f";
            break;
            
        case 4:
            return @"%.4f";
            break;
            
        case 5:
            return @"%.5f";
            break;
            
        case 6:
            return @"%.6f";
            break;
            
        default:
            return @"%.2f";
            break;
    }
}

// 舍入规则，默认只入不舍
- (NSRoundingMode)roundingMode {
    return NSRoundUp;
}

// 配置舍入规则 以及小数点后保留几位
- (NSDecimalNumberHandler *)behavior {
    return [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:self.roundingMode
                                                                  scale:self.pointOmit
                                                       raiseOnExactness:false
                                                        raiseOnOverflow:false
                                                       raiseOnUnderflow:false
                                                    raiseOnDivideByZero:false];
}

- (NSString *)priceByAdding:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByAdding:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceBySubtracting:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberBySubtracting:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByMultiplyingBy:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByMultiplyingBy:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByDividingBy:(NSString *)number {
    
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    
    NSDecimalNumber *result = [numberA decimalNumberByDividingBy:numberB withBehavior:self.behavior];
    
    return [NSString stringWithFormat:@"%.2f", result.doubleValue];
}

- (NSString *)priceByOmit {
    return [self priceByAdding:@"0"];
}


#pragma mark - 获取

// 得到金额的整数位数
- (NSInteger)priceIntegerPartCount {
    
    NSString *integerPart;
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        integerPart = [self substringToIndex:range.location];
    }
    else {
        integerPart = self;
    }
    return integerPart.length;
}

// 获得小数部分
- (NSString *)priceDecimalPart {
    NSRange range = [self rangeOfString:@"."];
    if (range.location != NSNotFound) {
        return [self substringWithRange:NSMakeRange(range.location + 1, self.length - range.location - 1)];
    }
    else {
        return @"";
    }
}


- (NSString *)stringByAddingThousandsSeparator {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:@(self.doubleValue)];
    
    //    NSArray *numberCom = [self componentsSeparatedByString:@"."];
    //
    //    NSString *intSection;
    //    NSString *decimalSection;
    //
    //    // 非正常数字
    //    if (numberCom.count > 2) {
    //        return self;
    //    }
    //    // 包含小数点
    //    else if (numberCom.count == 2) {
    //        intSection = numberCom.firstObject;
    //        decimalSection = numberCom.lastObject;
    //    }
    //    // 不包含小数点
    //    else if (numberCom.count == 1) {
    //        intSection = numberCom.firstObject;
    //        decimalSection = nil;
    //    }
    //
    //
    //    // 计算位数
    //    int count = 0;
    //    long long int a = self.longLongValue;
    //    while (a != 0) {
    //        count++;
    //        a /= 10;
    //    }
    //
    //    NSMutableString *string = [NSMutableString stringWithString:intSection];
    //    NSMutableString *newstring = [NSMutableString string];
    //    while (count > 3) {
    //        count -= 3;
    //        NSRange rang = NSMakeRange(string.length - 3, 3);
    //        NSString *str = [string substringWithRange:rang];
    //        [newstring insertString:str atIndex:0];
    //        [newstring insertString:@"," atIndex:0];
    //        [string deleteCharactersInRange:rang];
    //    }
    //    [newstring insertString:string atIndex:0];
    //
    //    if (decimalSection) {
    //        [newstring appendString:@"."];
    //        [newstring appendString:decimalSection];
    //    }
    //    
    //    return newstring;
}

@end

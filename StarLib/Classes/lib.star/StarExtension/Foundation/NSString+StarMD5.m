//
//  NSString+StarMD5.m
//  Pythia
//
//  Created by 星星 on 16/11/29.
//  Copyright © 2016年 weicaifu. All rights reserved.
//

#import "NSString+StarMD5.h"
#import<CommonCrypto/CommonDigest.h>

@implementation NSString (StarMD5)

/** 16位 MD5 */
- (NSString *)md5For16 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr),result );
    NSMutableString *hash =[NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

/** 32位 MD5 */
- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
    CC_MD5(cStr, (CC_LONG)self.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return [result uppercaseString];
    //    return result;
}

@end

//
//  WexMD5Kit.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/12/27.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define FileHashDefaultChunkSizeForReadingData 1024*8 // 8K

@interface WexMD5Kit : NSObject

//计算NSData 的MD5值
+ (NSString *)getMD5WithData:(NSData*)data;

//计算字符串的MD5值，
+ (NSString *)getmd5WithString:(NSString*)string;

//计算大文件的MD5值
+ (NSString *)getFileMD5WithPath:(NSString*)path;

@end

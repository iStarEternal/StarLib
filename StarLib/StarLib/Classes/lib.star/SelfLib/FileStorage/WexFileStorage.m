//
//  WexFileStorage.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexFileStorage.h"

@interface WexFileStorage ()

@end

@implementation WexFileStorage



+ (NSData *)fileForName:(NSString *)fileName {
    return [NSData dataWithContentsOfFile:[FileStoragePath() stringByAppendingPathComponent:fileName]];
}

+ (BOOL)storeFile:(NSData *)file fileName:(NSString *)fileName {
    [self createDirctory:fileName];
    return [file writeToFile:[FileStoragePath() stringByAppendingPathComponent:fileName] atomically:true];
}



+ (BOOL)storeDictionary:(NSDictionary *)dict fileName:(NSString *)fileName {
    [self createDirctory:fileName];
    return [dict writeToFile:[FileStoragePath() stringByAppendingPathComponent:fileName] atomically:true];
}

+ (NSDictionary *)dictionaryForName:(NSString *)fileName {
    return [NSDictionary dictionaryWithContentsOfFile:[FileStoragePath() stringByAppendingPathComponent:fileName]];
}



+ (BOOL)storeArray:(NSArray *)array fileName:(NSString *)fileName {
    [self createDirctory:fileName];
    return [array writeToFile:[FileStoragePath() stringByAppendingPathComponent:fileName] atomically:true];
}

+ (NSArray *)arrayForName:(NSString *)fileName {
   return [NSArray arrayWithContentsOfFile:[FileStoragePath() stringByAppendingPathComponent:fileName]];
}



+ (BOOL)removeStoreForName:(NSString *)fileName {
    return [[NSFileManager defaultManager] removeItemAtPath:[FileStoragePath() stringByAppendingPathComponent:fileName] error:nil];
}


+ (void)createDirctory:(NSString *)fileName {
    NSString *filePath = [[FileStoragePath() stringByAppendingPathComponent:fileName] stringByDeletingLastPathComponent];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:true attributes:NULL error:NULL];
    }
}

@end

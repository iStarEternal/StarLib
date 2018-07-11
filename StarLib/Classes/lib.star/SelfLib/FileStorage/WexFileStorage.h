//
//  WexFileStorage.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/8/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>


static inline NSString * DocumentDirectoryPath() {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
}

static inline NSString * FileStoragePath() {
    return [DocumentDirectoryPath() stringByAppendingPathComponent:@"File Storage"];
}


@interface WexFileStorage : NSObject

+ (NSData *)fileForName:(NSString *)fileName;
+ (BOOL)storeFile:(NSData *)file fileName:(NSString *)fileName;


+ (BOOL)storeDictionary:(NSDictionary *)dict fileName:(NSString *)fileName;
+ (NSDictionary *)dictionaryForName:(NSString *)fileName;


+ (BOOL)storeArray:(NSArray *)array fileName:(NSString *)fileName;
+ (NSArray *)arrayForName:(NSString *)fileName;


+ (BOOL)removeStoreForName:(NSString *)fileName;


@end

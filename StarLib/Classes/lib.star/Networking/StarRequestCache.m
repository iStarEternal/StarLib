//
//  StarRequestCache
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "StarRequestCache.h"
#import "WexFileStorage.h"
#import "WexApplicationInfo.h"

@interface StarRequestCache ()

@property (nonatomic, strong) NSMutableArray* adapterArray;
@property (nonatomic) BOOL bGlobalException;


@end

@implementation StarRequestCache

+ (StarRequestCache *)shardCache {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

    + (NSString *)userID {
        return @"";
    }

    
+ (BOOL)storeData:(NSDictionary *)data forKey:(NSString *)key {
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *memid = [NSString isNullOrWhiteSpace:self.userID] ? @"unknown" : self.userID;
        NSString *rkey = [NSString stringWithFormat:@"RequestCache/%@_%@_%@", key, memid, [WexApplicationInfo appVersion]].md5;
        
        NSMutableData *rdata = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:rdata];
        [archiver encodeObject:data forKey:@"_rdata"];
        [archiver finishEncoding];
        
        return [WexFileStorage storeFile:rdata fileName:rkey];
    }
    return false;
}

+ (NSDictionary *)dataForKey:(NSString *)key {
    
    NSString *memid = [NSString isNullOrWhiteSpace:self.userID] ? @"unknown" : self.userID;
    NSString *rkey = [NSString stringWithFormat:@"RequestCache/%@_%@_%@", key, memid, [WexApplicationInfo appVersion]].md5;
    
    NSData *rdata = [WexFileStorage fileForName:rkey];
    if (rdata) {
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:rdata];
        NSDictionary *data = [unarchiver decodeObjectForKey:@"_rdata"];
        [unarchiver finishDecoding];
        return data;
    }
    return nil;
}


@end

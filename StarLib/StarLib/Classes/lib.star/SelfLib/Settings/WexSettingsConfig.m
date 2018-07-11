//
//  WexSettingsConfig.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/25.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexSettingsConfig.h"


#define WexSettings [NSUserDefaults standardUserDefaults]


@implementation WexSettingsConfig

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    [WexSettings setObject:object forKey:key];
    [WexSettings synchronize];
    
}

+ (id)objectForKey:(NSString *)key {
    return [WexSettings objectForKey:key];
}


+ (BOOL)boolForKey:(NSString *)key {
    
    if ([WexSettings objectForKey:key] == nil) {
        [WexSettings setBool:false forKey:key];
        [WexSettings synchronize];
        return false;
    }
    else {
        return [WexSettings boolForKey:key];
    }
}

+ (void)setBool:(BOOL)value forKey:(NSString *)key {
    [WexSettings setBool:value forKey:key];
    [WexSettings synchronize];
}

// 服务器时间
- (NSDate *)serverDate {
    return [NSDate dateWithTimeIntervalSince1970:self.serverTimeIntervar];
}

@end

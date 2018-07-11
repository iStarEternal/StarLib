//
//  WexSettingsConfig.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/7/25.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WexSettingsConfig : NSObject

+ (instancetype)shared;

+ (id)objectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

+ (BOOL)boolForKey:(NSString *)key;
+ (void)setBool:(BOOL)value forKey:(NSString *)key;

@property (nonatomic, assign) NSTimeInterval serverTimeIntervar;
@property (nonatomic, strong, readonly) NSDate *serverDate;

@end

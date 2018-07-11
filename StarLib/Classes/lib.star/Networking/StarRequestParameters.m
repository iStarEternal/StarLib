//
//  StarRequestParameters.m
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "StarRequestParameters.h"
#import "WexApplicationInfo.h"

@implementation StarRequestParameters

// 静态参数
- (NSDictionary *)staticParameters {
    
    NSMutableDictionary *staticParameters = [NSMutableDictionary dictionary];
    
//    NSString *deviceIdentifier = [WexApplicationInfo uniqueDeviceIdentifier];
//
//    // 默认参数
//    // 应用版本
//    [staticParameters setObject:[WexApplicationInfo appVersion] forKey:@"version"];
//    // 应用平台 1 iphone 2 android
//    [staticParameters setObject:@"1" forKey:@"platformType"];
//    // 应用类别 1 app
//    [staticParameters setObject:@"1" forKey:@"appType"];
//    // 设备唯一标识
//    [staticParameters setObject:deviceIdentifier forKey:@"deviceIdentify"];
//    // 客户端请求时间 客户端使用从1970-1-1 00:00:00到现在的毫秒数
//    [staticParameters setObject:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000.] forKey:@"reqTime"];
//    // 本地化信息 目前客户端填写zh_CN, 目前的处理方法是,无论客户端填写什么都转成zh_CN
//    [staticParameters setObject:@"zh_CN" forKey:@"locale"];
//    // app下载渠道id
//    [staticParameters setObject:@"20" forKey:@"channelId"];
//    // 当前设备IP地址
//    [staticParameters setObject:[WexApplicationInfo IPAddress] forKey:@"clientIp"];

    return [staticParameters copy];
}

- (NSDictionary *)requestParameters {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // 静态参数
    NSDictionary *staticParameters = [self staticParameters];
    [parameters addEntriesFromDictionary:staticParameters];
    
    // 动态参数
    if (self.parameters) {
        [parameters addEntriesFromDictionary:self.parameters];
    }
    
    return [parameters copy];
}


@end

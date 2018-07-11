//
//  StarRequestCache
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

// 统一的接口缓存
@interface StarRequestCache : NSObject

@property (nonatomic, assign) BOOL open; // 是否打开缓存

// 缓存数据
+ (BOOL)storeData:(NSDictionary *)data forKey:(NSString *)key;

// 获取缓存
+ (NSDictionary *)dataForKey:(NSString *)key;

@end

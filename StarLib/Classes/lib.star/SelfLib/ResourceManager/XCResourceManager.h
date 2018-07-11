//
//  XCResourceManager.h
//  WeXFin
//
//  Created by Mark on 15/7/16.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCResourceManager : NSObject

+ (XCResourceManager *)sharedManager;

// 运行资源管理器
- (void)run;

- (UIColor *)colorWithKey:(NSString *)colorKey;

- (UIFont *)fontWithKey:(NSString *)fontKey;

- (UIFont *)systemFontWithKey:(NSString *)fontKey;

- (UIImage *)imageWithKey:(NSString *)imageKey;

@end

//
//  WexApplicationInfo.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/26.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface WexApplicationInfo : NSObject



#pragma mark - APP信息

///
+ (NSString *)bundleName;

///
+ (NSString *)bundleDisplayName;

/// 得到APP版本号
+ (NSString *)appVersion;

/// 记录系统版本号
+ (void)saveUserAppVersion:(NSString*)newVersion;

/// 判断版本是否更新
+ (BOOL)isAppUpdate:(NSString *)newVersion;

/// 得到WeiboPay设备唯一标识
+ (NSString *)uniqueDeviceIdentifier;

/// 当前设备的型号
+ (NSString *)deviceModel;

/// 当前系统版本
+ (NSString *)systemVersion;

/// 当前系统版本 return -> float类型
+ (float)systemFloatVersion;

+ (NSString *)IPAddress;


#pragma mark - 

+ (UIWindow *)keyWindow;

+ (CGFloat)keyboardHeightFromKeyBoardType:(UIKeyboardType)keyboardType;


@end

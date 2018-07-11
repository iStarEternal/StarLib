//
//  WexApplicationInfo.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/26.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexApplicationInfo.h"
// #import "OpenUDID.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


#define Key_App_Version (@"version") // app版本

@implementation WexApplicationInfo


+ (NSString *)bundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

+ (NSString *)bundleDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

+ (UIImage *)launchImage {
    
    //    launch-320x480.png
    //    launch-640x960-1.png
    //    launch-640x960.png
    //    launch-640x1136-1.png
    //    launch-640x1136.png
    //    launch-750x1334.png
    //    launch-1242x2208.png
    
    NSDictionary *dic = @{@"320x480" : @"LaunchImage-700",
                          @"320x568" : @"LaunchImage-700-568h",
                          @"375x667" : @"LaunchImage-800-667h",
                          @"414x736" : @"LaunchImage-800-Portrait-736h"};
    NSString *key = [NSString stringWithFormat:@"%dx%d", (int)[UIScreen mainScreen].bounds.size.width, (int)[UIScreen mainScreen].bounds.size.height];
    UIImage *launchImage = [UIImage imageNamed:dic[key]];
    return launchImage;
}

// 得到APP版本号
+ (NSString *)appVersion {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return [version stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

// 记录系统版本号
+ (void)saveUserAppVersion:(NSString*)newVersion {
    
    NSString *localVersion = [[NSUserDefaults standardUserDefaults] stringForKey:Key_App_Version];
    
    if (newVersion && [newVersion isEqualToString:localVersion]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:newVersion forKey:Key_App_Version];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 判断版本是否更新
+ (BOOL)isAppUpdate:(NSString *)newVersion {
    
    NSString *localVersion = [[NSUserDefaults standardUserDefaults] stringForKey:Key_App_Version];
    
    if (newVersion && [newVersion isEqualToString:localVersion]) {
        return NO;
    }
    
    return YES;
}

// 得到WeiboPay设备唯一标识
+ (NSString *)uniqueDeviceIdentifier {
    return @"";//[OpenUDID value];
}

//
+ (NSString *)deviceModel  {
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (float)systemFloatVersion {
    return [[self systemVersion] floatValue];
}

+ (NSString *)IPAddress {
    
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"pdp_ip0"]
                    || [[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}


+ (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].delegate.window;
}

+ (CGFloat)keyboardHeightFromKeyBoardType:(UIKeyboardType)keyboardType {
    
    //    高度值其实就只有两种类型，一个是Default一个是Number
    //    ①以下几种键盘类型几乎一样，键盘高度也是一样的
    //    UIKeyboardTypeAlphabet
    //
    //    UIKeyboardTypeASCIICapable
    //    UIKeyboardTypeDefault
    //    UIKeyboardTypeEmailAddress
    //    UIKeyboardTypeNamePhonePad
    //    UIKeyboardTypeNumbersAndPunctuation（数字和标点符号）
    //    UIKeyboardTypeTwitter
    //    UIKeyboardTypeURL
    //    UIKeyboardTypeWebSearch
    //    5.5吋271
    //    4.7吋258
    //    4.0吋253
    //    ②以下几种键盘为数字类型的键盘，键盘高度也是一样的
    //    UIKeyboardTypeDecimalPad（带小数点的数字键盘）
    //    UIKeyboardTypeNumberPad（纯数字键盘）
    //    UIKeyboardTypePhonePad（带*+#,;的数字键盘）
    //    5.5吋226
    //    4.7吋216
    //    4.0吋216
    
    // http://blog.csdn.net/l2i2j2/article/details/51457736
    
    CGFloat height = 0;
    
    switch (keyboardType) {
            
        case UIKeyboardTypeDefault:
        case UIKeyboardTypeASCIICapable:
        case UIKeyboardTypeEmailAddress:
        case UIKeyboardTypeNamePhonePad:
        case UIKeyboardTypeNumbersAndPunctuation: //（数字和标点符号）
        case UIKeyboardTypeURL:
        case UIKeyboardTypeTwitter:
        case UIKeyboardTypeWebSearch:
            //        case UIKeyboardTypeASCIICapableNumberPad:
            
            if ([self isScreen4]) {
                height = 253;
            }
            else if ([self isScreen5]) {
                height = 253;
            }
            else if ([self isScreen6_7]) {
                height = 258;
            }
            else if ([self isScreen6p_7p]) {
                height = 271;
            }
            else {
                height = 253;
            }
            break;
            
        case UIKeyboardTypeDecimalPad://（带小数点的数字键盘）
        case UIKeyboardTypeNumberPad://（纯数字键盘）
        case UIKeyboardTypePhonePad://（带*+#,;的数字键盘）]
            
            if ([self isScreen4]) {
                height = 216;
            }
            else if ([self isScreen5]) {
                height = 216;
            }
            else if ([self isScreen6_7]) {
                height = 216;
            }
            else if ([self isScreen6p_7p]) {
                height = 226;
            }
            else {
                height = 216;
            }
            break;
            
        default:
            height = 216;
            break;
    }
    
    return height;
}


+ (CGSize)screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)isScreen4 {
    return CGSizeEqualToSize([self screenSize], CGSizeMake(320, 480));
}

+ (BOOL)isScreen5 {
    return CGSizeEqualToSize([self screenSize], CGSizeMake(320, 568));
}

+ (BOOL)isScreen6_7 {
    return CGSizeEqualToSize([self screenSize], CGSizeMake(375, 667));
}

+ (BOOL)isScreen6p_7p {
    return CGSizeEqualToSize([self screenSize], CGSizeMake(414, 736));
}

@end

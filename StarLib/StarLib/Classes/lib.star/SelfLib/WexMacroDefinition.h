//
//  WexMacroDefinition.h
//  Pods
//
//  Created by 星星 on 2017/6/12.
//
//

#ifndef WexMacroDefinition_h
#define WexMacroDefinition_h

#define StarWeakSelf __weak typeof(self) weakSelf = self;
#define StarFillWeak(obj) __weak typeof(obj) weak_##obj = obj;
#define StarDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#define degrees_to_radians(radius) ((radius) * (M_PI / 180.0))


#define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS6_OR_LATER   (iOSVersion >= 6.0)
#define IOS7_OR_LATER   (iOSVersion >= 7.0)
#define IOS8_OR_LATER   (iOSVersion >= 8.0)
#define IOS9_OR_LATER   (iOSVersion >= 9.0)
#define IOS10_OR_LATER  (iOSVersion >= 10.0)
#define IOS11_OR_LATER  (iOSVersion >= 10.0)

#define iOS6    (iOSVersion >= 6.0 && iOSVersion < 7.0)
#define iOS7    (iOSVersion >= 7.0 && iOSVersion < 8.0)
#define iOS8    (iOSVersion >= 8.0 && iOSVersion < 9.0)
#define iOS9    (iOSVersion >= 9.0 && iOSVersion < 10.0)
#define iOS10   (iOSVersion >= 10.0 && iOSVersion < 11.0)
#define iOS11   (iOSVersion >= 11.0 && iOSVersion < 12.0)

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define is_iPhoneX ([[UIScreen mainScreen] currentMode].size.width == 1125)
/// 刘海高度
#define XCiPhoneXBangHeight     (is_iPhoneX ? 44. : 20.) // ([UIApplication sharedApplication].statusBarFrame.size.height)
/// 下巴高度
#define XCiPhoneXJawHeight      (is_iPhoneX ? 34. : 0.)
#define StatusBarHeight         (is_iPhoneX ? 44. : 20.)

#define APP_ROOT_WINDOW ([UIApplication sharedApplication].delegate).window
#define APP_ROOT_VC     ([UIApplication sharedApplication].delegate).window.rootViewController


typedef void(^WexEmptyBlock)(void);


#endif /* WexMacroDefinition_h */

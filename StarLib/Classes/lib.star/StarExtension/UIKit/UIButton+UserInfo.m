//
//  UIButton+UserInfo.m
//  AFNetworking
//
//  Created by 星星 on 2018/7/11.
//

#import "UIButton+UserInfo.h"
#import <objc/runtime.h>

@implementation UIButton (UserInfo)

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, @selector(userInfo), userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, _cmd);
}

@end

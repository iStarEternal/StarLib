//
//  StarResponseResult.m
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "StarResponseResult.h"

@implementation StarResponseResult

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return true;
}

- (StarResponseStatus)status {
    
    // 成功
    if (self.code == 2000) {
        return StarResponseStatusSuccess;
    }
    // 其他都是失败
    return StarResponseStatusFailure;
    // return StarResponseStatusUnknown;
}

- (BOOL)success {
    return self.status == StarResponseStatusSuccess;
}

- (NSString *)errorMessage {
    // 服务器升级
    if (self.status == StarResponseStatusServerUpgrading) {
        return @"";
    }
    // Session过期
    else if (self.status == StarResponseStatusSessionTimeOut) {
        return @"";
    }
    
    return self.message;
}

- (NSError<Ignore> *)error {
    return [NSError errorWithCode:self.code msg:self.errorMessage];
}


@end


//
//  WexPickerModel.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexPickerModel.h"

@implementation WexPickerModel

- (instancetype)initWithKey:(NSString *)key value:(NSString *)value {
    self = [super init];
    if (self) {
        self.key = key;
        self.value = value;
    }
    return self;
}
+ (instancetype)pickerModelWithKey:(NSString *)key value:(NSString *)value {
    return [[self alloc] initWithKey:key value:value];
}

@end

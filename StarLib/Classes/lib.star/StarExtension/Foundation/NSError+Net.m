//
//  NSError+Net.m
//  Pythia
//
//  Created by 星星 on 2017/5/2.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "NSError+Net.h"

@implementation NSError (Net)

+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg {
    id err = [[self alloc] initWithDomain:kPythiaURLErrorDomain code:code userInfo:@{@"msg": msg ?: @""}];
    return err;
}

+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data {
    id err = [[self alloc] initWithDomain:kPythiaURLErrorDomain code:code userInfo:@{@"msg": msg ?: @"", @"data": data ?: @""}];
    return err;
}

- (NSString *)msg {
    return self.userInfo[@"msg"];
}

- (id)data {
    return self.userInfo[@"data"];
}

@end

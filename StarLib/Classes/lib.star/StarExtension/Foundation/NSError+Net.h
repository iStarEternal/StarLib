//
//  NSError+Net.h
//  Pythia
//
//  Created by 星星 on 2017/5/2.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *kPythiaURLErrorDomain = @"com.weicaifu.wcf";

static NSInteger kURLNormalErrorDode = -9;

@interface NSError (Net)

+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg;
+ (instancetype)errorWithCode:(NSInteger)code msg:(NSString *)msg data:(id)data;
@property (nonatomic, copy, readonly) NSString *msg;
@property (nonatomic, strong, readonly) id data;

@end

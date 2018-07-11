//
//  StarResponseResult.h
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#pragma mark - StarResponseResult
#pragma mark

typedef NS_ENUM(NSInteger, StarResponseStatus){
    StarResponseStatusUnknown,            // 未知
    StarResponseStatusSuccess,            // 成功
    StarResponseStatusFailure,            // 请求失败
    StarResponseStatusSessionTimeOut,     // Session过期
    StarResponseStatusServerUpgrading,    // 服务器升级
};

@interface StarResponseResult : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) NSTimeInterval serverTime;

@property (nonatomic, assign, readonly) StarResponseStatus status;
@property (nonatomic, assign, readonly) BOOL success;
@property (nonatomic, assign, readonly) NSString *errorMessage;


// 数据
@property (nonatomic, strong) id data;
@property (nonatomic, copy) NSArray         *data_array;
@property (nonatomic, copy) NSDictionary    *data_dictionary;
@property (nonatomic, copy) NSString        *data_string;
@property (nonatomic, strong) id            data_entity;

// 原始数据
@property (nonatomic, strong) id responseObject;

// 缓存
@property (nonatomic, assign) BOOL isCache;


#pragma mark -

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, strong, readonly) NSError *error;

@end



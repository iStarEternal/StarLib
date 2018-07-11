//
//  WexBaseNetAdapter.h
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"
#import "StarResponseResult.h"
#import "StarRequestManagerResponseHandler.h"
#import "StarRequestCache.h"
#import "StarDataEntity.h"
#import "NSError+Net.h"
#import "StarRequestParameters.h"

typedef NS_ENUM(NSUInteger, StarRequestManagerStatus) {
    StarRequestManagerStatusRun,    // 接口调用中
    StarRequestManagerStatusIdle,   // 接口空闲
};

typedef NS_ENUM(NSUInteger, StarRequestMethod) {
    StarRequestMethodGET,
    StarRequestMethodPOST,
    StarRequestMethodUPLOAD
};

typedef void (^StarErrorBlock)(NSString *error);

#pragma mark - 调用接口
typedef void (^StarRequestManagerComplete)(StarResponseResult *result);
typedef void (^StarRequestManagerFailure)(StarResponseResult *result);


@interface StarRequestManager : NSObject

+ (instancetype)adapter;

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

#pragma mark - 参数

/**
 *  请求的URL，默认使用info.plist中的URLString
 */
@property (nonatomic, strong) NSString *requestURLString;

/*
 *  请求的接口路径，名称。例如：/pwd/salt，默认值：@""空白字符串
 */
@property (nonatomic, copy) NSString *requestPath;

/**
 *  接口超时时间，默认值：60.0
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 *  参数，默认值：nil
 */
@property (nonatomic, strong) NSDictionary *parameters;

/**
 *  参数管理
 */
@property (nonatomic, strong) StarRequestParameters *parametersManager;


/**
 *  当前接口的状态
 */
@property (nonatomic, assign, readonly) StarRequestManagerStatus status;

/**
 *  响应对象处理器，默认值：WexRequestManagerResponseNormalHandler
 */
@property (nonatomic, strong) StarRequestManagerResponseHandler *responseHandler;

/**
 *  响应对象类，默认值：[NSDictionary class]
 */
@property (nonatomic, strong) Class responseClass;

/**
 *  缓存对象
 */
@property (nonatomic, strong) StarRequestCache *cacheObj;


@property (nonatomic, assign) BOOL isPrintLog;

/**
 *  请求
 *
 *  @param complete    请求完成
 *
 *  @return .
 */
- (NSURLSessionDataTask *)POST:(StarRequestManagerComplete)complete;
- (NSURLSessionDataTask *)GET:(StarRequestManagerComplete)complete;

/**
 *  取消当前队列的任务
 */
- (void)cancelAllOperations;


#pragma mark - Notification

// 请求开始
+ (void)postRequestStartNotification;
// 请求结束
+ (void)postRequestOverNotification;
// Session过期
+ (void)postSessionTimeoutNotification;
// 服务器升级
+ (void)postServerUpgradingNotificationWithMessage:(NSString *)message;
// 服务器正常
+ (void)postServerNormalNotification;



#pragma mark - 公用参数

// 请求URL
+ (NSString *)GPDefaultRequestURLString;


#pragma mark - Cookies相关（用于恢复登录状态）

/// 保存Cookies
+ (void)saveNetCookies;
/// 恢复Cookies
+ (void)restoreNetCookies;
/// 删除保存的Cookies
+ (void)deleteSavedNetCookies;


@end

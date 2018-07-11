//
//  WexBaseNetAdapter.m
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "StarRequestManager.h"
#import "AFHTTPSessionManager.h"
#import "WexSettingsConfig.h"
#import "StarRequestManagerResponseHandler.h"


#define GP_NET_COOKIES_ARRAY @"WEX_NET_COOKIES_ARRAY"

@interface StarRequestManager () {}

@end

@implementation StarRequestManager


#pragma mark -

- (instancetype)init {
    self = [super init];
    if (self) {
        _status = StarRequestManagerStatusIdle;
        
        _requestManager = [AFHTTPSessionManager manager];
        _requestPath = @"";
        _requestURLString = [StarRequestManager GPDefaultRequestURLString];
        _timeoutInterval = 60.0;
        _parametersManager = [[StarRequestParameters alloc] init];
        
        // 缓存对象
        _cacheObj = [[StarRequestCache alloc] init];
        _cacheObj.open = false;
        
        _responseHandler = [StarRequestManagerResponseHandler handler];
        self.responseClass = [NSDictionary class];
        
        _isPrintLog = true;
    }
    return self;
}

+ (instancetype)adapter {
    return [[self alloc] init];
}


#pragma mark - Getter & Setter

- (Class)responseClass {
    return self.responseHandler.responseClass;
}

- (void)setResponseClass:(Class)responseClass {
    self.responseHandler.responseClass = responseClass;
}

- (NSDictionary *)parameters {
    return self.parametersManager.parameters;
}

- (void)setParameters:(NSDictionary *)parameters {
    self.parametersManager.parameters = parameters;
}


// 获取参数




#pragma mark - POST

- (NSString *)key {
    NSMutableString *key = [NSMutableString string];
    [key appendString:self.requestPath];
    [key appendString:@"?"];
    if (self.parameters) {
        [key appendString:self.parameters.query];
    }
    return key.copy;
}

- (NSURLSessionDataTask *)POST:(StarRequestManagerComplete)complete {
    return [self requestWithMethod:StarRequestMethodPOST success:^(StarResponseResult *head) {
        if (complete) complete(head);
    } failure:^(StarResponseResult *head) {
        if (complete) complete(head);
    }];
}

- (NSURLSessionDataTask *)GET:(StarRequestManagerComplete)complete {
    return [self requestWithMethod:StarRequestMethodGET success:^(StarResponseResult *head) {
        if (complete) complete(head);
    } failure:^(StarResponseResult *head) {
        if (complete) complete(head);
    }];
}

- (NSURLSessionDataTask *)requestWithMethod:(StarRequestMethod)method success:(StarRequestManagerComplete)success failure:(StarRequestManagerFailure)failure {
    
    
    if (self.isPrintLog) {
        LogBackTrace(@"POST调用堆栈");
    }
    
    // 如果有缓存
    if (self.cacheObj.open) {
        @try {
            NSString *key = [self key];
            NSDictionary *cacheResponseObj = [StarRequestCache dataForKey:key];
            if (cacheResponseObj) {
                if (self.isPrintLog) {
                    LogDebug(@"\n获取缓存内容: %@", self.requestPath);
                }
                [self POSTSuccessFinish:nil response:cacheResponseObj success:success failure:failure];
            }
        }
        @catch (NSException *e){
        }
    }
    
    _status = StarRequestManagerStatusRun;
    
    [StarRequestManager postRequestStartNotification];
    
    NSString *URLString             = [self.requestURLString stringByAppendingPathComponent:self.requestPath];
    NSString *requestPath           = self.requestPath;
    NSDictionary *requestParameters = self.parametersManager.requestParameters;
    NSTimeInterval timeoutInterval  = self.timeoutInterval;
    
    if (self.isPrintLog) {
        LogWarning(@"请求者：[%@.m:0]", NSStringFromClass([self class]));
        LogWarning(@"反射类：[%@.m:0]", self.responseClass);
        LogWarning(@"URL: %@ ", URLString);
        LogWarning(@"\nrequestPath:%@ \nPOST Parameters: %@", requestPath, requestParameters);
    }
    
    self.requestManager.requestSerializer.timeoutInterval = timeoutInterval;
    
    if ([self.requestManager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]]) {
        ((AFJSONResponseSerializer *)self.requestManager.responseSerializer).removesKeysWithNullValues = true;
    }
    
    
    void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        @try {
            if (self.isPrintLog) {
                LogSuccess(@"\n请求成功\n地址: %@\nrequestPath: %@\nResponse: %@", URLString, requestPath, responseObject);
            }
            [StarRequestManager postRequestOverNotification];
            [self POSTSuccessFinish:task response:responseObject success:success failure:failure];
        }
        @catch (NSException *e){
            @try {
                if (self.isPrintLog) {
                    LogSuccess(@"\n请求成功了，但是Crash了：%@", e);
                }
                NSError *error = [NSError errorWithCode:0 msg:@"Crash"];
                [self POSTFailureFinish:task error:error failureBlock:failure];
            }
            @catch (NSException *e) {
                if (self.isPrintLog) {
                    LogSuccess(@"\n代码崩溃，返回代码也崩溃了：%@", e);
                }
            }
        }
    };
    
    void(^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @try {
            if (self.isPrintLog) {
                LogFailure(@"\n请求失败\n地址: %@\nrequestPath: %@\nError: %@", URLString, requestPath, error);
            }
            [StarRequestManager postRequestOverNotification];
            [self POSTFailureFinish:task error:error failureBlock:failure];
        }
        @catch (NSException *e){
            if (self.isPrintLog) {
                LogSuccess(@"\n请求失败，代码Crash：%@", e);
            }
        }
    };
    
    
    NSURLSessionDataTask *task = nil;
    switch (method) {
            
            // GET请求
        case StarRequestMethodGET: {
            task = [self.requestManager GET:URLString parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SuccessBlock(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                FailureBlock(task, error);
            }];
        }
            break;
            
        case StarRequestMethodUPLOAD: {
            // TODO: - 上传
        }
            break;
            
            // POST请求
        case StarRequestMethodPOST:
        default: {
            task = [self.requestManager POST:URLString parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                SuccessBlock(task, responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                FailureBlock(task, error);
            }];
        }
            break;
    }
    
    return task;
}


#pragma mark 处理返回结果

- (void)POSTSuccessFinish:(NSURLSessionDataTask *)task response:(id)responseObject success:(StarRequestManagerComplete)success failure:(StarRequestManagerFailure)failure {
    
    _status = StarRequestManagerStatusIdle;
    
    // 处理返回结果
    self.responseHandler.task = task;
    
    StarResponseResult *result = [self.responseHandler handleSuccessResponseObject:responseObject];
    result.isCache = (task == nil);
    
    // 服务器升级
    if (result.status == StarResponseStatusServerUpgrading) {
        if (self.isPrintLog) {
            LogError(@">>>>>>>>>>>>>>>> 服务器升级");
        }
        [StarRequestManager postServerUpgradingNotificationWithMessage:result.message];
    }
    else {
        [StarRequestManager postServerNormalNotification];
    }
    
    // 成功状态
    if (result.status == StarResponseStatusSuccess) {
        if (self.isPrintLog) {
            LogError(@">>>>>>>>>>>>>>>> 返回成功");
        }
        
        // 保存缓存
        if (self.cacheObj.open) {
            NSString *key = [self key];
            [StarRequestCache storeData:responseObject forKey:key];
            if (self.isPrintLog) {
                LogSuccess(@"接口缓存成功: %@", self.requestPath);
            }
        }
        if (success) {
            success(result);
        }
        return;
    }
    // Session过期
    else if (result.status == StarResponseStatusSessionTimeOut) {
        if (self.isPrintLog) {
            LogError(@">>>>>>>>>>>>>>>> Session过期");
        }
        // 通知Session过期
        [StarRequestManager postSessionTimeoutNotification];
    }
    // 失败状态
    else if(result.status == StarResponseStatusFailure) {
        if (self.isPrintLog) {
            LogError(@">>>>>>>>>>>>>>>> 返回失败");
        }
    }
    
    // 接口调用情况不明
    else {
        if (self.isPrintLog) {
            LogError(@">>>>>>>>>>>>>>>> 接口调用情况不明%ld", result.code);
        }
    }
    
    // 回调
    if (failure) {
        failure(result);
    }
}

- (void)POSTFailureFinish:(NSURLSessionDataTask *)operation error:(NSError *)error failureBlock:(StarRequestManagerFailure)failure {
    
    _status = StarRequestManagerStatusIdle;
    
    // 处理错误
    self.responseHandler.task = operation;
    StarResponseResult *errorResult = [self.responseHandler handleFailureError:error];
    // 回调
    if (failure) {
        failure(errorResult);
    }
}




#pragma mark - 操作

- (void)cancelAllOperations {
    [self.requestManager.operationQueue cancelAllOperations];
}





#pragma mark - 通知

// 请求开始
+ (void)postRequestStartNotification {
    
}
// 请求结束
+ (void)postRequestOverNotification {
    
}
// Session过期
+ (void)postSessionTimeoutNotification {
    
}
// 服务器升级
+ (void)postServerUpgradingNotificationWithMessage:(NSString *)message {
    //NSDictionary *info = @{@"message": message};
}
// 服务器正常
+ (void)postServerNormalNotification {
    
}




#pragma mark - URL

// 当前URL
+ (NSString *)GPDefaultRequestURLString {
    
    return @"";
    
    NSMutableString* url = nil;
#if GP_DEVELOP_SERVER == 1 //开发环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"GPServerBaseURLDevelopment"]];
#elif GP_TEST_SERVER == 1  // 测试环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"GPServerBaseURLTest"]];
#else // 生产环境
    url = [[NSMutableString alloc] initWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"GPServerBaseURLDistribute"]];
#endif
    
    return url;
}





#pragma mark - Cookies相关（用于恢复登录状态）

// 保存Cookies
+ (void)saveNetCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* cookies = cookieStorage.cookies;
    
    // 将cookie值转为Data数据保存
    NSMutableArray *dataCookieArray = [[NSMutableArray alloc] init];
    
    for (NSHTTPCookie *cookie in cookies) {
        NSDictionary *dic = [cookie properties];
        [dataCookieArray addObject:dic];
    }
    
    [userDefaults setObject:dataCookieArray forKey:GP_NET_COOKIES_ARRAY];
    
    [userDefaults synchronize];
}

// 恢复Cookies
+ (void)restoreNetCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray* cookies = [userDefaults objectForKey:GP_NET_COOKIES_ARRAY];
    
    if (cookies && [cookies count] > 0) {
        
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        
        for (NSDictionary *dict in cookies) {
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:dict];
            [cookieStorage setCookie:cookie];
        }
    }
}

// 删除保存的Cookies
+ (void)deleteSavedNetCookies {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:GP_NET_COOKIES_ARRAY];
    [userDefaults synchronize];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in cookieStorage.cookies) {
        [cookieStorage deleteCookie:cookie];
    }
    
}


@end



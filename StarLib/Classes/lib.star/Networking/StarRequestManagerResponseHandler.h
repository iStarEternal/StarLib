//
//  StarRequestManagerResponseHandler.h
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StarResponseResult.h"

@interface StarRequestManagerResponseHandler : NSObject

+ (instancetype)handler;

@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) Class responseClass;

- (id)handleSuccessResponseObject:(id)responseObject;

- (id)handleFailureError:(NSError *)error;

@end




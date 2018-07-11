//
//  StarRequestParameters.h
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarRequestParameters : NSObject

// 参数
@property (nonatomic, strong) NSDictionary *parameters;

// 请求参数
@property (nonatomic, strong, readonly) NSDictionary *requestParameters;

// 默认参数，子类重写
- (NSDictionary *)staticParameters;

@end

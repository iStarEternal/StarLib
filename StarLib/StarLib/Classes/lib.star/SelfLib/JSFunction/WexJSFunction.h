//
//  WexFunction.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/11/4.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WexJSFunction : NSObject

+ (NSString *)createFunctionWithBody:(NSString *)body argsName:(NSString *)argsName, ...;

+ (JSValue *)runFunction:(NSString *)function withArgs:(NSString *)args, ...;

@end

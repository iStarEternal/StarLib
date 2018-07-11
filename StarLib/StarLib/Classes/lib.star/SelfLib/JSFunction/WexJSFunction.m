//
//  WexFunction.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/11/4.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexJSFunction.h"

@implementation WexJSFunction

+ (NSString *)createFunctionWithBody:(NSString *)body argsName:(NSString *)argsName, ... {
    
    NSMutableArray *argsNameM = [NSMutableArray array];
    
    if (argsName) {
        
        [argsNameM addObject:argsName];
        
        va_list arglist;
        va_start(arglist, argsName);
        while (true) {
            NSString *str = va_arg(arglist, NSString *);
            if (str == nil) break;
            [argsNameM addObject:str];
        }
        va_end(arglist);
    }
    
    NSMutableString *functionStr = [argsNameM componentsJoinedByString:@","].mutableCopy;
    [functionStr insertString:@"function _func(" atIndex:0];
    [functionStr appendString:@") {"];
    [functionStr appendString:body];
    [functionStr appendString:@"}"];
    return functionStr.copy;
}

+ (JSValue *)runFunction:(NSString *)function withArgs:(NSString *)args, ... {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    if (args) {
        
        [arr addObject:args];
        va_list arglist;
        va_start(arglist, args);
        while (true) {
            NSString *str = va_arg(arglist, NSString *);
            if (str == nil) break;
            [arr addObject:str];
        }
        va_end(arglist);
    }
    
    NSMutableString *outStr = [arr componentsJoinedByString:@","].mutableCopy;
    [outStr insertString:@"_func(" atIndex:0];
    [outStr appendString:@");"];
    
    JSContext *ctx = [[JSContext alloc] init];
    return [ctx evaluateScript:[function stringByAppendingString:outStr.copy]];
}
@end

//
//  StarRequestManagerResponseHandler.m
//  StarLib
//
//  Created by 星星 on 2018/5/22.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "StarRequestManagerResponseHandler.h"

@interface StarRequestManagerResponseHandler ()

@end

@implementation StarRequestManagerResponseHandler

+ (instancetype)handler {
    return [[self alloc] init];
}

- (id)handleSuccessResponseObject:(id)responseObject {
    NSAssert(false, @"请在子类重写");
    return nil;
}

- (id)handleFailureError:(NSError *)error {
    NSAssert(false, @"请在子类重写");
    return nil;
}

@end

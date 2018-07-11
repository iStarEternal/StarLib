//
//  NSObject+NavigationServices.m
//  vodSeal
//
//  Created by 星星 on 2018/6/6.
//  Copyright © 2018年 yinuo. All rights reserved.
//

#import "NSObject+NavigationServices.h"

#import "StarNavigationControllerServicesImpl.h"


@interface StarNavigationServiceJ : NSObject
@property (nonatomic, strong) id<StarNavigationProtocol> navigationServices;
@end
@implementation StarNavigationServiceJ
+ (instancetype)shared {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationServices = [[StarNavigationControllerServicesImpl alloc] init];
    }
    return self;
}
@end


@implementation NSObject (NavigationServices)

- (id<StarNavigationProtocol>)navigationServices {
    return [StarNavigationServiceJ shared].navigationServices;
}

+ (id<StarNavigationProtocol>)navigationServices {
    return [StarNavigationServiceJ shared].navigationServices;
}

@end

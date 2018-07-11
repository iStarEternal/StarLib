//
//  NSObject+NavigationServices.h
//  vodSeal
//
//  Created by 星星 on 2018/6/6.
//  Copyright © 2018年 yinuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StarNavigationProtocol.h"

@interface NSObject (NavigationServices) {}

@property (nonatomic, weak, readonly) id<StarNavigationProtocol> navigationServices;
@property (class, nonatomic, weak, readonly) id<StarNavigationProtocol> navigationServices;

@end

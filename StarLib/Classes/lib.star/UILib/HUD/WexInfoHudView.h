//
//  WexInfoHudView.h
//  WeXFin
//
//  Created by Mark on 15/7/29.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexView.h"
#import "WexLabel.h"

// 浮层提示
@interface WexInfoHudView : WexView

+ (void)showTitle:(NSString *)title;

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration;

@end

//
//  StarApplication.m
//  WeXFin
//
//  Created by Star on 15/8/28.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "StarApplication.h"
#import "Logger.h"

@implementation StarApplication

- (void)sendEvent:(UIEvent *)event {
    //    @try {
    [super sendEvent:event];
    //    }
    //    @catch (NSException *e) {
    //        NSLog(@"异常：%@", e);
    //    }
    
#if DEBUG
    UIResponder *v = event.allTouches.anyObject.view;
    while (1 && event.allTouches.anyObject.phase == UITouchPhaseBegan) {
        if ([v isKindOfClass:[UIViewController class]]) {

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
            UIView *v1 = event.allTouches.anyObject.view;
            UIView *v2 = event.allTouches.anyObject.view.superview;
            UIView *v3 = event.allTouches.anyObject.view.superview.superview;
            UIView *v4 = event.allTouches.anyObject.view.superview.superview.superview;
#pragma clang diagnostic pop
            
            LogInfo(@"打印点击的View所在的UIViewController：[%@.m:0] - 点击的View[%@.m:0] <- [%@.m:0] <- [%@.m:0]",
                  NSStringFromClass(v.class),
                  NSStringFromClass(event.allTouches.anyObject.view.class),
                  NSStringFromClass(event.allTouches.anyObject.view.superview.class),
                  NSStringFromClass(event.allTouches.anyObject.view.superview.superview.class)
                  );
            break;
        }
        else if ([v isKindOfClass:[UIWindow class]]) {
            LogInfo(@"打印点击的View所在的UIWindow：[%@.m:0] - 点击的View[%@.m:0] <- [%@.m:0] <- [%@.m:0]",
                  NSStringFromClass(v.class),
                  NSStringFromClass(event.allTouches.anyObject.view.class),
                  NSStringFromClass(event.allTouches.anyObject.view.superview.class),
                  NSStringFromClass(event.allTouches.anyObject.view.superview.superview.class)
                  );
            break;
        }
        
        v = [v nextResponder];
        if (v == nil) {
            break;
        }
    }
#endif
    
    // 当用户有操作时，使得当前处于活跃状态
    if (event.allTouches.count > 0) {
        UITouchPhase phase = event.allTouches.anyObject.phase;
        if (phase == UITouchPhaseBegan) {
            // [[NSNotificationCenter defaultCenter] postNotificationName:WEX_APPLICATION_UI_TOUCH_PHASE_BEGIN_NOTIFY object:nil userInfo:nil];
        }
    }
}

- (BOOL)sendAction:(SEL)action to:(id)target from:(id)sender forEvent:(UIEvent *)event {
    //    @try {
    return [super sendAction:action to:target from:sender forEvent:event];
    //    }
    //    @catch (NSException *e) {
    //        NSLog(@"异常：%@", e);
    //        return false;
    //    }
}

@end

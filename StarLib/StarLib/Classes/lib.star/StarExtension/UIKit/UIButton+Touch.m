//
//  UIButton+Touch.m
//  AFNetworking
//
//  Created by 星星 on 2018/7/11.
//

#import "UIButton+Touch.h"
#import <objc/runtime.h>

@implementation UIButton (Touch)


- (void)setTouchUpInsideAction:(void (^)(UIButton *))touchUpInsideAction {
    objc_setAssociatedObject(self, @selector(touchUpInsideAction), touchUpInsideAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIButton *))touchUpInsideAction {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)addTouchUpInsideAction:(void (^)(UIButton *))action {
    self.touchUpInsideAction = action;
    [self addTarget:self action:@selector(wex_handleTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)wex_handleTouchUpInside:(UIButton *)sender {
    __weak UIButton *weakSender = sender;
    if (self.touchUpInsideAction) self.touchUpInsideAction(weakSender);
}

@end

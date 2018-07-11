//
//  UIButton+Touch.h
//  AFNetworking
//
//  Created by 星星 on 2018/7/11.
//

#import <UIKit/UIKit.h>

@interface UIButton (Touch)

@property (nonatomic, copy) void(^touchUpInsideAction)(UIButton *sender);
- (void)addTouchUpInsideAction:(void(^)(UIButton *sender))action;

@end

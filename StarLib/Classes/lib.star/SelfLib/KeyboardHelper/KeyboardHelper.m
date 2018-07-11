//
//  KeyboarderHelper.m
//  Star
//
//  Created by 星星 on 16/5/17.
//  Copyright © 2016年 Star. All rights reserved.
//

#import "KeyboardHelper.h"

@interface KeyboardHelper ()

@end

@implementation KeyboardHelper

- (instancetype)initWithDelegate:(id<KeyboardHelperDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (void)dealloc {
    [self removeKeyboardObserver];
}

- (void)addKeyboardObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeKeyboardObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleKeyboardFrameChanged:(NSNotification *)notification {
    
    NSNumber *durationValue = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSValue *beginFrameValue = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    NSValue *endFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    
    NSTimeInterval duration = durationValue.doubleValue;
    CGRect keybordBeginFrame = beginFrameValue.CGRectValue;
    CGRect keybordEndFrame = endFrameValue.CGRectValue;
    
    
    
    BOOL isKeyboardShow = keybordBeginFrame.origin.y > keybordEndFrame.origin.y;
    
    // 如果frame没改变，则看当前是显示还是隐藏
    if (CGRectEqualToRect(keybordBeginFrame , keybordEndFrame)) {
        isKeyboardShow = keybordEndFrame.origin.y < [UIScreen mainScreen].bounds.size.height;
    }
    
    // 如果size改变了，则看当前是显示还是隐藏
    if (!CGSizeEqualToSize(keybordBeginFrame.size, keybordEndFrame.size)) {
        isKeyboardShow = keybordEndFrame.origin.y < [UIScreen mainScreen].bounds.size.height;
    }
    
    
    if (isKeyboardShow) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardHelper:showWithFrame:duration:)]) {
            [self.delegate keyboardHelper:self showWithFrame:keybordEndFrame duration:duration];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(keyboardHelper:hideWithFrame:duration:)]) {
            [self.delegate keyboardHelper:self hideWithFrame:keybordEndFrame duration:duration];
        }
    }
}


@end

//
//  KeyboarderHelper.h
//  Star
//
//  Created by 星星 on 16/5/17.
//  Copyright © 2016年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>


@class KeyboardHelper;

@protocol KeyboardHelperDelegate <NSObject>

@optional
- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper showWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration;
- (void)keyboardHelper:(KeyboardHelper *)keyboardHelper hideWithFrame:(CGRect)keybordFrame duration:(NSTimeInterval)duration;

@end

@interface KeyboardHelper : NSObject

@property (nonatomic, weak) id<KeyboardHelperDelegate> delegate;

- (instancetype)initWithDelegate:(id<KeyboardHelperDelegate>)delegate;

- (void)addKeyboardObserver;
- (void)removeKeyboardObserver;

@end

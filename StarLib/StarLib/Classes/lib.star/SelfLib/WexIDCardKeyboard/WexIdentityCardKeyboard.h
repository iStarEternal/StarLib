//
//  WexIdentityCardKeyboard.h
//  WexWeiCaiFu
//
//  Created by nyezz on 16/1/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WexIdentityCardKeyboardDelegate <NSObject>

- (void)numberKeyboardInput:(NSString *)number;
- (void)numberKeyboardBackspace;

@optional
- (void)changeKeyboardType;

@end

/** 左下角带X的数字键盘 */
@interface WexIdentityCardKeyboard : UIView

@property (nonatomic,assign) id<WexIdentityCardKeyboardDelegate> delegate;

@end


// textField扩展
@interface UITextField (ExtentRange)
/** 获取选定范围 */
- (NSRange) selectedRange;

/** 设置选中范围 */
- (void) setSelectedRange:(NSRange) range;

/** 设置光标位置 */
- (void) insertSelectedRange:(NSRange) range;

@end
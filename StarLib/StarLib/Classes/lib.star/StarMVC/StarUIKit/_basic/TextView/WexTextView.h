//
//  WexTextView.h
//  WexWeiCaiFu
//
//  Created by nyezz on 15/11/26.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Helper

@interface WexTextViewHelper : NSObject

@end


#pragma mark - TextView
@interface WexTextView : UITextView

@property (nonatomic) NSInteger maxCount;

@property (nonatomic, strong) NSString *placeholder;  //灰色提示文字
@property (nonatomic, strong) UIColor *colorText;

@property (nonatomic, weak) id<UITextViewDelegate> wexTextViewDelegate;

+ (WexTextView*)wexTextView;
+ (WexTextView*)wexTextViewWithDelegate:(id)delegate;


// 是否达到输入的上限
- (BOOL)isReachMaxCountWithCharactersInRange:(NSRange)range replacementString:(NSString*)string;

@end

//
//  WexTextView.m
//  WexWeiCaiFu
//
//  Created by nyezz on 15/11/26.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import "WexTextView.h"

#pragma mark - WexTextViewHelper

@interface WexTextViewHelper() <UITextViewDelegate>

@property (nonatomic, weak) WexTextView *textView;

@end

@implementation WexTextViewHelper

- (instancetype)initWithTextView:(WexTextView*)textView
{
    self = [super init];
    
    if (self)
    {
        self.textView = textView;
        self.textView.delegate = self;
    }
    
    return self;
}

#pragma mark - UITextViewDelegate

//
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)])
    {
        return [pDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    
    // 判断是否达到输入上限
    WexTextView* wexTextView = (WexTextView*)textView;
    
    
    // 达到上限就禁止继续输入
    if ([wexTextView isReachMaxCountWithCharactersInRange:range replacementString:text])
    {
        return NO;
    }
    
    return YES;
}

// 下面函数都是转发UITextViewDelegate。。。
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [pDelegate textViewShouldBeginEditing:textView];
    }
    
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewShouldEndEditing:)])
    {
        return [pDelegate textViewShouldEndEditing:textView];
    }
    
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewDidBeginEditing:)])
    {
        [pDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewDidEndEditing:)])
    {
        [pDelegate textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewDidChange:)])
    {
        [pDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textViewDidChangeSelection:)])
    {
        [pDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)])
    {
       return [pDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange NS_AVAILABLE_IOS(7_0) {
    id<UITextViewDelegate> pDelegate = ((WexTextView*)textView).wexTextViewDelegate;
    
    if([pDelegate respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)])
    {
        return [pDelegate textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}

@end

#pragma mark - WexTextView

@interface WexTextView ()

@property (nonatomic, strong) WexTextViewHelper* helper;

@end

@implementation WexTextView

+ (WexTextView*)wexTextView
{
    WexTextView *textView = [[WexTextView alloc] init];
    
    [textView setBackgroundColor:[UIColor clearColor]];
//    [textView setTextColor:[UIColor lightGrayColor]];
    [textView addObserver];
    
    return textView;
}

+ (WexTextView*)wexTextViewWithDelegate:(id)delegate
{
    WexTextView *textView = [WexTextView wexTextView];
    
    textView.wexTextViewDelegate = delegate;
    [textView setBackgroundColor:[UIColor clearColor]];
    [textView addObserver];
    
    return textView;
}

// 是否达到输入的上限
- (BOOL)isReachMaxCountWithCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    if (_maxCount == 0)
    {
        return NO;
    }
    
    NSString* aString = [self.text stringByReplacingCharactersInRange:range withString:string];
    
    if (aString.length > _maxCount)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark 注册通知
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self];
}
#pragma mark 移除通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 开始编辑
- (void)textDidBeginEditing:(NSNotification *)notification {
    if ([super.text isEqualToString:_placeholder]) {
        super.text = @"";
//        [super setTextColor:[UIColor blackColor]];
        [super setTextColor:_colorText];
    }
}
#pragma mark 结束编辑
- (void)textDidEndEditing:(NSNotification *)notification {
    if (super.text.length == 0) {
        super.text = _placeholder;
        //如果文本框内是原本的提示文字，则显示灰色字体
        [super setTextColor:[UIColor lightGrayColor]];
    }
}
#pragma mark 重写setPlaceholder方法
- (void)setPlaceholder:(NSString *)aPlaceholder {
    _placeholder = aPlaceholder;
    [self textDidEndEditing:nil];
}
#pragma mark 重写getText方法
- (NSString *)text {
    NSString *text = [super text];
    if ([text isEqualToString:_placeholder]) {
        return @"";  
    }  
    return text;  
}
 
@end

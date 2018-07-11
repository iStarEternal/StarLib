//
//  WexInfoHudView.m
//  WeXFin
//
//  Created by Mark on 15/7/29.
//  Copyright (c) 2015年 SinaPay. All rights reserved.
//

#import "WexInfoHudView.h"
#import "StarExtension.h"

@interface WexInfoHudView ()

@property (nonatomic, strong) WexLabel *titleLabel;
@property (nonatomic, assign) CGFloat duration;

@end

@implementation WexInfoHudView


+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyBoardHide:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)handleKeyBoardShow:(NSNotification *)sender {
    NSValue *keyboard_rect_value = sender.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboard_rect = keyboard_rect_value.CGRectValue;
    [[NSUserDefaults standardUserDefaults] setDouble:keyboard_rect.size.height forKey:@"HUD.KEYBOARD.HEIGHT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)handleKeyBoardHide:(id)sender {
    [[NSUserDefaults standardUserDefaults] setDouble:0 forKey:@"HUD.KEYBOARD.HEIGHT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (void)showTitle:(NSString *)title {
    [self showTitle:title duration:2.0];
}

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration {
    [self showTitle:title duration:duration inView:[UIApplication sharedApplication].keyWindow];
}

+ (void)showTitle:(NSString *)title duration:(NSTimeInterval)duration inView:(UIView *)view {
    
    if ([NSString isNullOrEmpty:title]) {
        return;
    }
    if (!view) {
        return;
    }
    WexInfoHudView *hudView = [[WexInfoHudView alloc] init];
    hudView.duration = duration;
    [hudView showTitle:title inView:view];
}

- (void)showTitle:(NSString *)title inView:(UIView *)view {
    
    [view addSubview:self];
    
    // self
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];;
    
    // 设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    
    // _titleLabel
    self.titleLabel = [[WexLabel alloc] init];
    [self addSubview:_titleLabel];
    
    self.titleLabel.textColor = rgba(255,255,255,1);
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel.text = title;
    
    [self makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.width.lessThanOrEqualTo([UIScreen mainScreen].bounds.size.width - 60);
        make.height.greaterThanOrEqualTo(30);
        
        CGFloat height = [[NSUserDefaults standardUserDefaults] doubleForKey:@"HUD.KEYBOARD.HEIGHT"];
        if (height) {
            make.bottom.equalTo(-50 - height);
        }
        else {
            make.bottom.equalTo(-130);
        }
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(6, 12, 6, 12));
    }];
    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:self.duration];
}

- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^ {
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

@end

//
//  WexDatePickerView.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexDatePickerView.h"


@interface WexDatePickerView ()

@property (nonatomic, strong) WexControl* backgroundOverlayView;
@property (nonatomic, strong) WexView* backView;

@end


@implementation WexDatePickerView




#pragma mark - 页面构造

- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.dynamic = NO;
    self.blurRadius = 15;
    self.tintColor = [UIColor blackColor];
    
    self.backgroundOverlayView = [[WexControl alloc] init];
    [self addSubview:self.backgroundOverlayView];
    self.backgroundOverlayView.backgroundColor = @"system_alpha_color".xc_color;
    [self.backgroundOverlayView addTarget:self action:@selector(handleCancel:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.backView = [[WexView alloc] init];
    [self addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    self.wex_datePicker = [[UIDatePicker alloc] init];
    [self.backView addSubview:self.wex_datePicker];
    self.wex_datePicker.datePickerMode = UIDatePickerModeDate;
    [self.wex_datePicker addTarget:self action:@selector(handleDatePickerValueChanged:) forControlEvents:(UIControlEventValueChanged)];
    
    
    self.wex_saveButton = [[UIButton alloc] init];
    [self.backView addSubview:self.wex_saveButton];
    [self.wex_saveButton setTitle:@"保存".localizedString forState:UIControlStateNormal];
    self.wex_saveButton.backgroundColor = @"button_yellow_color".xc_color;
    [self.wex_saveButton addTarget:self action:@selector(handleDone:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)wex_layoutConstraints {
    [self.backgroundOverlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@176);
    }];
    
    [self.wex_datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView);
        make.left.equalTo(_backView);
        make.bottom.equalTo(self.wex_saveButton.mas_top);
        make.right.equalTo(_backView);
    }];
    [self.wex_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView);
        make.bottom.equalTo(_backView);
        make.right.equalTo(_backView);
        make.height.equalTo(@44);
    }];
}

#pragma mark - Handle

- (void)handleDatePickerValueChanged:(UIDatePicker *)sender {
//     sender.date;
}

- (void)handleCancel:(WexControl *)sender {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewDidCancel:)]) {
        [self.delegate datePickerViewDidCancel:self];
    }
}

- (void)handleDone:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerView:didSelectDoneWithDate:)]) {
        [self.delegate datePickerView:self didSelectDoneWithDate:self.wex_datePicker.date];
    }
    
    if (self.didSelectDone) {
        self.didSelectDone(self.wex_datePicker.date);
        [self dismiss];
    }
}



#pragma mark - Action

- (void)showInView:(UIView *)view {
    
    [view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.alpha = 0;
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end

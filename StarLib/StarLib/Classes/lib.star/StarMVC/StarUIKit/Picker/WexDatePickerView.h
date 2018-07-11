//
//  WexDatePickerView.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexPickerModel.h"

@class WexDatePickerView;


@protocol WexDatePickerViewDelegate <NSObject>
@optional
- (void)datePickerViewDidCancel:(WexDatePickerView *)pickerView;
- (void)datePickerView:(WexDatePickerView *)pickerView didSelectDoneWithDate:(NSDate *)date;
@end



@interface WexDatePickerView : WexBlurView

@property (nonatomic, weak) id<WexDatePickerViewDelegate> delegate;

@property (nonatomic, strong) UIButton *wex_saveButton;

// Default is UIDatePickerModeDate;
@property (nonatomic, strong) UIDatePicker *wex_datePicker;


@property (nonatomic, copy) void(^didSelectDone)(NSDate *date);

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end

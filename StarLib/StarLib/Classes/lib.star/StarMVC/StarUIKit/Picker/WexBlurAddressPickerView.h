//
//  WexBlurAddressPickerView.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "StarAddress.h"
#import <UIKit/UIKit.h>

@class WexBlurAddressPickerView;


@protocol WexBlurAddressPickerViewDelegate <NSObject>
@optional
- (void)wexBlurAddressPickerViewDidCancel:(WexBlurAddressPickerView *)pickerView;
- (void)wexBlurAddressPickerView:(WexBlurAddressPickerView *)pickerView didSelectDoneWithAddress:(StarAddress *)address;

@end



@interface WexBlurAddressPickerView : WexBlurView

@property (nonatomic, weak) id<WexBlurAddressPickerViewDelegate> delegate;

@property (nonatomic, strong) UIButton *wex_saveButton;

@property (nonatomic, strong) UIPickerView *wex_pickerView;

@property (nonatomic, strong) StarAddress *address;


- (instancetype)initWithAddress:(StarAddress *)address;

- (void)selectAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end

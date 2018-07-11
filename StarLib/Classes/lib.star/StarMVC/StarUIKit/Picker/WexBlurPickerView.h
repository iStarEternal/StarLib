//
//  WexBlurPickerView.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/30.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexPickerModel.h"

@class WexBlurPickerView;


@protocol WexBlurPickerViewDelegate <NSObject>
@optional
- (void)wexBlurPickerViewDidCancel:(WexBlurPickerView *)pickerView;
- (void)wexBlurPickerView:(WexBlurPickerView *)pickerView didSelectDoneWithIndex:(NSInteger)index;
@end



@interface WexBlurPickerView : WexBlurView

@property (nonatomic, weak) id<WexBlurPickerViewDelegate> delegate;

@property (nonatomic, strong) UIButton *wex_saveButton;

@property (nonatomic, strong) UIPickerView *wex_pickerView;

@property (nonatomic, strong) NSArray<WexPickerModel *> *pickerModels;

@property (nonatomic, assign) NSInteger selectIndex;


- (instancetype)initWithPickerModels:(NSArray<WexPickerModel *> *)pickerModels;

- (void)setSelectIndex:(NSInteger)selectIndex animated:(BOOL)animated;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end

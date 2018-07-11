//
//  WexBlurAddressPickerView.m
//  WexWeiCaiFu
//
//  Created by 星星 on 16/3/31.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexBlurAddressPickerView.h"

@interface WexBlurAddressPickerView () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) WexControl *backgroundOverlayView;
@property (nonatomic, strong) WexView *backView;

@property (nonatomic, assign) NSInteger provinceIndex;
@property (nonatomic, assign) NSInteger cityIndex;
@property (nonatomic, assign) NSInteger areaIndex;


@property (nonatomic, assign) NSInteger priviousProvinceIndex;
@property (nonatomic, assign) NSInteger priviousCityIndex;
@property (nonatomic, assign) NSInteger priviousAreaIndex;
@end

@implementation WexBlurAddressPickerView


#pragma mark - 构造函数

- (instancetype)initWithAddress:(StarAddress *)address {
    self = [self init];
    if (self) {
        self.address = address;
    }
    return self;
}



#pragma mark - 页面构造

- (void)wex_loadViews {
    [super wex_loadViews];
    
    self.dynamic = NO;
    self.blurRadius = 15;
    self.tintColor = [UIColor blackColor];
    
    self.backgroundOverlayView = [[WexControl alloc] init];
    [self addSubview:self.backgroundOverlayView];
    self.backgroundOverlayView.backgroundColor = @"system_alpha_color".xc_color;
    [self.backgroundOverlayView addTarget:self action:@selector(handleTouchCancel:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    self.backView = [[WexView alloc] init];
    [self addSubview:self.backView];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    
    self.wex_pickerView = [[UIPickerView alloc] init];
    [self.backView addSubview:self.wex_pickerView];
    self.wex_pickerView.delegate = self;
    self.wex_pickerView.dataSource = self;
    
    
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
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@176);
    }];
    
    [self.wex_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView);
        make.left.equalTo(self.backView);
        make.bottom.equalTo(self.wex_saveButton.mas_top);
        make.right.equalTo(self.backView);
    }];
    [self.wex_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView);
        make.bottom.equalTo(self.backView);
        make.right.equalTo(self.backView);
        make.height.equalTo(@44);
    }];
}



#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    @try {
        // 省份
        if (component == 0) {
            return self.address.provinces.count;
        }
        // 城市
        else if (component == 1) {
            
            if (self.provinceIndex > self.address.provinces.count - 1) {
                self.provinceIndex = 0;
            }
            return self.address.provinces[self.provinceIndex].citys.count;
        }
        // 区
        else if (component == 2) {
            
            if (self.cityIndex > self.address.provinces[self.provinceIndex].citys.count - 1) {
                self.cityIndex = 0;
            }
            return self.address.provinces[self.provinceIndex].citys[self.cityIndex].areas.count;
        }
        else {
            return 0;
        }
    }
    @catch (NSException *exception) {
        LogError(@"%@", exception);
        return 0;
    }
    @finally {
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    @try {
        // TODO: 还有BUG没有处理完
        // 省份
        if (component == 0) {
            return self.address.provinces[row].name;
        }
        // 城市
        else if (component == 1) {
            return self.address.provinces[self.provinceIndex].citys[row].name;
        }
        // 区
        else if (component == 2) {
            return self.address.provinces[self.provinceIndex].citys[self.cityIndex].areas[row].name;
        }
        else {
            return @"出错".localizedString;
        }
    }
    @catch (NSException *exception) {
        LogError(@"%@", exception);
        return @"出错".localizedString;
    }
    @finally {
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    // 省份
    if (component == 0) {
        if (self.provinceIndex != row) {
            self.provinceIndex = row;
            self.cityIndex = 0;
            self.areaIndex = 0;
            [self.wex_pickerView reloadAllComponents];
            [self.wex_pickerView selectRow:0 inComponent:1 animated:true];
            [self.wex_pickerView selectRow:0 inComponent:2 animated:true];
        }
    }
    // 城市
    else if (component == 1) {
        if (self.cityIndex != row) {
            self.cityIndex = row;
            self.areaIndex = 0;
            [self.wex_pickerView reloadAllComponents];
            [self.wex_pickerView selectRow:0 inComponent:2 animated:true];
        }
    }
    // 区
    else if (component == 2) {
        self.areaIndex = row;
        [self.wex_pickerView reloadAllComponents];
    }
    [self.address setCurrentAddressWithProvinceIndex:self.provinceIndex cityIndex:self.cityIndex areaIndex:self.areaIndex];
}



#pragma mark - Handle

- (void)handleTouchCancel:(WexControl *)sender {
    
    self.provinceIndex = self.priviousProvinceIndex;
    self.cityIndex = self.priviousCityIndex;
    self.areaIndex = self.priviousAreaIndex;
    [self.address setCurrentAddressWithProvinceIndex:self.provinceIndex cityIndex:self.cityIndex areaIndex:self.areaIndex];
    
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexBlurAddressPickerViewDidCancel:)]) {
        [self.delegate wexBlurAddressPickerViewDidCancel:self];
    }
}

- (void)handleDone:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wexBlurAddressPickerView:didSelectDoneWithAddress:)]) {
        [self.delegate wexBlurAddressPickerView:self didSelectDoneWithAddress:self.address];
    }
}

- (void)selectAddressWithProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex areaIndex:(NSInteger)areaIndex {
    
    self.provinceIndex = provinceIndex;
    self.cityIndex = cityIndex;
    self.areaIndex = areaIndex;
    self.priviousProvinceIndex = provinceIndex;
    self.priviousCityIndex = cityIndex;
    self.priviousAreaIndex = areaIndex;
    // 很奇怪 以前没有这个问题。必须延迟以后再能选择第二个
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.wex_pickerView selectRow:provinceIndex inComponent:0 animated:true];
        [self.wex_pickerView selectRow:cityIndex inComponent:1 animated:true];
        [self.wex_pickerView selectRow:areaIndex inComponent:2 animated:true];
    });
    
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

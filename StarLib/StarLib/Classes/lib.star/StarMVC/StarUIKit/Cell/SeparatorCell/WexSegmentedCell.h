//
//  WexSegmentedCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/5/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"
#import "HMSegmentedControl.h"



@interface WexSegmentedCell : WexTableViewCell

@property (nonatomic, strong) NSArray *wex_sectionTitles;

@property (nonatomic, weak) HMSegmentedControl *wex_segmentedControl;

@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;


@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIFont *selectedFont;
@property (nonatomic, strong) UIFont *normalFont;

@property (nonatomic, strong) UIColor *selectionIndicatorColor;


@end

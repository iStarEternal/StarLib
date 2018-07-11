//
//  PythiaPlainCell.h
//  Pythia
//
//  Created by 星星 on 16/11/22.
//  Copyright © 2016年 weicaifu. All rights reserved.
//

#import "WexTableViewCell.h"

//
@interface PythiaPlainCell : WexTableViewCell

@property (nonatomic, strong) UIView                *leftView;          // 左侧View，可被设置成任意View
@property (nonatomic, weak, readonly) WexImageView  *leftImageView;     // 左侧图片，如果设置有rightView则不显示

@property (nonatomic, weak, readonly) WexLabel      *titleLabel;        // 标题，默认15px，rgba(35,37,45,1)
@property (nonatomic, weak, readonly) WexLabel      *contentLabel;      // 内容，默认15px，rgba(165,165,165,1)

@property (nonatomic, strong) UIView                *rightView;         // 右侧View，可被设置成任意View
@property (nonatomic, weak, readonly) WexImageView  *rightImageView;    // 右侧图片，如果设置有rightView则不显示

@property (nonatomic, assign) CGFloat                wex_rightSpace;    // 右侧间距，默认8，适配图片大小的时候才需要修改

@property (nonatomic, assign) CGFloat                wex_cellHeight;    // 行高，默认大于等于44，不推荐修改

@property (nonatomic, strong) id info;

@end

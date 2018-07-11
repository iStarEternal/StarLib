//
//  WexImageCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/11.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"


typedef NS_ENUM(NSUInteger, WexImageCellAlignment) {
    WexImageCellAlignmentLeft,  // 居左
    WexImageCellAlignmentCenter,// 居中
    WexImageCellAlignmentRight, // 居右
    WexImageCellAlignmentFill,  // 充满 默认
    WexImageCellAlignmentExtend // 拉伸
};

@interface WexImageCell : WexTableViewCell

@property (nonatomic, weak) UIImageView *wex_imageView;
@property (nonatomic, strong) UIImage *wex_image;
@property (nonatomic, assign) WexImageCellAlignment alignment; // default is WexImageCellAlignmentFill
@property (nonatomic, assign) UIEdgeInsets wex_imageEdgeInsets;

@end

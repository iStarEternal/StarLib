//
//  PythiaMultiLineCell.h
//  Pythia
//
//  Created by 星星 on 2017/5/26.
//  Copyright © 2017年 weicaifu. All rights reserved.
//

#import "WexTableViewCell.h"

@interface PythiaMultiLineCell : WexTableViewCell

@property (nonatomic, weak, readonly) WexLabel      *titleLabel;        // 标题，默认15px，rgba(35,37,45,1)
@property (nonatomic, weak, readonly) WexLabel      *contentLabel;      // 内容，默认15px，rgba(165,165,165,1)


@end

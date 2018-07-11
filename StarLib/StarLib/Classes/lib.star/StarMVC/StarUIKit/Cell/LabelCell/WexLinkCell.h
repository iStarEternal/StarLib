//
//  WexLinkCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/14.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"
#import "YYText.h"


@class WexLinkCell;

@protocol WexLinkCellDelegate <NSObject>

@optional
- (void)linkCell:(WexLinkCell *)linkCell didSelectLinkWithFlag:(NSString *)linkFlag;

@end



@interface WexLinkCell : WexTableViewCell

/**
 *  最小行高 default is 44
 */
@property (nonatomic, assign) CGFloat wex_minimumCellHeight;

/**
 *  default is 8
 */
@property (nonatomic, assign) CGFloat wex_topPadding;
/**
 *  defalt is 8
 */
@property (nonatomic, assign) CGFloat wex_bottomPadding;
/**
 *  defalt is 15
 */
@property (nonatomic, assign) CGFloat wex_leftPadding;
/**
 *  default is 15
 */
@property (nonatomic, assign) CGFloat wex_rightPadding;


@property (nonatomic, weak) id<WexLinkCellDelegate> delegate;

@property (nonatomic, weak) YYLabel *richLabel;
@property (nonatomic, weak) UILabel *autoLayoutLabel;
@property (nonatomic, strong) NSMutableArray *attrStringArray;

- (void)appendNormalText:(NSString *)text;

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag;

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font;

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag;

- (void)removeRichString;
@end


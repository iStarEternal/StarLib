//
//  PythiaProtocolCell.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/4/13.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

//#import "WexBaseCheckButtonCell.h"
#import "YYText.h"
#import "PythiaLinkString.h"
#import "WexTableViewCell.h"
#import "WexCheckButton.h"

@class PythiaProtocolCell;


@protocol PythiaProtocolCellDelegate <NSObject>

@optional
- (void)wex_protocolCell:(PythiaProtocolCell *)protocolCell didSelectCheckButtonWithChecked:(BOOL)checked;
- (void)wex_protocolCell:(PythiaProtocolCell *)protocolCell didSelectLink:(NSString *)link flag:(NSString *)flag;

@end



@interface PythiaProtocolCell : WexTableViewCell

@property (nonatomic, weak) id<PythiaProtocolCellDelegate> delegate;
@property (nonatomic, weak) WexCheckButton *wex_checkButton;

@property (nonatomic, weak) YYLabel *richLabel;
@property (nonatomic, weak) WexLabel *autoLayoutLabel;
@property (nonatomic, strong) NSMutableArray *attrStringArray;

- (void)appendNormalText:(NSString *)text;

- (void)appendLinkText:(NSString *)text linkFlag:(NSString *)linkFlag;

- (void)appendRichStringWithText:(NSString *)text textColor:(UIColor *)textColor textFont:(UIFont *)font isLink:(BOOL)isLink linkFlag:(NSString *)linkFlag;

- (void)clean;
@end

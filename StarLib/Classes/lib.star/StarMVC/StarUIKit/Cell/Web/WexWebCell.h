//
//  WexWebCell
//  WexWeiCaiFu
//
//  Created by shaohuali on 15/11/25.
//  Copyright © 2015年 SinaPay. All rights reserved.
//

#import "WexTableViewCell.h"

@class WexWebCell;

@protocol WexWebCellDelegate <NSObject>

@optional
- (void)wexWebCell:(WexWebCell *)webCell didFinishLoad:(UIWebView *)webView;

- (void)wexWebCell:(WexWebCell *)webCell didReceivedJSCallBack:(NSString *)URLString;

@end

@interface WexWebCell : WexTableViewCell <UIWebViewDelegate>

@property (nonatomic, weak) id<WexWebCellDelegate> delegate;

@property (nonatomic, strong) NSString *URLString;

@property (nonatomic, copy) void(^didFinishLoad)();

@end

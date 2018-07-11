//
//  WexNewTableViewController.h
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewViewController.h"
#import "XCRefreshHelper.h"

@interface WexNewTableViewController : WexNewViewController <WexRefreshDelegate, UITableViewDataSource, WexTableViewDelegate>

@property (nonatomic, strong, readonly) WexTableView *tableView;

@property (nonatomic, assign) BOOL clearsSelectionOnViewWillAppear;

/// 预先设定当前TableView的Style
- (UITableViewStyle)wex_tableViewStyle;

/// 请重写这个方法，并在里面创建页面静态的Cell
- (void)wex_loadStaticTableViewCell;


#pragma mark - 页面刷新

/// 下拉刷新 & 上拉刷新
@property (nonatomic, strong, readonly) XCRefreshHelper *refresh;


@end

//
//  WexNewReuseTableViewController.h
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewTableViewController.h"

@protocol WexNewReuseTableViewProtocol <NSObject>



// MARK: - HeadrFooter

/// 通过ID获取HeaderFooter高度
- (CGFloat)wex_tableView:(UITableView *)tableView heightForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section;

/// 通过ID获取HeaderFooterView
- (UIView *)wex_tableView:(UITableView *)tableView viewForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section;

/// 配置HeaderFooterView
- (void)wex_tableView:(UITableView *)tableView configureHeaderFooterView:(__kindof UITableViewHeaderFooterView *)headerFooterView inSection:(NSInteger)section;




// MARK: - TableViewCell

/// 注册TableViewCell
- (void)wex_registerTableViewCell:(UITableView *)tableView;

/// 通过静态Cell获取高度
- (CGFloat)wex_tableView:(UITableView *)tableView heightForCellWithStaticCell:(UITableViewCell *)staticCell;

/// 通过ID获取Cell高度
- (CGFloat)wex_tableView:(UITableView *)tableView heightForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

/// 通过ID获取Cell
- (UITableViewCell *)wex_tableView:(UITableView *)tableview cellForRowWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath;

/// 配置TableViewCell
- (void)wex_tableView:(UITableView *)tableView configureTableViewCell:(__kindof UITableViewCell *)currentCell indexPath:(NSIndexPath *)indexPath;


@end

@interface WexNewReuseTableViewController : WexNewTableViewController <WexNewReuseTableViewProtocol>

@end

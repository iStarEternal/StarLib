//
//  WexNewReuseTableViewController.m
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewReuseTableViewController.h"

@interface WexNewReuseTableViewController ()

@end

@implementation WexNewReuseTableViewController


- (void)wex_loadViews {
    [super wex_loadViews];
    [self wex_registerTableViewCell:self.tableView];
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableViewDelegate

- (void)wex_registerTableViewCell:(UITableView *)tableView {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert(false, @"子类必须重写该方法");
    return nil;
}







#pragma mark - 头部

- (CGFloat)wex_tableView:(UITableView *)tableView heightForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section {
    return [tableView fd_heightForHeaderFooterViewWithIdentifier:identifier configuration:^(id headerFooterView) {
        [self wex_tableView:tableView configureHeaderFooterView:headerFooterView inSection:section];
    }];
}

- (UIView *)wex_tableView:(UITableView *)tableView viewForHeaderFooterWithIdentifier:(NSString *)identifier inSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    [self wex_tableView:tableView configureHeaderFooterView:headerFooterView inSection:section];
    return headerFooterView;
}

- (void)wex_tableView:(UITableView *)tableView configureHeaderFooterView:(__kindof UITableViewHeaderFooterView *)headerFooterView inSection:(NSInteger)section {
    
    
}


#pragma mark - 操作

- (CGFloat)wex_tableView:(UITableView *)tableView heightForCellWithStaticCell:(UITableViewCell *)staticCell {
    return [tableView fd_heightForCellWithStaticCell:staticCell configuration:NULL];
}

- (CGFloat)wex_tableView:(UITableView *)tableView heightForCellWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:identifier configuration:^(id cell) {
        [self wex_tableView:tableView configureTableViewCell:cell indexPath:indexPath];
    }];
}

- (UITableViewCell *)wex_tableView:(UITableView *)tableview cellForRowWithIdentifier:(NSString *)identifier indexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    [self wex_tableView:tableview configureTableViewCell:cell indexPath:indexPath];
    return cell;
}

- (void)wex_tableView:(UITableView *)tableView configureTableViewCell:(__kindof UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
}



@end

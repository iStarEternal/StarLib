//
//  WexNewStaticTableViewController.h
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewTableViewController.h"

@interface WexNewStaticTableViewController : WexNewTableViewController


/**
 请重写此方法加载Cell
 */
- (void)loadAllCells;


#pragma mark - Cell 操作

- (void)appendCell:(UITableViewCell *)cell toSection:(NSInteger)section;
- (void)insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath*)indexPath;
- (void)replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section;
- (void)removeCell:(UITableViewCell *)cell atSection:(NSInteger)section;
- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath;
- (void)removeAllCells;
- (void)synchronizeAllCells;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSMutableArray *)rowsForSection:(NSInteger)section;
- (UITableViewCell *)lastCellForSection:(NSInteger)section;

- (void)reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation;

- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell;


#pragma mark - 动态操作
// 标记动态行起始位置
- (void)markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section ;
// 获取动态行起始位置
- (NSInteger)indexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section;


#pragma mark - 常规

#pragma mark Section Line

- (void)appendCellSeparatorLineToSection:(NSInteger)section;
- (void)appendSeparatorToSection:(NSInteger)section;
- (void)appendCellSeparatorLineWithEdgeInsets:(UIEdgeInsets)edgeInsets
                                    lineColor:(UIColor *)color
                                   lineHeight:(CGFloat)height
                              backgroundColor:(UIColor *)bgColor
                                    toSection:(NSInteger)section;


- (void)appendSectionSeparatorLineToSection:(NSInteger)section;


#pragma mark Section Layer

- (void)appendSectionSeparatorLayerToSection:(NSInteger)section;
- (void)appendSectionSeparatorLayerWithHeight:(CGFloat)height toSection:(NSInteger)section;
- (void)appendSectionSeparatorLayerWithHeight:(CGFloat)height color:(UIColor *)color toSection:(NSInteger)section;

@end

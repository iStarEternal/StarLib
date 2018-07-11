//
//  WexNewStaticTableViewController.m
//  Weicaifu
//
//  Created by 星星 on 2017/7/18.
//  Copyright © 2017年 星星. All rights reserved.
//

#import "WexNewStaticTableViewController.h"

#import "PythiaSeparatorLineCell.h"
#import "PythiaSeparatorLayerCell.h"

#import <objc/runtime.h>

@interface WexNewStaticTableViewController ()


@property (nonatomic, strong) NSMutableDictionary *dataSource;

@end

@implementation WexNewStaticTableViewController


#pragma mark - 数据源

- (NSMutableDictionary *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableDictionary dictionary];
    }
    return _dataSource;
}



#pragma mark - TableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    return [rows count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    
    NSInteger cellHeight = [tableView fd_heightForCellWithStaticCell:cell configuration:NULL];
    NSAssert(cellHeight, @"Cell height should not be 0.");
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    UITableViewCell *cell = rows[indexPath.row];
    NSAssert(cell, @"Cell should not be nil.");
    return cell;
}




#pragma mark - Cell 操作

- (void)loadAllCells {
    NSAssert(false, @"请在子类实现该方法");
}

- (void)insertCell:(UITableViewCell *)cell toIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:indexPath.section]];
    }
    [rows removeObject:cell];
    [rows insertObject:cell atIndex:indexPath.row];
}

- (void)appendCell:(UITableViewCell *)cell toSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:[NSNumber numberWithInteger:section]];
    }
    if ([rows containsObject:cell]) {
        return;
    }
    [rows addObject:cell];
}

- (void)replaceCell:(UITableViewCell *)target withCell:(UITableViewCell *)replacement atSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:@(section)];
    if (rows == nil) {
        rows = [NSMutableArray array];
        [self.dataSource setObject:rows forKey:@(section)];
    }
    
    NSUInteger index = [rows indexOfObject:target];
    if (index == NSNotFound) {
        return;
    }
    
    [rows replaceObjectAtIndex:index withObject:replacement];
    
}

- (void)removeCell:(UITableViewCell *)cell atSection:(NSInteger)section {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows) {
        [rows removeObject:cell];
    }
}

- (void)removeCellAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    if (rows) {
        [rows removeObjectAtIndex:indexPath.row];
    }
}

- (void)removeAllCells {
    
    if (self.dataSource) {
        [self.dataSource removeAllObjects];
    }
}

- (void)synchronizeAllCells {
    [self.tableView reloadData];
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray* rows = self.dataSource[@(indexPath.section)];
    
    if (rows) {
        if (indexPath.row < [rows count]) {
            return [rows objectAtIndex:indexPath.row];
        }
    }
    return nil;
}

- (NSMutableArray *)rowsForSection:(NSInteger)section {
    return self.dataSource[@(section)];
}

- (UITableViewCell *)lastCellForSection:(NSInteger)section {
    return [self rowsForSection:section].lastObject;
}


- (void)reloadCell:(UITableViewCell *)cell withRowAnimation:(UITableViewRowAnimation)animation {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath) {
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    }
}

- (NSIndexPath *)indexPathForCell:(UITableViewCell *)cell {
    if (!cell) {
        return nil;
    }
    for (int i = 0; i < self.dataSource.count; i++) {
        NSMutableArray* rows = self.dataSource[@(i)];
        for (int j = 0; j < rows.count; j++) {
            if (rows[j] == cell) {
                return [NSIndexPath indexPathForRow:j inSection:i];
            }
        }
    }
    return nil;
}


#pragma mark - 添加常用Separator
#pragma mark Cell Line

- (void)appendCellSeparatorLineToSection:(NSInteger)section {
    PythiaSeparatorLineCell *line = [[PythiaSeparatorLineCell alloc] init];
    line.wex_separatorEdgeInset = UIEdgeInsetsMake(0, 15, 0, 0);
    [self appendCell:line toSection:section];
}

- (void)appendCellSeparatorLineWithEdgeInsets:(UIEdgeInsets)edgeInsets
                                    lineColor:(UIColor *)color
                                   lineHeight:(CGFloat)height
                              backgroundColor:(UIColor *)bgColor
                                    toSection:(NSInteger)section {
    
    if (!color) {
        color = [UIColor clearColor];
    }
    
    PythiaSeparatorLineCell *line = [[PythiaSeparatorLineCell alloc] init];
    line.wex_separatorHidden = false;
    line.wex_separatorHeight = height;
    line.wex_separatorEdgeInset = UIEdgeInsetsMake(edgeInsets.top + height, edgeInsets.left, edgeInsets.bottom, edgeInsets.right);
    line.wex_separatorColor = color;
    line.wex_backgroundColor = bgColor;
    
    [self appendCell:line toSection:section];
}


#pragma mark Section Line

- (void)appendSeparatorToSection:(NSInteger)section {
    PythiaSeparatorLineCell *line = [[PythiaSeparatorLineCell alloc] init];
    line.wex_separatorEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self appendCell:line toSection:section];
}

- (void)appendSectionSeparatorLineToSection:(NSInteger)section {
    
    PythiaSeparatorLineCell *line = [[PythiaSeparatorLineCell alloc] init];
    line.wex_separatorHidden = false;
    line.wex_separatorHeight = 0.5;
    line.wex_separatorEdgeInset = UIEdgeInsetsMake(0.5, 0, 0, 0);
    line.wex_separatorColor = @"#F4F4F4".xc_color;
    line.wex_backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *rows = [self.dataSource objectForKey:[NSNumber numberWithInteger:section]];
    if (rows == nil || !rows.lastObject) {
        line.wex_backgroundColor = self.tableView.backgroundColor;
    }
    else {
        UITableViewCell *cell = rows.lastObject;
        line.wex_backgroundColor = cell.contentView.backgroundColor;
    }
    [self appendCell:line toSection:section];
}



#pragma mark Section Layer

- (void)appendSectionSeparatorLayerToSection:(NSInteger)section {
    [self appendSectionSeparatorLayerWithHeight:15 toSection:section];
}

- (void)appendSectionSeparatorLayerWithHeight:(CGFloat)height toSection:(NSInteger)section {
    [self appendSectionSeparatorLayerWithHeight:height color:self.tableView.backgroundColor toSection:section];
}

- (void)appendSectionSeparatorLayerWithHeight:(CGFloat)height color:(UIColor *)color toSection:(NSInteger)section {
    PythiaSeparatorLayerCell *separator = [[PythiaSeparatorLayerCell alloc] initWithCellHeight:height];
    separator.wex_layerColor = color;
    [self appendCell:separator toSection:section];
}


#pragma mark - 动态行标记

static NSString *DynamicCellBeginFlagKey = @"DynamicCellBeginFlagKey";

- (void)markDynamicCellBeginFlag:(NSString *)beginFlag toSection:(NSInteger)section {
    
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    
    if (rows.lastObject) {
        objc_setAssociatedObject(rows.lastObject, &DynamicCellBeginFlagKey, beginFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSInteger)indexOfDynamicCellBeginFlag:(NSString *)beginFlag section:(NSInteger)section {
    
    NSArray *rows = [self.dataSource objectForKey:@(section)];
    
    for (int i = 0; i < rows.count; i++) {
        
        id obj = objc_getAssociatedObject(rows[i], &DynamicCellBeginFlagKey);
        
        if (obj && [obj isKindOfClass:[NSString class]] && [beginFlag isEqualToString:((NSString *)obj)]) {
            return i + 1;
        }
    }
    return 0;
}



@end

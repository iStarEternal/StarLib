//
//  NSArray+Language.h
//  WexWeiCaiFu
//
//  Created by 星星 on 16/6/6.
//  Copyright © 2016年 SinaPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray<ObjectType> (Suger)

- (NSArray *)map:(id (^)(ObjectType element))block;

- (NSArray<ObjectType> *)filter:(BOOL (^)(ObjectType element))block;

/**
 按照数组正序切掉尾部数据，切掉block返回为false之后的所有
 */
- (NSArray<ObjectType> *)cutoff:(BOOL (^)(ObjectType element))block;

/**
 按照数组逆序切掉头部数据，切掉block返回为false之前的所有
 */
- (NSArray<ObjectType> *)invertedCutoff:(BOOL (^)(ObjectType element))block;

- (NSArray<ObjectType> *)reversed;

- (id)reduce:(id)initial combine:(id (^)(id lastObj, id currentEle))combine;

- (ObjectType)elementWithComparator:(BOOL(^)(ObjectType element))comparator;

- (BOOL)containsObjectWithComparator:(BOOL(^)(id))comparator;

- (NSArray<ObjectType> *)sorted:(BOOL (^)(ObjectType previous, ObjectType current))comparator;

- (void)forEach:(void (^)(NSInteger i, ObjectType item, BOOL *stop))forEach;


- (NSArray<ObjectType> *)star_removedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)star_removedLastObject;
- (NSArray<ObjectType> *)star_removedObjectAtIndex:(NSUInteger)index;

- (NSArray<ObjectType> *)star_addedObject:(ObjectType)anObject;
- (NSArray<ObjectType> *)star_insertedObject:(ObjectType)anObject atIndex:(NSUInteger)index;

@end

@interface NSDictionary<ObjectKeyType, ObjectValueType> (StarSuger)

- (NSDictionary<ObjectKeyType, ObjectValueType> *)filter:(BOOL (^)(ObjectKeyType key))block;

- (NSString *)query;

@end

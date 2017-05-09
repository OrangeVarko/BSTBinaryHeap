//
//  BSTBinaryHeap.h
//  PROJECT
//
//  Created by chen liangxiu on 2017/5/8.
//  Copyright © 2017年 PROJECT_OWNER. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^Operator)(id object);

/**
 * A more useful wrapper around CFBinaryHeap.
 *
 * Eeach NSObject instance can add to heap as heap node
 * binary heap is useful for making a priority queue,it is searched by binary search algrithm.
 *
 *     10
 *    / \
 *   6   100
 *  / \
 * 1   9
 * you can add remove found object.
 */
@interface BSTBinaryHeap : NSObject

+(instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

/*
 **designated initializer, which has tow paramters.
 *
 *@param first paramter is a NSComparator with nonnull attribute,because of using for
 *building sorted binary heap(also is binary tree), second is capacity.
 *
 *@return BSTBinary heap instance
 */
- (instancetype)initWithComparator:(nonnull NSComparator)comparator andCapacity:(NSUInteger)capacity NS_DESIGNATED_INITIALIZER;

/** add a object into bstBianryHeap */
- (void)addObj:(id)obj;

/** find the minimum obj */
- (id)minimumObj;

/** remove the minimum obj from bstBinaryHeap
 *
 *@return the removed instance
 */
- (id)removeMinimum;

/** remove all objects from bstBinaryHeap */
- (void)removeAll;

/**check the obj you gived is exsit in bstBinaryHeap
 *
 *@return flag exsited
 */
- (BOOL)containObj:(id)obj;

/**enumerate all objects from bstBinaryHeap
 *
 *@param block will be applyed in each object
 *
 */
- (void)enumerateObjectsUsingBlock:(Operator)CF_NOESCAPE block;

/**the count of objects in bstBinaryHeap
 *
 *@return count number
 */
- (NSUInteger)count;


- (NSUInteger)countOf:(id)obj;

/** get a array contained all objects
 *
 *@return all objects array
 */
- (NSArray *)objects;

@end
NS_ASSUME_NONNULL_END

//
//  BSTBinaryHeapDemoTests.m
//  BSTBinaryHeapDemoTests
//
//  Created by chen liangxiu on 2017/5/9.
//  Copyright © 2017年 cn.liang.xiu.chen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSTBinaryHeap.h"

#define BSTAssertNotNil(parm1) NSAssert(parm1, @"nil exception");
#define BSTAssertEqual(num1,num2) NSAssert((num1) == (num2), @"not equal exception");

typedef CFIndex BSTPriority;

@interface TestObj : NSObject

@property (nonatomic, assign) BSTPriority order;
- (instancetype)initWith:(BSTPriority)order;

@end

@implementation TestObj

- (instancetype)initWith:(BSTPriority)order
{
    if (self = [super init]) {
        _order = order;
    }
    return self;
}

@end

static BSTBinaryHeap *heap = nil;
static NSComparator _comparator_ = ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    TestObj *tobj1 = (TestObj *)obj1;
    TestObj *tobj2 = (TestObj *)obj2;
    if (tobj1.order > tobj2.order) {
        return NSOrderedDescending;
    } else if (tobj1.order == tobj2.order) {
        return NSOrderedSame;
    } else {
        return NSOrderedAscending;
    }
};

@interface BSTBinaryHeapDemoTests : XCTestCase

@end

@implementation BSTBinaryHeapDemoTests

- (void)setUp {
    [super setUp];
    heap = [[BSTBinaryHeap alloc] initWithComparator:_comparator_ andCapacity:10];
    BSTAssertNotNil(heap);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddObj {
    [self addFiveObjs];
    BSTAssertEqual([heap count], 5);
}

- (void)addFiveObjs
{
    [heap addObj:[[TestObj alloc] initWith:1]];
    [heap addObj:[[TestObj alloc] initWith:2]];
    [heap addObj:[[TestObj alloc] initWith:3]];
    [heap addObj:[[TestObj alloc] initWith:4]];
    [heap addObj:[[TestObj alloc] initWith:5]];
}

- (void)testRemoveObj {
    [self addFiveObjs];
    TestObj *minimal = (TestObj *)[heap removeMinimum];
    BSTAssertEqual(minimal.order, 1);
    BSTAssertEqual([heap count], 4);
}

- (void)testEnumrateObj {
    [self addFiveObjs];
    [heap enumerateObjectsUsingBlock:^(id  _Nonnull object) {
        BSTAssertNotNil(object);
        TestObj *obj = (TestObj *)object;
        NSLog(@"unOrder objects: %@",obj);
    }];
}

- (void)testFindMinumumPerformance {
    [self addRandomExamplesWith:100000];
    __block TestObj *minimum = nil;
    [self measureBlock:^{
        minimum = (TestObj *)[heap minimumObj];
    }];
    NSLog(@"----------%ld--------",minimum.order);
}

- (void)addRandomExamplesWith:(CFIndex)capacity
{
    heap = [[BSTBinaryHeap alloc] initWithComparator:_comparator_ andCapacity:capacity];
    for (CFIndex i = 0; i < capacity; i++) {
        BSTPriority order = (BSTPriority)arc4random_uniform(capacity * 2);
        TestObj *obj = [[TestObj alloc] initWith:order];
        [heap addObj:obj];
    }
}
@end

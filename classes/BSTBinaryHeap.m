//
//  BSTBinaryHeap.m
//  PROJECT
//
//  Created by chen liangxiu on 2017/5/8.
//  Copyright © 2017年 PROJECT_OWNER. All rights reserved.
//

#import "BSTBinaryHeap.h"
#import <malloc/malloc.h>

static NSComparator bst_comparator = NULL;
static CFComparisonResult bst_compare(const void *ptr1, const void *ptr2, void *context)
{
    if (bst_comparator) {
        return (CFComparisonResult)bst_comparator((__bridge id _Nonnull)(ptr1),(__bridge id _Nonnull)(ptr2));
    }
    return kCFCompareGreaterThan;
}

static const void * bst_retain(CFAllocatorRef allocator, const void *ptr)
{
    return (const void *)CFRetain((CFTypeRef)ptr);
}

static void bst_release(CFAllocatorRef allocator, const void *ptr)
{
    return (void)CFRelease((CFTypeRef)ptr);
}

static void bst_CFBinaryHeapApplierFunction(const void *val, void *context)
{
    Operator block = (__bridge Operator)(context);
    block ? block((__bridge id)(val)) : (void)0;

}

NS_INLINE __unused CFBinaryHeapCallBacks bst_CFBinaryHeapCallBacksCreate()
{
    return (CFBinaryHeapCallBacks) {
        .release = bst_release,
        .retain = bst_retain,
        .compare = bst_compare
    };
}

NS_INLINE CFBinaryHeapRef bst_CFBinaryHeapRefCreate(CFIndex capacity)
{
    return CFBinaryHeapCreate(NULL, capacity, &(CFBinaryHeapCallBacks){
        .release = bst_release,
        .retain = bst_retain,
        .compare = bst_compare,
        .copyDescription = CFCopyDescription
    }, NULL);
}

@implementation BSTBinaryHeap
{
    CFBinaryHeapRef _binaryHeap;
}

- (instancetype)initWithComparator:(NSComparator)comparator andCapacity:(NSUInteger)capacity
{
    if (self = [super init]) {
        _binaryHeap = bst_CFBinaryHeapRefCreate(capacity);
        bst_comparator = [comparator copy];
    }
    return self;
}

- (void)dealloc
{
    CFRelease(_binaryHeap);
}

- (NSUInteger)count
{
    CFIndex count = CFBinaryHeapGetCount(_binaryHeap);
    count = count < 0 ? 0 : count;
    return count;
}

- (NSUInteger)countOf:(id)obj
{
    CFIndex count = CFBinaryHeapGetCountOfValue(_binaryHeap, (__bridge const void *)(obj));
    count = count < 0 ? 0 : count;
    return count;
}

- (void)addObj:(id)obj
{
    CFBinaryHeapAddValue(_binaryHeap, (__bridge const void *)(obj));

}

- (NSArray *)objects
{
    CFIndex size = [self count];
    CFTypeRef *cfValues = calloc(size, sizeof(CFTypeRef));
    CFBinaryHeapGetValues(_binaryHeap, (const void **)cfValues);
    CFArrayRef objects = CFArrayCreate(kCFAllocatorDefault, cfValues, size, &kCFTypeArrayCallBacks);
    NSArray *objs = (__bridge_transfer NSArray *)objects;
    free(cfValues);
    return objs;
}

- (id)minimumObj
{
    return (__bridge id)CFBinaryHeapGetMinimum(_binaryHeap);
}

- (id)removeMinimum
{
    id obj = (__bridge id)CFBinaryHeapGetMinimum(_binaryHeap);
    CFBinaryHeapRemoveMinimumValue(_binaryHeap);
    return obj;
}

- (void)removeAll
{
    CFBinaryHeapRemoveAllValues(_binaryHeap);
}

- (BOOL)containObj:(id)obj
{
    return (BOOL)CFBinaryHeapContainsValue(_binaryHeap, (__bridge const void *)(obj));
}

- (void)enumerateObjectsUsingBlock:(Operator)block
{
    CFBinaryHeapApplyFunction(_binaryHeap, bst_CFBinaryHeapApplierFunction, (__bridge void *)block);
}

@end

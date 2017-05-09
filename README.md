# BSTBinaryHeap
BSTBinaryHeap is a wrapper of CFBinaryHeap.it is useful for making a priority queue

### installation
BSTBinaryHeap supports cocoapods for installing the library in a project.
## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like BSTBinaryHeap in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```
#### Podfile

To integrate BSTBinaryHeap into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'BSTBinaryHeap', '~> 0.0.1'
end
```
Then, run the following command:

```bash
$ pod install
```
## Usage
#### Creating BSTBinaryHeap
```objective-c
NSComparator _comparator_ = ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
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
BSTBinaryHeap *heap = [[BSTBinaryHeap alloc] initWithComparator:_comparator_ andCapacity:10];
```
### Adding Object to Heap
```
[heap addObj:[[TestObj alloc] initWith:1]];
[heap addObj:[[TestObj alloc] initWith:2]];
[heap addObj:[[TestObj alloc] initWith:3]];
[heap addObj:[[TestObj alloc] initWith:4]];
[heap addObj:[[TestObj alloc] initWith:5]];
```
### Getting minimum one and Enumerating
```
TestObj *minimal = (TestObj *)[heap removeMinimum];
//enumerate
[heap enumerateObjectsUsingBlock:^(id  _Nonnull object) {
        BSTAssertNotNil(object);
        TestObj *obj = (TestObj *)object;
        NSLog(@"unOrder objects: %@",obj);
    }];
```
### Other
欢迎大家issue me

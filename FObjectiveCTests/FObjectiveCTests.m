//
//  FObjectiveCTests.m
//  FObjectiveCTests
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FObjectiveCTests.h"
#import "FObjectiveC.h"

@implementation FObjectiveCTests

- (void)testFBoolMacro
{
  STAssertEqualObjects(FBool(YES), @YES, @"");
  STAssertEqualObjects(FBool(NO), @NO, @"");
}

- (void)testComp
{
  FFn upcase = ^(NSString *str){
    return [str uppercaseString];
  };
  FFn trim3 = ^(NSString *str){
    return [str substringToIndex:3];
  };
  
  FFn trim3Upper = FComp(upcase, trim3);
  STAssertEqualObjects(trim3Upper(@"three"), @"THR", @"");
}

- (void)testPartial
{
  FFn2 strCat = ^(NSString *a, NSString *b){
    return [a stringByAppendingString:b];
  };
  
  FFn mrCat = FPartial(strCat, @"Mr. ");
  STAssertEqualObjects(mrCat(@"Cat"), @"Mr. Cat", @"");
}

- (void)testMap
{
  NSArray *numbers = @[@"one", @"two"];
  NSArray *upcaseNumbers = FMap(^(NSString* number) {
    return [number uppercaseString];
  }, numbers);
  
  NSArray *expected = @[@"ONE", @"TWO"];
  STAssertEqualObjects(upcaseNumbers, expected, @"");
}

// Need to set optimization level to -O2 at least (or enable the -foptimize-sibling-calls flag)
- (void)testBigArrays
{
  int size = 100000;
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:size];
  for (int i=0; i<size; i++) {
    [array addObject:@"string"];
  }
  NSArray *upcaseNumbers = FMap(^(NSString* number) {
    return [number uppercaseString];
  }, array);
  STAssertEqualObjects([upcaseNumbers objectAtIndex:0], @"STRING", @"");
}

- (void)testFilter
{
  NSArray *numbers = FFilter(^(id obj) {
    return FBool([obj isKindOfClass:[NSNumber class]]);
  }, @[@1, @"two", @3, @4, @"five"]);
  
  NSArray *expected = @[@1, @3, @4];
  
  STAssertEqualObjects(numbers, expected, @"");
}

- (void)testRemove
{
  NSArray *numbers = FRemove(^(id obj) {
    return FBool([obj isKindOfClass:[NSNumber class]]);
  }, @[@1, @"two", @3, @4, @"five"]);
  
  NSArray *expected = @[@"two", @"five"];
  
  STAssertEqualObjects(numbers, expected, @"");
}

- (void)testConcat
{
  NSArray *result = FConcat(@[@1, @2], @[@3]);
  NSArray *expected = @[@1, @2, @3];
  STAssertEqualObjects(result, expected, @"");
}

- (void)testReduceWithInitialValue
{
  NSNumber *sum = FReduce(^(NSNumber *obj1, NSNumber *obj2) {
    int sum = [obj1 integerValue] + [obj2 integerValue];
    return [NSNumber numberWithInt:sum];
  }, @0, @[@1, @2, @3, @4]);
  
  STAssertEqualObjects(sum, @10, @"");
}

- (void)testReduceWithoutInitialValue
{
  NSNumber *sum = FReduce(^(NSNumber *obj1, NSNumber *obj2) {
    int sum = [obj1 integerValue] + [obj2 integerValue];
    return [NSNumber numberWithInt:sum];
  }, nil, @[@1, @2, @3, @4]);
  
  STAssertEqualObjects(sum, @10, @"");
}

- (void)testEveryTrue
{
  STAssertEqualObjects(FEvery(FIdentity, @[@YES, @YES]), @YES, @"");
}

- (void)testEveryFalses
{
  STAssertEqualObjects(FEvery(FIdentity, @[@YES, @NO]), @NO, @"");
}

- (void)testSomeTrue
{
  STAssertEqualObjects(FSome(FIdentity, @[@NO, @NO]), @NO, @"");
}

- (void)testSomeFalses
{
  STAssertEqualObjects(FSome(FIdentity, @[@NO, @YES]), @YES, @"");
}

- (void)testComplement
{
  FFn not = FComplement(FIdentity);
  STAssertEqualObjects(not(@YES), @NO, @"");
}

- (void)testConstantly
{
  FFn unity = FConstantly(@5);
  STAssertEqualObjects(unity(@1), @5, @"");
  STAssertEqualObjects(unity(@10), @5, @"");
}

- (void)testTake
{
  NSArray *twoThings = FTake(2, @[@1, @2, @3]);
  NSArray *expected = @[@1, @2];
  STAssertEqualObjects(twoThings, expected, @"");
}

- (void)testTakeMoreThanWeHave
{
  NSArray *numbers = @[@1, @2, @3];
  STAssertEqualObjects(FTake(7, numbers), numbers, @"");
}

- (void)testTakeWhile
{
  NSArray *twoThings = FTakeWhile(^(NSNumber *obj){
    return FBool([obj intValue]<3);
  }, @[@1, @2, @3]);
  NSArray *expected = @[@1, @2];
  STAssertEqualObjects(twoThings, expected, @"");
}

- (void)testTakeWhileAlwaysTrue
{
  NSArray *numbers = FTakeWhile(^(NSNumber *obj){
    return @YES;
  }, @[@1, @2, @3]);
  NSArray *expected = @[@1, @2, @3];
  STAssertEqualObjects(numbers, expected, @"");
}

- (void)testDrop
{
  NSArray *oneThing = FDrop(2, @[@1, @2, @3]);
  NSArray *expected = @[@3];
  STAssertEqualObjects(oneThing, expected, @"");
}

- (void)testDropMoreThanWeHave
{
  NSArray *numbers = FDrop(4, @[@1, @2, @3]);
  STAssertEqualObjects(numbers, @[], @"");
}

- (void)testDropWhile
{
  NSArray *numbers = FDropWhile(^(NSNumber *obj){
    return FBool([obj intValue]<3);
  }, @[@1, @2, @3]);
  NSArray *expected = @[@3];
  STAssertEqualObjects(numbers, expected, @"");
}

- (void)testDropWhileAlwaysTrue
{
  NSArray *numbers = FDropWhile(^(NSNumber *obj){
    return @YES;
  }, @[@1, @2, @3]);
  STAssertEqualObjects(numbers, @[], @"");
}

- (void)testRange
{
  NSArray *expected = @[@1, @2, @3];
  STAssertEqualObjects(FRange(1,4,1), expected, @"");

  expected = @[@1, @3, @5];
  STAssertEqualObjects(FRange(1, 6, 2), expected, @"");
}

- (void)testPartition
{
  NSArray *expected = @[ @[@1, @2], @[@3, @4] ];
  FPartition(2, FRange(1, 3, 1));
  STAssertEqualObjects(FPartition(2, FRange(1, 6, 1)), expected, @"");
}

- (void)testMapOverDictionary
{
  NSDictionary *dict = @{@1 : @"one", @2 : @"two"};
  NSArray *result = FMap(^(NSArray *kv) {
    return @[[kv objectAtIndex:1], [kv objectAtIndex:0]];
  }, dict);
  NSArray *expected = @[@[@"one", @1], @[@"two", @2]];
  STAssertEqualObjects(result, expected, @"brittle test expects dictionary to be ordered");
}

- (void)testMapOverString
{
  NSArray *result = FMap(^(NSString *c) {
    return [c uppercaseString];
  }, @"yelling");
  NSArray *expected = @[@"Y",@"E",@"L",@"L",@"I",@"N",@"G"];
  STAssertEqualObjects(result, expected, @"");
}

@end

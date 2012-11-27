//
//  FObjectiveCTests.m
//  FObjectiveCTests
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FObjectiveCTests.h"

@implementation FObjectiveCTests

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
  FCons *upcaseNumbers = FMap(^id(id number) {
    return [(NSString*)number uppercaseString];
  }, numbers);
  
  STAssertEqualObjects([upcaseNumbers first], @"ONE", @"");
  STAssertEqualObjects([[upcaseNumbers next] first], @"TWO", @"");
}

// Need to set optimization level to -O2 at least (or enable the -foptimize-sibling-calls flag)
- (void)testBigArrays
{
  int size = 100000;
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:size];
  for (int i=0; i<size; i++) {
    [array addObject:@"string"];
  }
  FCons *upcaseNumbers = FMap(^id(id number) {
    return [(NSString*)number uppercaseString];
  }, array);
  STAssertEqualObjects([upcaseNumbers first], @"STRING", @"");
}

- (void)testFilter
{
  FCons *numbers = FFilter(^BOOL(id obj) {
    return [obj isKindOfClass:[NSNumber class]];
  }, @[@1, @"two", @3, @4, @"five"]);
  
  STAssertEqualObjects([numbers first], @1, @"");
  STAssertEqualObjects([[numbers next] first], @3, @"");
  STAssertEqualObjects([[[numbers next] next] first], @4, @"");
  STAssertNil([[[[numbers next] next] next] first], @"");
}

- (void)testReduceWithInitialValue
{
  NSNumber *sum = FReduce(^id(id obj1, id obj2) {
    int sum = [(NSNumber*)obj1 integerValue] + [(NSNumber*)obj2 integerValue];
    return [NSNumber numberWithInt:sum];
  }, @0, @[@1, @2, @3, @4]);
  
  STAssertEqualObjects(sum, @10, @"");
}

- (void)testReduceWithoutInitialValue
{
  NSNumber *sum = FReduce(^id(id obj1, id obj2) {
    int sum = [(NSNumber*)obj1 integerValue] + [(NSNumber*)obj2 integerValue];
    return [NSNumber numberWithInt:sum];
  }, nil, @[@1, @2, @3, @4]);
  
  STAssertEqualObjects(sum, @10, @"");
}

@end

//
//  FSeqableCategoriesTests.m
//  FObjectiveC
//
//  Created by John Andrews on 12/1/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FSeqableCategoriesTests.h"
#import "FArraySeq.h"

@implementation FSeqableCategoriesTests

- (void)testArray
{
  NSArray *orig = @[@1, @2];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testMutableArray
{
  NSMutableArray *orig = [NSMutableArray arrayWithArray:@[@1, @2]];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testSet
{
  NSSet *orig = [NSSet setWithArray:@[@1, @2]];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testMutableSet
{
  NSMutableSet *orig = [NSMutableSet setWithArray:@[@1, @2]];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testOrderedSet
{
  NSOrderedSet *orig = [[NSOrderedSet alloc] initWithArray:@[@1, @2]];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testMutableOrderedSet
{
  NSMutableOrderedSet *orig = [[NSMutableOrderedSet alloc] initWithArray:@[@1, @2]];
  FArraySeq *seq = (FArraySeq *)[orig seq];
  STAssertNotNil([seq first], @"");
}

- (void)testDictionary
{
  STAssertNotNil([[@{@"key" : @"value"} seq] first], @"");
}

- (void)testMutableDictionary
{
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{@"key" : @"value"}];
  STAssertNotNil([[dict seq] first], @"");
}

- (void)testString
{
  NSString *str = @"string";
  STAssertEqualObjects([[str seq] first], @"s", @"");
}

- (void)testMutableString
{
  NSMutableString *str = [NSMutableString stringWithString:@"string"];
  STAssertEqualObjects([[str seq] first], @"s", @"");
}

@end

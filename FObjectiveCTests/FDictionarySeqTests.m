//
//  FDictionarySeqTests.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FDictionarySeqTests.h"
#import "FObjectiveC.h"

@implementation FDictionarySeqTests

- (void)testFirst
{
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{@1 : @"one"}];
  NSArray *expected = @[@1, @"one"];
  STAssertEqualObjects([seq first], expected, @"");
}

- (void)testFirstOfEmptyDict
{
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{}];
  STAssertNil([seq first], @"");
}

- (void)testNext
{
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{@1 : @"one", @2: @"two"}];
  NSArray *expected = @[@2, @"two"];
  STAssertEqualObjects([[seq next] first], expected, @"this test is brittle. Dicts are unordered.");
}

- (void)testNextNil
{
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{}];
  STAssertNil([seq next], @"empty list");
}

- (void)testCons
{
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{@1 : @"one"}];
  id<FSeq> cons = [seq cons:@[@0, @"zero"]];
  NSArray *expected = @[@0, @"zero"];
  STAssertEqualObjects([cons first], expected, @"should be added to head position by cons");
}

- (void)testConsTail
{
  
  FDictionarySeq *seq = [[FDictionarySeq alloc] initWithDictionary:@{@1 : @"one"}];
  id<FSeq> cons = [seq cons:@[@0, @"zero"]];
  NSArray *expected = @[@1, @"one"];
  
  STAssertEqualObjects([[cons next] first], expected, @"head of seq should be 2nd position of new cons");
}

@end

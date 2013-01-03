//
//  FStringSeqTests.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FStringSeqTests.h"
#import "FObjectiveC.h"

@implementation FStringSeqTests

- (void)testFirst
{
  FStringSeq *seq = [[FStringSeq alloc] initWithString:@"one"];
  STAssertEqualObjects([seq first], @"o", @"");
}

- (void)testFirstOfEmptyString
{
  FStringSeq *seq = [[FStringSeq alloc] initWithString:@""];
  STAssertNil([seq first], @"");
}

- (void)testNext
{
  FStringSeq *seq = [[FStringSeq alloc] initWithString:@"one"];
  STAssertEqualObjects([[seq next] first], @"n", @"");
}

//
//- (void)testNextBoundary
//{
//  STAssertEqualObjects([[[self.seq next] next] first], @"three", @"last obj in array");
//}
//
//- (void)testNextNil
//{
//  STAssertNil([[[self.seq next] next] next], @"empty list");
//}
//
//- (void)testCons
//{
//  id<FSeq> cons = [self.seq cons:@"zero"];
//  STAssertEqualObjects(@"zero", [cons first], @"should be added to head position by cons");
//}
//
//- (void)testConsTail
//{
//  STAssertEqualObjects(@"one", [[[self.seq cons:@"zero"] next] first], @"head of seq should be 2nd position of new cons");
//}

@end

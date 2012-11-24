//
//  FArraySeqTests.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FArraySeqTests.h"
#import "FArraySeq.h"

@interface FArraySeqTests ()
@property (nonatomic, strong) FArraySeq *seq;
@end

@implementation FArraySeqTests

- (void)setUp
{
  [super setUp];
  self.seq = [[FArraySeq alloc] initWithArray:@[@"one", @"two", @"three"]];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testFirst
{
  STAssertEqualObjects([self.seq first], @"one", @"first obj in array");
}

- (void)testNext
{
  STAssertEqualObjects([[self.seq next] first], @"two", @"second obj in array");
}

- (void)testNextBoundary
{
  STAssertEqualObjects([[[self.seq next] next] first], @"three", @"last obj in array");
}

- (void)testNextNil
{
  STAssertNil([[[self.seq next] next] next], @"empty list");
}

- (void)testCons
{
  id<FSeq> cons = [self.seq cons:@"zero"];
  STAssertEqualObjects(@"zero", [cons first], @"should be added to head position by cons");
}

- (void)testConsTail
{
  STAssertEqualObjects(@"one", [[[self.seq cons:@"zero"] next] first], @"head of seq should be 2nd position of new cons");
}
@end

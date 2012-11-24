//
//  FConsTests.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FConsTests.h"
#import "FCons.h"
#import "NSArray+FSeqable.h"

@interface FConsTests ()
@property (nonatomic, strong) FCons *cons;
@end

@implementation FConsTests

- (void)testFirst
{
  FCons *cons = [[FCons alloc] initWithHead:@"one" tail:@[@"two", @"three"]];
  STAssertEqualObjects([cons first], @"one", @"first obj in array");
}

- (void)testNext
{
  FCons *cons = [[FCons alloc] initWithHead:@"one" tail:@[@"two", @"three"]];
  STAssertEqualObjects([[cons next] first], @"two", @"second obj in array");
}

- (void)testNextNil
{
  FCons *cons = [[FCons alloc] initWithHead:@"one" tail:nil];
  STAssertEqualObjects([cons first], @"one", @"first obj in array");
  STAssertNil([cons next], @"next should be nil");
}

- (void)testCons
{
  FCons *oneThing = [[FCons alloc] initWithHead:@"two" tail:nil];
  FCons *cons = [oneThing cons:@"one"];
  STAssertEqualObjects([cons first], @"one", @"cons of conses");
  STAssertEqualObjects([[cons next] first], @"two", @"");
}

@end

//
//  FFunTests.m
//  FObjectiveC
//
//  Created by John Andrews on 11/25/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FFunTests.h"
#import "FFun.h"
@implementation FFunTests

- (void)testFn1
{
  FFun *upcase = [FFun fn1:^id(NSString *s) {
    return [s uppercaseString];
  }];

  STAssertEqualObjects([upcase call:@"hello"], @"HELLO", @"");
}

- (void)testFn2
{
  FFun *adder = [FFun fn2:^id(NSNumber *a, NSNumber *b) {
    return [NSNumber numberWithInt:([a intValue] + [b intValue])];
  }];

  // STAssertEqualObjects is F'd up and can't handle varargs
  NSNumber *result = [adder call:@2, @3];
  STAssertEqualObjects(result, @5, @"");
}

@end

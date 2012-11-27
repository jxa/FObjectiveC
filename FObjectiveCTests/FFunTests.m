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

- (void)testPartial
{
  FFun *adder = [FFun fn2:^id(NSNumber *a, NSNumber *b) {
    return [NSNumber numberWithInt:([a intValue] + [b intValue])];
  }];
  
  FFun *add2 = [adder partial:@[@2]];
  STAssertEqualObjects([add2 call:@3], @5, @"");
}

- (void)testSimpleRecursion
{
  // it turns out that we need the __block here because count needs to be defined on the heap
  // I need to understand this better. maybe read this again http://ddeville.me/2011/10/recursive-blocks-objc/
  __block FFun *count;
  count = [FFun fn2:^id(NSNumber *a, NSNumber *b) {
    if([b isEqualToNumber:@0]){
      return a;
    } else {
      NSNumber *aPrime = [NSNumber numberWithInt:([a intValue] + 1)];
      NSNumber *bPrime = [NSNumber numberWithInt:([b intValue] - 1)];
      return [count call:aPrime, bPrime];
    }
  }];
  
  NSNumber *result = [count call:@3, @5];
  STAssertEqualObjects(result, @8, @"");
}
@end

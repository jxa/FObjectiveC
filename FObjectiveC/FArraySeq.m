//
//  FArraySeq.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FArraySeq.h"
#import "FCons.h"

@interface FArraySeq ()
@property (nonatomic, readonly) int index;
@property (nonatomic, strong, readonly) NSArray *array;

- (id)initWithArray:(NSArray *)array index:(int)i;
@end

@implementation FArraySeq

// designated
- (id)initWithArray:(NSArray *)array index:(int)i
{
  self = [super init];
  if (self) {
    _array = array;
    _index = i;
  }
  return self;
}

- (id)initWithArray:(NSArray *)array
{
  return [self initWithArray:array index:0];
}


- (id)first
{
  if ([self.array count] > self.index) {
    return [self.array objectAtIndex:self.index];
  } else {
    return nil;
  }
}

- (id<FSeq>)next
{
  int nextIndex = self.index + 1;
  if (nextIndex < self.array.count) {
    return [[[self class] alloc] initWithArray:self.array index:nextIndex];
  } else {
    return nil;
  }
}

- (id<FSeq>)cons:(id)object
{
  return [[FCons alloc] initWithHead:object tail:self];
}

- (id<FSeq>)seq
{
  return self;
}

@end

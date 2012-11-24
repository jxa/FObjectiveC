//
//  FCons.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FCons.h"

@interface FCons ()
@property (nonatomic, strong, readonly) id head;
@property (nonatomic, strong, readonly) id<FSeq> tail;
@end

@implementation FCons

- (id)initWithHead:(id)head tail:(id<FSeqable>)tail
{
  self = [super init];
  if (self) {
    _head = head;
    _tail = [tail seq];
  }
  return self;
}

- (id)first
{
  return self.head;
}

- (id<FSeq>)next
{
  return self.tail;
}

- (FCons *)cons:(id)object
{
  return [[FCons alloc] initWithHead:object tail:self];
}

- (id<FSeq>)seq
{
  return self;
}


@end

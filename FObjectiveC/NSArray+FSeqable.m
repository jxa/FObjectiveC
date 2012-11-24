//
//  NSArray+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSArray+FSeqable.h"
#import "FArraySeq.h"

@implementation NSArray (FSeqable)

- (id<FSeq>)seq
{
  return [[FArraySeq alloc] initWithArray:self];
}

@end

//
//  NSMutableArray+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/1/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSMutableArray+FSeqable.h"
#import "FArraySeq.h"

@implementation NSMutableArray (FSeqable)

- (id<FSeq>)seq
{
  NSArray *immutable = [NSArray arrayWithArray:self];
  return [[FArraySeq alloc] initWithArray:immutable];
}

@end

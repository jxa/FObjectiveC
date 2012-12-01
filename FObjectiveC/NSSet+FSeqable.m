//
//  NSSet+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/1/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSSet+FSeqable.h"
#import "FArraySeq.h"

@implementation NSSet (FSeqable)

- (id<FSeq>)seq
{
  return [[FArraySeq alloc] initWithArray:[self allObjects]];
}

@end

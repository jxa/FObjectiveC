//
//  NSOrderedSet+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/1/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSOrderedSet+FSeqable.h"
#import "FArraySeq.h"

@implementation NSOrderedSet (FSeqable)

- (FArraySeq *)seq
{
  return [[FArraySeq alloc] initWithArray:[self array]];
}

@end

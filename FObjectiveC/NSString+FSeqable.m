//
//  NSString+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/8/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSString+FSeqable.h"
#import "FStringSeq.h"

@implementation NSString (FSeqable)

- (id<FSeq>)seq
{
  return [[FStringSeq alloc] initWithString:self];
}

@end

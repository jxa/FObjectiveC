//
//  NSMutableString+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/8/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSMutableString+FSeqable.h"
#import "FStringSeq.h"

@implementation NSMutableString (FSeqable)

- (id<FSeq>)seq
{
  return [[FStringSeq alloc] initWithString:[NSString stringWithString:self]];
}

@end

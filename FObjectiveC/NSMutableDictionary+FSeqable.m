//
//  NSMutableDictionary+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSMutableDictionary+FSeqable.h"
#import "FDictionarySeq.h"

@implementation NSMutableDictionary (FSeqable)

- (id<FSeq>)seq
{
  NSDictionary *immutable = [NSDictionary dictionaryWithDictionary:self];
  return [[FDictionarySeq alloc] initWithDictionary:immutable];
}

@end

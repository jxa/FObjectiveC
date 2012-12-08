//
//  NSDictionary+FSeqable.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "NSDictionary+FSeqable.h"
#import "FDictionarySeq.h"

@implementation NSDictionary (FSeqable)

- (id<FSeq>)seq
{
  return [[FDictionarySeq alloc] initWithDictionary:self];
}

@end

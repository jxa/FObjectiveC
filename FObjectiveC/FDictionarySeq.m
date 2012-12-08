//
//  FDictionarySeq.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FDictionarySeq.h"
#import "FArraySeq.h"

@interface FDictionarySeq ()
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) FArraySeq *keys;
@end

@implementation FDictionarySeq

- (id)initWithDictionary:(NSDictionary *)dict
{
  FArraySeq *keys = [[FArraySeq alloc] initWithArray:[dict allKeys]];
  return [self initWithDictionary:dict keySeq:keys];
}

- (id)initWithDictionary:(NSDictionary *)dict keySeq:(FArraySeq *)keys
{
  self = [super init];
  if (self) {
    self.dict = dict;
    self.keys = keys;
  }
  return self;
}

- (id)first
{
  id key = [self.keys first];
  if (key) {
    return @[key, [self.dict objectForKey:key]];
  } else {
    return nil;
  }
}

- (id<FSeq>)next
{
  id nextKey = [self.keys next];
  if (nextKey) {
    return [[[self class] alloc] initWithDictionary:self.dict keySeq:nextKey];
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

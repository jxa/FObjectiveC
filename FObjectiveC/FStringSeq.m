//
//  FStringSeq.m
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FStringSeq.h"

@interface FStringSeq ()
@property (nonatomic, readonly) int index;
@property (nonatomic, strong, readonly) NSString *string;

- (id)initWithString:(NSString *)str index:(int)i;
@end

@implementation FStringSeq

- (id)initWithString:(NSString *)str index:(int)i
{
  self = [super init];
  if (self) {
    _string = str;
    _index = i;
  }
  return self;
}

- (id)initWithString:(NSString *)str
{
  return [self initWithString:str index:0];
}

- (id)first
{
  if (self.index < [self.string length]) {
    unichar c =[self.string characterAtIndex:self.index];
    return [NSString stringWithCharacters:&c length:1];
  } else {
    return nil;
  }
}

- (id)next
{
  int nextIndex = self.index + 1;
  if (nextIndex < [self.string length]) {
    return [[[self class] alloc] initWithString:self.string index:nextIndex];
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

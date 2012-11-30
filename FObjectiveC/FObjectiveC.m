//
//  FObjectiveC.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FObjectiveC.h"

FFn (^FComp)(FFn, FFn) = ^(FFn f, FFn g)
{
  return ^(id obj){
    return f(g(obj));
  };
};

FFn (^FPartial)(FFn2, id) = ^(FFn2 fn, id arg)
{
  return ^(id obj){
    return fn(arg, obj);
  };
};

NSArray* (^FMap)(FFn, id<FSeqable>) = ^(FFn fn, id<FSeqable>seq)
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  id<FSeq> s = [seq seq];
  while ([s first]) {
    [result addObject:fn([s first])];
    s = [s next];
  }
  return result;
};

NSArray* (^FFilter)(FPredicate, id<FSeqable>) = ^(FPredicate pred, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  NSMutableArray *result = [[NSMutableArray alloc] init];

  while ([s first]) {
    if ([pred([s first]) boolValue]) {
      [result addObject:[s first]];
    }
    s = [s next];
  }
  
  return result;
};

id (^FReduce)(FFn2 reducer, id init, id<FSeqable>seq) = ^(FFn2 reducer, id init, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  id first = [s first];
  id result = init;
  
  if (!init) {
    result = FReduce(reducer, first, (id<FSeqable>)[s next]);
  } else {
    while (first) {
      result = reducer(result, first);
      s = [s next];
      first = [s first];
    }
  }
  return result;
};

id (^FIdentity)(id obj) = ^(id obj)
{
  return obj;
};

id (^FEvery)(FPredicate pred, id<FSeqable>seq) = ^(FPredicate pred, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  while ([s first]) {
    if (![pred([s first]) boolValue]) {
      return @NO;
    }
    s = [s next];
  }
  return @YES;
};

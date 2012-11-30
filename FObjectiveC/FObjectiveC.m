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

NSArray* (^FRemove)(FPredicate pred, id<FSeqable>) = ^(FPredicate pred, id<FSeqable>seq)
{
  return FFilter(FComplement(pred), seq);
};

NSArray* (^FConcat)(id<FSeqable>x, id<FSeqable>y) = ^(id<FSeqable>x, id<FSeqable>y)
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  id<FSeq> s;
  for (id<FSeqable> seqable in @[x, y]) {
    s = [seqable seq];
    while ([s first]) {
      [result addObject:[s first]];
      s = [s next];
    }
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

id (^FSome)(FPredicate pred, id<FSeqable>seq) = ^(FPredicate pred, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  while ([s first]) {
    if ([pred([s first]) boolValue]) {
      return @YES;
    }
    s = [s next];
  }
  return @NO;
};

FFn (^FComplement)(FPredicate pred) = ^(FPredicate pred)
{
  return ^(id obj){
    return [NSNumber numberWithBool:(![pred(obj) boolValue])];
  };
};

FFn (^FConstantly)(id obj) = ^(id obj)
{
  return ^(id anything) {
    return obj;
  };
};

NSArray* (^FTake)(int, id<FSeqable>) = ^(int n, id<FSeqable>seq)
{
  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:n];
  id<FSeq> s = [seq seq];
  
  while (n > 0) {
    [result addObject:[s first]];
    s = [s next];
    n--;
  }
  return result;
};

NSArray* (^FTakeWhile)(FPredicate, id<FSeqable>) = ^(FPredicate pred, id<FSeqable>seq)
{
  NSMutableArray *result = [[NSMutableArray alloc] init];
  id<FSeq> s = [seq seq];
  
  while ([pred([s first]) boolValue]) {
    [result addObject:[s first]];
    s = [s next];
  }

  return result;
};
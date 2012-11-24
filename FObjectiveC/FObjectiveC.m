//
//  FObjectiveC.m
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FObjectiveC.h"

@implementation FObjectiveC

@end

FFn FComp(FFn f, FFn g)
{
  return ^(id obj){
    return f(g(obj));
  };
}

FFn FPartial(FFn2 fn, id arg)
{
  return ^(id obj){
    return fn(arg, obj);
  };
}

FCons* FMap(FFn fn, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  id first = [s first];
  if (first) {
    return [[FCons alloc] initWithHead:fn(first) tail:FMap(fn, (id<FSeqable>)[s next])];
  } else {
    return nil;
  }
}

FCons* FFilter(FPredicate pred, id<FSeqable>seq)
{
  id<FSeq> s = [seq seq];
  id first = [s first];
  if (first) {
    if (pred(first)) {
      return [[FCons alloc] initWithHead:first tail:FFilter(pred, (id<FSeqable>)[s next])];
    } else {
      return FFilter(pred, (id<FSeqable>)[s next]);
    }
  } else {
    return nil;
  }
}

id FReduce(FFn2 reducer, id init, id<FSeqable>seq)
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
}
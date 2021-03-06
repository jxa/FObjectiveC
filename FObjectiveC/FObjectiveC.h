//
//  FObjectiveC.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSeq.h"
#import "FSeqable.h"
#import "FCons.h"
#import "NSArray+FSeqable.h"
#import "NSMutableArray+FSeqable.h"
#import "NSDictionary+FSeqable.h"
#import "NSMutableDictionary+FSeqable.h"
#import "NSOrderedSet+FSeqable.h"
#import "NSSet+FSeqable.h"
#import "NSString+FSeqable.h"
#import "FDictionarySeq.h"
#import "FStringSeq.h"

#define FBool(b) [NSNumber numberWithBool:b]

typedef id (^FFn)(id obj);
typedef id (^FFn2)(id obj1, id obj2);

// hint that the function should return truthy / falsy values
typedef FFn FPredicate;

FFn (^FComp)(FFn f, FFn g);
FFn (^FPartial)(FFn2 fn, id arg);
FFn (^FComplement)(FPredicate pred);
FFn (^FConstantly)(id obj);

FFn (^FFnFromSelector)(SEL selector);
FFn2 (^FFn2FromSelector)(SEL selector);
FFn (^FFnFromTargetAndSelector)(id target, SEL selector);


// TODO: maybe mark these return types as FSeqable so we can change
//       implementation in the future.
NSArray* (^FMap)(FFn fn, id<FSeqable>seq);
NSArray* (^FFilter)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FRemove)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FConcat)(id<FSeqable>x, id<FSeqable>y);

id (^FReduce)(FFn2 reducer, id init, id<FSeqable>seq);
id (^FIdentity)(id obj);
id (^FEvery)(FPredicate pred, id<FSeqable>seq);
id (^FSome)(FPredicate pred, id<FSeqable>seq);

NSArray* (^FTake)(int n, id<FSeqable>seq);
NSArray* (^FTakeWhile)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FDrop)(int n, id<FSeqable>seq);
NSArray* (^FDropWhile)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FPartition)(int n, id<FSeqable>seq);

NSArray* (^FRange)(int start, int end, int step);



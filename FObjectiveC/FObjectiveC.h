//
//  FObjectiveC.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCons.h"

typedef id (^FFn)(id obj);
typedef id (^FFn2)(id obj1, id obj2);

// hint that the function should return truthy / falsy values
typedef FFn FPredicate;

FFn (^FComp)(FFn f, FFn g);
FFn (^FPartial)(FFn2 fn, id arg);

NSArray* (^FMap)(FFn fn, id<FSeqable>seq);
NSArray* (^FFilter)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FRemove)(FPredicate pred, id<FSeqable>);

id (^FReduce)(FFn2 reducer, id init, id<FSeqable>seq);
id (^FIdentity)(id obj);
id (^FEvery)(FPredicate pred, id<FSeqable>seq);
id (^FSome)(FPredicate pred, id<FSeqable>seq);
FFn (^FComplement)(FPredicate pred);


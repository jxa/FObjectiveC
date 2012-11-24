//
//  FObjectiveC.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCons.h"

@interface FObjectiveC : NSObject

@end

//float (^oneFrom)(float);

// temporary
typedef NSArray *FSeq;
typedef id (^FFn)(id obj);
typedef id (^FFn2)(id obj1, id obj2);
typedef BOOL (^FPredicate)(id obj);

FFn FComp(FFn a, FFn b);
FFn FPartial(FFn2 fn, id arg);

FCons* FMap(FFn fn, id<FSeqable>seq);
FCons* FFilter(FPredicate pred, id<FSeqable>seq);

id FReduce(FFn2 reducer, id init, id<FSeqable>seq);



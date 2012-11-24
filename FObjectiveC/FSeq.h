//
//  FSeq.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSeqable.h"

@class FCons;

// A persistent, functional, sequence interface
// FSeqs are immutable values, i.e. neither first(), nor rest() changes
// or invalidates the FSeq
@protocol FSeq <NSObject>
- (id)first;
- (id<FSeq>)next;
- (FCons *)cons:(id)object;
- (id<FSeq>)seq;
// - (id<FSeq>)more; // TODO: do we need this? clojure has it.
@end

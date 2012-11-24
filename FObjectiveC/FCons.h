//
//  FCons.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSeq.h"
#import "FSeqable.h"

@interface FCons : NSObject <FSeqable, FSeq>

- (id)initWithHead:(id)head tail:(id<FSeqable>)tail;

@end

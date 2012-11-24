//
//  FSeqable.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSeq.h"

@protocol FSeq;

@protocol FSeqable <NSObject>
- (id<FSeq>)seq;
@end

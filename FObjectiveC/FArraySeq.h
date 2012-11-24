//
//  FArraySeq.h
//  FObjectiveC
//
//  Created by John Andrews on 11/22/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FObjectiveC.h"

@interface FArraySeq : NSObject <FSeq, FSeqable>
- (id)initWithArray:(NSArray *)array;
@end

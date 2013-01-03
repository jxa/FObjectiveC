//
//  FStringSeq.h
//  FObjectiveC
//
//  Created by John Andrews on 12/7/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSeq.h"
#import "FSeqable.h"
#import "FCons.h"

@interface FStringSeq : NSObject <FSeqable, FSeq>

- (id)initWithString:(NSString *)str;

@end

//
//  FFun.h
//  FObjectiveC
//
//  Created by John Andrews on 11/24/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^FFnUnary)(id a);
typedef id (^FFnBinary)(id a, id b);
typedef id (^FFnTernary)(id a, id b, id c);
typedef id (^FFnQuaternary)(id a, id b, id c, id d);
typedef id (^FFnQuinary)(id a, id b, id c, id d, id e);

@interface FFun : NSObject
@property (copy) FFnUnary unary;
@property (copy) FFnBinary binary;
@property (copy) FFnTernary ternary;
@property (copy) FFnQuaternary quaternary;
@property (copy) FFnQuinary quinary;
@property () NSUInteger arity;

+ (FFun*)fn1:(FFnUnary)f;
+ (FFun*)fn2:(FFnBinary)f;

- (id)call:(id)firstArg, ...;
- (id)apply:(NSArray*)args;
- (FFun*)partial:(NSArray*)args;
@end

// [FMap apply:@[upcaseString]]
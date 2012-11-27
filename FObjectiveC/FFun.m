//
//  FFun.m
//  FObjectiveC
//
//  Created by John Andrews on 11/24/12.
//  Copyright (c) 2012 John Andrews. All rights reserved.
//

#import "FFun.h"
#import <stdarg.h>

@implementation FFun

+ (FFun*)fn1:(FFnUnary)f
{
  FFun *fn = [[FFun alloc] init];
  fn.unary = f;
  fn.arity = 1;
  return fn;
}

+ (FFun*)fn2:(FFnBinary)f
{
  FFun *fn = [[FFun alloc] init];
  fn.binary = f;
  fn.arity = 2;
  return fn;
}

// TODO: check for proper arity
- (id)call:(id)firstArg, ...
{
  id arg;
  NSMutableArray *args = [[NSMutableArray alloc] init];
  [args addObject:firstArg];

  va_list vl;
  va_start(vl, firstArg);
  for (int i = 1; i < self.arity; i++) {
    arg = va_arg(vl, id);
    [args addObject:arg];
  }
  va_end(vl);
  
  return [self apply:args];
}

// TODO: use the obj-c version of method_missing to enable the following
// [reduce fn:^(id o) { return o } collection:@[@1, @2]];
// where fn: and collection: are names that are chosen by the library user

// EDIT: the above is probably not possible.
// Leon has suggested a clever macro + convention that could work
//   for example: FFun(1, FUpcase, ^id(NSString *s) { return [s uppercaseString]; });
//   would define a c function called FUpcase(NSString *s)
//   which calls FUpcaseFn, an instance of FFn
//   that way you can reference FUpcaseFn when you need to pass it as an argument
//   but you get the convenience of calling the FUpcase c function
- (id)apply:(NSArray*)args
{
  id result;
  if (self.arity == args.count) {
    switch (self.arity) {
      case 1:
        result = self.unary([args objectAtIndex:0]);
        break;

      case 2:
        result = self.binary([args objectAtIndex:0], [args objectAtIndex:1]);
        break;

      default:
        [NSException raise:@"Invalid (or unimplemented) function arity" format:@"function arity of %d is not implemented", self.arity];
        break;
    }
  } else {
    [NSException raise:@"Wrong number of arguments to function" format:@"expected %d but received %d", self.arity, args.count];
  }
  return result;
}

- (FFun*)partial:(NSArray*)args
{
  return self;
}

//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
//{
//  NSMethodSignature *ms = [super methodSignatureForSelector:aSelector];
//  if (ms) {
//    NSLog(@"method sig: %@", ms);
//  }
//  return ms;
//}
//
//- (void)forwardInvocation:(NSInvocation *)anInvocation
//{
//  
//}

@end

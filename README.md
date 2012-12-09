# F Objective C

> It is better to have 100 functions operate on one data structure
> than 10 functions on 10 data structures.
> -- Alan Perlis

## Fuck Objective C

Coming to Objective C after using a high-level functional language is frustrating.
The foundation classes all have their own way of doing things. Method names for similar
operations differ between classes. Methods do not compose.

What I realized is that I miss Clojure's data structures and the functions that operate
on them.

## Functional Objective-C

Is functional programming possible in Objective C? If it were, would a functional programming
approach be useful in this environment? FObjectiveC is attempting to find out.

Your feedback is greatly appreciated.

FOC is heavily inspired by Clojure's sequence abstractions. Function names are taken
from Clojure's names. I would have Clojure's baby, but it seems as if Objective C might
have beat me to it.

## Examples

Sum the first 100 even numbers.
```objectivec
NSNumber *sum = FReduce(^(NSNumber *sum, NSNumber *val) {
  return [NSNumber numberWithInt:([sum intValue] + [val intValue])];
}, 0, FRange(2, 200, 2));
// sum = 9900
```

Return substrings of a given string.
```objectivec
FFn substrings = ^(NSString *str){
  return FMap(^(NSNumber *n){
    return FReduce(FFn2FromSelector(@selector(stringByAppendingString:)), nil, FTake([n intValue], str));
  }, FRange(1, [str length], 1));
};
substrings(@"FObjectiveC");
// @[  @"F",
//     @"FO",
//     @"FOb",
//     @"FObj",
//     @"FObje",
//     @"FObjec",
//     @"FObject",
//     @"FObjecti",
//     @"FObjectiv",
//     @"FObjective"
// ];
```

## Implementation Details

### The protocols

There are currently 2 protocols that enable the foundation types to participate in FOC.
FSeq provides basic list functions: first, next and cons.
FSeqable means that an object can be turned into a Seq (object that implements FSeq).

The following types along with their mutable counterparts are extended with the FSeqable protocol:

* NSArray
* NSDictionary
* NSSet
* NSOrderedSet
* NSString

Calling seq on an object of any of these types will return an immutable object that implements
the FSeq protocol.

### The "Functions"

Check out FObjectiveC.h. Looks nasty right? Who wants to see this crap?
```objectivec
NSArray* (^FMap)(FFn fn, id<FSeqable>seq);
NSArray* (^FFilter)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FRemove)(FPredicate pred, id<FSeqable>seq);
NSArray* (^FConcat)(id<FSeqable>x, id<FSeqable>y);
```
It's nasty because those are block declarations. All of the FOC functions are defined as
blocks for a few reasons.
* better composability - pass FOC functions to other FOC functions
* define them inline - function pointers suck and don't create closures
* closer to a 1st class entity than function pointers

### Types

Because we're coding in C and because C is statically typed, we need to use generic types
for our functions. `id` types are used for all functions that expect or return values.
Thus it can be somewhat tedious to convert `int` or `BOOL` back and forth to `NSNumber`.
I've provided a `FBool()` macro for that. It helps a little. Use it for those functions
that expect a `FPredicate`. Oh wait, I haven't mentioned that yet.

`FFn` defines a block type that accepts an `id` parameter and returns an `id`.

`FFn2` defines a block type that accepts 2 arguments of type `id`  and returns an `id`.

`FPredicate` is just an alias for FFn that indicates it expects a `BOOL` return value.

## Status

FObjectiveC should be considered experimental. It is currently a thought experiment and
hasn't been used in any production code. I'm not an experienced OC hacker so I expect
I've done things COMPLETELY WRONG. As such the API is subject to complete overhaul.
You have been warned.

## Future Work?

If this ends up being useful at all, these are some things we might look into.

* lazy sequences
* more functions that operate on / construct dictionaries
* documentation that doesn't suck so much

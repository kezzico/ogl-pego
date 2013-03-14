//
//  Stack.m
//  CheapoAir
//
//  Created by Lee Irvine on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Stack.h"
#import "NSArray-Extensions.h"

@interface Stack ()
@property (nonatomic, strong) NSMutableArray *stack;
@end

@implementation Stack

- (id) init {
  if(self = [super init]) {
    self.stack = [[NSMutableArray alloc] init];
  }
  return self;
}

- (NSInteger) count {
  return [_stack count];
}
- (void) push: (id) object {
  [_stack addObject: object];
}
- (id) pop {
  id output = [_stack lastObject];
  if(output) {
    [_stack removeLastObject];
  }
  
  return output;
}
- (id) peek {
  return [_stack lastObject];
}
- (void) empty {
  [_stack removeAllObjects];
}
- (id) popToFirst {
  id first = [_stack firstObject];
  [_stack removeAllObjects];
  
  if(first) {
    [_stack addObject: first];
  }
  
  return first;
}

@end

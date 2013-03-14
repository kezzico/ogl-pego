//
//  Bank.m
//  seatselector
//
//  Created by Lee Irvine on 10/18/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Bank.h"

@implementation Bank

+ (Bank *) bankWithType:(Class) type {
  return [[Bank alloc] initWithType:type];
}

- (id) initWithType:(Class) type {
  if(self = [super init]) {
    _type = type;
    self.deposits = [NSMutableArray array];
  }
  return self;
}

- (id) withdraw {
  if([self.deposits count] == 0) {
    return [[_type alloc] init];
  }
  
  id output = [self.deposits lastObject];
  [self.deposits removeObject:output];
  return output;
}

- (void) deposit:(id) object {
  [self.deposits addObject:object];
}

- (void) depositMany:(NSArray *) objects {
  [self.deposits addObjectsFromArray:objects];
}

@end
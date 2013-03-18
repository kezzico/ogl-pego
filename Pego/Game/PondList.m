//
//  PondList.m
//  Penguin Cross
//
//  Created by Lee Irvine on 2/5/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PondList.h"

static PondList *pondList;
@implementation PondList

+ (PondList *) shared {
  return pondList;
}
+ (void) initialize {
  pondList = [[PondList alloc] init];
  [pondList loadList];
}

- (void) loadList {
  NSString *path = [[NSBundle mainBundle] pathForResource:@"ponds" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  self.allPondNames = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}
- (NSInteger) numberOfLevels {
  return [self.allPondNames count];
}
- (NSString *) pondNameForLevel:(NSInteger) level {
  return self.allPondNames[level % [self.allPondNames count]];
}
@end

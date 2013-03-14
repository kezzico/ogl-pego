//
//  Force.m
//  PenguinCross
//
//  Created by Lee Irvine on 8/26/12.
//  Copyright (c) 2012 leescode.com. All rights reserved.
//

#import "Force.h"

@implementation Force
- (void) dealloc {
  [_subject release];
  [super dealloc];
}
- (NSString *) description {
  return [NSString stringWithFormat:@"accel*mass: %f direction: %@ subject: %@",
    self.massAcceleration, NSStringFromVec3(self.direction), self.subject];
}

@end

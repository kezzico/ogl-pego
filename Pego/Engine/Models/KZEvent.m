//
//  Event.m
//  PenguinCross
//
//  Created by Lee Irvine on 12/19/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZEvent.h"
#import "KZStage.h"

@implementation KZEvent

+ (KZEvent *) after:(float) seconds run:(void(^)()) action {
  KZStage *stage = [KZStage stage];
  KZEvent *event = [[KZEvent alloc] init];
  [stage.events addObject:event];
  
  event.isRepeating = NO;
  event.action = action;
  event.interval = seconds;
  [event calculateNextTick];
  
  return event;
}

+ (KZEvent *) every:(float) seconds loop:(void(^)()) action {
  KZStage *stage = [KZStage stage];
  KZEvent *event = [[KZEvent alloc] init];
  [stage.events addObject:event];
  
  event.isRepeating = YES;
  event.action = action;
  event.interval = seconds;
  [event calculateNextTick];
  
  return event;
}

- (void) calculateNextTick {
  KZStage *stage = [KZStage stage];
  self.nextTick = stage.ticks + self.interval * stage.preferredFramesPerSecond;
}

- (void) cancel {
  KZStage *stage = [KZStage stage];
  [stage.events removeObject:self];
}

@end

//
//  Animation.m
//  Kezzi-Engine
//
//  Created by Lee Irvine on 8/12/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "KZAnimation.h"

@interface KZAnimation ()
@property (nonatomic) BOOL onLastFrame;
@property (nonatomic, strong) NSDictionary *animations;
@property (nonatomic, copy) NSString *currentAnimationName;
@property (nonatomic, copy) NSString *nextAnimationName;
@property (nonatomic) BOOL isNextAnimationLooping;
@property (nonatomic) NSRange currentAnimationRange;
@end

@implementation KZAnimation

- (id) initWithAnimations:(NSDictionary *) animations {
  if(self = [super init]) {
    self.animations = animations;
  }
  return self;
}

- (void) nextFrame {
  if(_onLastFrame == YES && _isLooping == NO && self.nextAnimationName) {
    [self setAnimationLoop: self.nextAnimationName];
    self.nextAnimationName = nil;
    self.isLooping = self.isNextAnimationLooping;
    return;
  }

  NSUInteger lastFrame = _currentAnimationRange.location + _currentAnimationRange.length;
  if(++_frame > lastFrame) {
    _frame = !_isLooping ? lastFrame : _currentAnimationRange.location;
    _onLastFrame = !_isLooping;
  }
}

- (void) setAnimationLoop:(NSString *) loopname {
  if([self.currentAnimationName isEqual: loopname]) return;
  
  NSValue *range = [self.animations valueForKey: loopname];
  self.currentAnimationName = loopname;
  self.currentAnimationRange = [range rangeValue];
  _frame = _currentAnimationRange.location;
  _onLastFrame = NO;
}

- (void) setNextAnimationLoop:(NSString *) loopname looping:(BOOL) isLooping {
  if([self.nextAnimationName isEqual: loopname]) return;
  self.nextAnimationName = loopname;
  self.isNextAnimationLooping = isLooping;
}

- (NSString *) currentAnimation {
  return self.currentAnimationName;
}

@end

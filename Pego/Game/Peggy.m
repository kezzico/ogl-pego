//
//  Peggy.m
//  Pego
//
//  Created by Lee Irvine on 3/16/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "Peggy.h"

@interface Peggy ()
@property (nonatomic, strong) KZEvent *blinkEvent;
@property (nonatomic, strong) KZEvent *stopBreakEvent;
@end

@implementation Peggy
static vec3 shadowoffset = _v(-6, 8, 0);
+ (Peggy *) spawn: (vec3) origin {
  Peggy *peggy = [[Peggy alloc] init];
  peggy.origin = origin;
  peggy.mass = 1.f;
  
  GLfloat s = 10.f;
  peggy.bounds = _t(_v(-s, s, 0), _v(s, s, 0), _v(0, -s, 0));
  peggy.sprite = [KZSprite spriteWithName:@"peggy"];
  peggy.shadow = [KZSprite spriteWithName:@"peggy_shadow"];
  peggy.assets = @[peggy.shadow, peggy.sprite];
  
  peggy.blinkEvent = [KZEvent every:3.f loop:^{
    if([peggy.sprite.animation.currentAnimation isEqual:@"idle"]) {
      [peggy animateBlinking];
    }
  }];
  
  return peggy;
}

- (void) dealloc {
  [self.blinkEvent cancel];
  [self.stopBreakEvent cancel];
}

- (void) animateWalking {
  self.sprite.animation.animationLoop = @"walk";
  self.sprite.animation.isLooping = YES;
}

- (void) animateIdling {
  [self.sprite.animation setAnimationLoop:@"idle"];
  self.sprite.animation.isLooping = NO;
}

- (void) animateBlinking {
  [self.sprite.animation setNextAnimationLoop:@"idle" looping:YES];
  self.sprite.animation.animationLoop = @"blink";
  self.sprite.animation.isLooping = NO;
}

- (void) animateBreaking {
  self.sprite.animation.animationLoop = @"break";
  self.sprite.animation.isLooping = NO;
  
  [self.stopBreakEvent cancel];
  self.stopBreakEvent = [KZEvent after:.5f run:^{
    if([self.sprite.animation.currentAnimation isEqual:@"break"]) {
      [self animateIdling];
    }
  }];
}

- (void) animateDeath {
  self.sprite.animation.animationLoop = @"death";
  self.sprite.animation.isLooping = NO;
}

- (void) animateSmile {
  self.sprite.animation.animationLoop = @"smile";
  self.sprite.animation.isLooping = NO;
}

- (void) update {
  [super update];
  vec3 offset = _v(-sinf(self.angle.z) * shadowoffset.x, cosf(self.angle.z) * shadowoffset.y, 0);
  self.shadow.offset = offset;  
}

@end

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
static vec3 shadowoffset = _v(-12, 8, 0);
+ (Peggy *) spawn: (vec3) origin {
  Peggy *peggy = [[Peggy alloc] init];
  peggy.origin = origin;
  peggy.mass = 1.f;
  
  peggy.radius = 9.f;
  peggy.sprite = [KZSprite spriteWithName:@"peggy"];
  peggy.shadow = [KZRectangle rectangle:_r(_v(-32, -32, 0), _v(32, 32, 0))];
  peggy.shadow.texture = [KZTexture textureWithName:@"peggy_shadow"];
  
  peggy.sprite.zIndex = 12;
  peggy.shadow.zIndex = 9;
  
  peggy.assets = @[peggy.shadow, peggy.sprite];
  
  peggy.blinkEvent = [KZEvent every:3.f loop:^{
    if([peggy.sprite.animation.currentAnimation isEqual:@"idle"]) {
      [peggy animateBlinking];
    }
  }];
  
  peggy.renderPriority = 2;
  
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
  self.shadow.hidden = YES;
  self.sprite.animation.animationLoop = @"death";
  self.sprite.animation.isLooping = NO;
}

- (void) animateSmile {
  self.sprite.animation.animationLoop = @"smile";
  self.sprite.animation.isLooping = NO;
}

- (void) update {
  [super update];
  vec3 offset = rotate(shadowoffset, _v(0, 0, 0), scale(self.angle, -1.f));
  self.shadow.offset = offset;  
}

- (BOOL) isTouching:(KZEntity *)e {
  BOOL isTouching = [super isTouching: e];
  self.sprite.tint = isTouching ? _c(1, 0, 0, 1) : _c(1, 1, 1, 1);
  return isTouching;
}

@end

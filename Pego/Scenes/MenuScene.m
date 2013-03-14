//
//  MenuScene.m
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "MenuScene.h"
#import "KezziEngine.h"

@implementation MenuScene

- (void) sceneWillBegin {
  self.pego = [[KZEntity alloc] init];
  self.sprite = [KZSprite spriteWithName:@"pego"];
  self.pego.assets = @[self.sprite];
  self.pego.origin = _v(588, 400, 0);
  [self.stage addEntity: self.pego];
  
  [self idle];
  
  [KZEvent every:3.f loop:^{
    [self blink];
  }];
}

- (void) blink {
  if(_isIdle == NO) return;
  
  [self.sprite.animation setNextAnimationLoop:@"idle" looping:YES];
  self.sprite.animation.animationLoop = @"blink";
  self.sprite.animation.isLooping = NO;
}

- (void) didTouchAtPosition:(vec3)p {
  _isIdle = NO;
  self.sprite.animation.animationLoop = @"run";
  self.sprite.animation.isLooping = YES;
}

- (void) didReleaseTouch {
  _isIdle = NO;
  [self idle];
}

- (void) idle {
  _isIdle = YES;
  self.sprite.animation.animationLoop = @"idle";
  self.sprite.animation.isLooping = NO;
}

@end

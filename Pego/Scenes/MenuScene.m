//
//  MenuScene.m
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "MenuScene.h"
#import "Pond.h"

@implementation MenuScene

- (void) sceneWillBegin {

  Pond *pond = [Pond pondWithName:@"test"];
  [pond reset];

  [self.stage addEntities: pond.ices];
  [self.stage addEntity: pond.peggy];
  [self.stage addEntities: pond.eggs];
//  vec3 b = _v(20,20,0);
//  vec3 c = _v(20, 0, 0);
//  vec3 a = _v(0,20,0);
//  
//  vec3 to = centerOfTriangle(a, b, c);
//  a = sub(a, to);
//  b = sub(b, to);
//  c = sub(c, to);
//  
//  self.triangle = [KZTriangle triangle:a:b:c];
//
//  self.pego = [[KZEntity alloc] init];
//  self.sprite = [KZSprite spriteWithName:@"pego"];
//  self.pego.assets = @[self.sprite, self.triangle];
//  self.pego.origin = _v(588, 400, 0);
//  [self.stage addEntity: self.pego];
//  
//  [self idle];
//  
//  [KZEvent every:3.f loop:^{
//    [self blink];
//  }];
}
- (void) update {
  vec3 angle = self.triangle.angle;
  angle.z += 0.02f;
  self.triangle.angle = angle;
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

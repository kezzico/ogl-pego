//
//  MenuScene.m
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 ke`zzi.co. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "Game.h"
#import "Peggy.h"

@implementation MenuScene

- (void) sceneWillBegin {
  KZView *startbutton = [KZView viewWithPosition:300 :300 size:300 :300];
  startbutton.defaultTexture = [KZTexture textureWithName:@"white"];
  [startbutton sendTouchAction:@selector(didTouchStart) to:self];
  [self addView: startbutton];
  
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
}

- (void) didTouchStart {
  GameScene *scene = [[GameScene alloc] init];
  [[Game shared] loadPond: 0];
  [self.stage pushScene: scene];
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

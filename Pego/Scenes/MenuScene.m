//
//  MenuScene.m
//  Pego
//
//  Created by Lee Irvine on 3/10/13.
//  Copyright (c) 2013 ke`zzi.co. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "DeathScene.h"
#import "Game.h"
#import "Peggy.h"

@implementation MenuScene

- (void) sceneWillBegin {
  KZView *background = [KZView viewWithPosition:0.f :0.f size:1024.f :768.f];
  background.defaultTexture = [KZTexture textureWithName:@"home"];
  
  KZView *startbutton = [KZView viewWithPosition:300 :300 size:300 :300];
  startbutton.defaultTexture = [KZTexture textureWithName:@"white"];
  [startbutton sendTouchAction:@selector(didTouchStart) to:self];
  [self addView: startbutton];
  [self addView:background];
}

- (void) didTouchStart {
  DeathScene *scene = [[DeathScene alloc] init];
//  GameScene *scene = [[GameScene alloc] init];
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

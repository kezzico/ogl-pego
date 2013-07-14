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
#import "SpriteView.h"

@implementation MenuScene

- (void) sceneWillBegin {
  KZView *background = [KZView viewWithPosition:0.f :0.f size:1024.f :768.f];
  background.defaultTexture = [KZTexture textureWithName:@"home"];
  
  KZView *startbutton = [KZView viewWithPosition:100 :504 size:192 :77];
  startbutton.defaultTexture = [KZTexture textureWithName:@"play"];
  startbutton.highlightTexture = [KZTexture textureWithName:@"play-highlight"];

  KZView *morebutton = [KZView viewWithPosition:952 :708 size:56 :56];
  morebutton.defaultTexture = [KZTexture textureWithName:@"more"];
  morebutton.highlightTexture = [KZTexture textureWithName:@"more-highlight"];  
  
  [startbutton sendTouchAction:@selector(didTouchStart) to:self];
  
  [background addSubview:morebutton];
  [background addSubview:startbutton];
  [self addView:background];
}

- (void) didTouchStart {
  GameScene *scene = [[GameScene alloc] init];
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

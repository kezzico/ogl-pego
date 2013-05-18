//
//  VictoryScene.m
//  Penguin Cross
//
//  Created by Lee Irvine on 2/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "VictoryScene.h"
#import "Game.h"

@implementation VictoryScene
- (void) sceneWillBegin {
  self.game = [Game shared];
  [KZEvent after:1.2f run:^{
    [self showVictoryMenu];
  }];
}

- (void) didTouchContinue {
  [self.game loadNextPond];
  [self.stage popScene];
}

- (void) showVictoryMenu {
  self.background = [KZView fullscreen];
  self.background.defaultTexture = [KZTexture textureWithName:@"you-win"];
  [self addView:self.background];
  
  KZView *nextLevelButton = [KZView viewWithPosition:124:394 size:242:102];
  nextLevelButton.defaultTexture = [KZTexture textureWithName:@"next-level"];
  nextLevelButton.highlightTexture = [KZTexture textureWithName:@"next-level-highlight"];
  
  [nextLevelButton sendTouchAction:@selector(nextLevelTouched) to:self];
  [self.background addSubview:nextLevelButton];
  self.background.tint = _c(1, 1, 1, 0);
  
  [self addPeggySlap];
}

- (void) addPeggySlap {
  KZSprite *sprite = [KZSprite spriteWithName:@"peggy-slap"];
  KZEntity *slap = [KZEntity entity:@[sprite]];
  [sprite.animation setAnimationLoop:@"slap"];
  sprite.animation.isLooping = YES;
  sprite.zIndex = 10;
  slap.renderPriority = 10;
  [[KZStage stage] addEntity: slap];
  
  slap.origin = _v(300, 300, 0);
  
}

- (void) nextLevelTouched {
  [self.game loadNextPond];
  [self.stage popScene];
}

- (void) update {
  [self.game update];
  rgba tint = self.background.tint;
  if(tint.a < 1.f) {
    tint.a += 0.03f;
    self.background.tint = tint;
  }
}

@end

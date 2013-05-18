//
//  PauseScene.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "DeathScene.h"
#import "Game.h"

@implementation DeathScene

- (void) sceneWillBegin {
  self.game = [Game shared];
  [KZEvent after:1.2f run:^{
    [self showDeathMenu];
  }];
}


- (void) didTouchTryAgain {
  [self.game reset];
  [self.stage popScene];
}

- (void) showDeathMenu {
  self.background = [KZView fullscreen];
  self.background.defaultTexture = [KZTexture textureWithName:@"you-lose"];
  [self addView:self.background];
  
  KZView *retryButton = [KZView viewWithPosition:640:680 size:269:51];
  retryButton.defaultTexture = [KZTexture textureWithName:@"try-again"];
  retryButton.highlightTexture = [KZTexture textureWithName:@"try-again-highlight"];
  
  [retryButton sendTouchAction:@selector(retryTouched) to:self];
  [self.background addSubview:retryButton];
  self.background.tint = _c(1, 1, 1, 0);
}

- (void) retryTouched {
  [self.game reset];
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

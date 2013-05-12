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
  [KZEvent after:0.1f run:^{
    [self showDeathMenu];
  }];
}


- (void) didTouchTryAgain {
  [self.game reset];
  [self.stage popScene];
}

- (void) showDeathMenu {
  KZView *background = [KZView fullscreen];
  background.defaultTexture = [KZTexture textureWithName:@"lose"];
  [self addView:background];
  
  KZView *retryButton = [KZView viewWithPosition:900 :500 size:300 :200];
  retryButton.defaultTexture = [KZTexture textureWithName:@"white"];
  [background addSubview:retryButton];
  
}

- (void) update {
  [self.game update];
}

@end

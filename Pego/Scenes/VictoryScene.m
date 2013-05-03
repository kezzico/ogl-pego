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
  [self setupViews];
  
  [self addView: self.winnerView];
  [self addView: self.continueButton];
}

- (void) setupViews {
  self.winnerView = [KZView viewWithPosition:82 : 80 size:860 : 160];
  self.winnerView.defaultTexture = [KZTexture textureWithName:@"victory"];
  
  self.continueButton = [KZView viewWithPosition:285 : 460 size:482 : 98];
  
  self.continueButton.defaultTexture = [KZTexture textureWithName:@"continue"];
  self.continueButton.highlightTexture = [KZTexture textureWithName:@"continueHighlight"];
  self.continueButton.touchTarget = self;
  self.continueButton.touchAction = @selector(didTouchContinue);
}

- (void) didTouchContinue {
  [self.game loadNextPond];
  [self.stage popScene];
}

@end

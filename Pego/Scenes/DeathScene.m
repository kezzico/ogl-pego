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
  [self setupViews];
  self.onupdate = @selector(drownPeggy);
  
  [KZEvent after:0.5 run:^{
    [self addView: self.loserView];
    [self addView: self.tryagainButton];
    self.onupdate = @selector(showDeath);
  }];
}

- (void) setupViews {
  self.loserView = [KZView viewWithPosition:168 :224 size:680 :160];
  self.loserView.defaultTexture = [KZTexture textureWithName:@"death"];
  self.loserView.tint = _c(1.f, 1.f, 1.f, 0);

  self.tryagainButton = [KZView viewWithPosition:245 :400 size:482 :98];
  self.tryagainButton.tint = _c(1.f, 1.f, 1.f, 0);
  
  self.tryagainButton.defaultTexture = [KZTexture textureWithName:@"tryagain"];
  self.tryagainButton.highlightTexture = [KZTexture textureWithName:@"tryagainHighlight"];
  self.tryagainButton.touchTarget = self;
  self.tryagainButton.touchAction = @selector(didTouchTryAgain);
  
}

- (void) didTouchTryAgain {
  [self.game reset];
  [self.stage popScene];
}

- (void) drownPeggy {

}

- (void) showDeath {
  rgba tint = _loserView.tint;
  tint.a += 0.02f;
  _loserView.tint = tint;
  _tryagainButton.tint = tint;
  
  if(tint.a >= 1.f) {
    self.onupdate = @selector(doNothing);
  }
}

- (void) doNothing {
  
}

- (void) update {
  [self performSelector: self.onupdate];;
  [self.game update];
}

@end

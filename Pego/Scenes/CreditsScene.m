//
//  CreditsScene.m
//  Pego
//
//  Created by Lee Irvine on 8/4/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "CreditsScene.h"

@implementation CreditsScene
- (void) sceneWillBegin {
  KZView *background = [KZView fullscreen];
  background.defaultTexture = [KZTexture textureWithName:@"credits"];
  [background sendTouchAction:@selector(didTouchScreen) to:self];
  [self addView:background];
}

- (void) didTouchScreen {
  [self.stage popScene];
}

@end

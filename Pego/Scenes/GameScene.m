//
//  GameScene.m
//  Pego
//
//  Created by Lee Irvine on 3/13/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "GameScene.h"
#import "Game.h"

@implementation GameScene

- (void) sceneWillBegin {
  self.game = [Game shared];
}

@end

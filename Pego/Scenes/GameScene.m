//
//  GameScene.m
//  Pego
//
//  Created by Lee Irvine on 3/13/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "GameScene.h"
#import "VictoryScene.h"
#import "DeathScene.h"
#import "NSArray-Extensions.h"
#import "Game.h"

@implementation GameScene

- (void) sceneWillBegin {
NSLog(@"begin");
  self.game = [Game shared];
  [self setupUI];
}

- (void) setupUI {
  self.black = [KZView fullscreen];
  self.black.defaultTexture = [KZTexture textureWithName:@"black"];
  self.black.tint = _c(1, 1, 1, 0.4);

  self.pauseButton = [KZView viewWithPosition:974:10 size:40:40];
  self.pauseButton.defaultTexture = [KZTexture textureWithName:@"pause"];
  self.pauseButton.highlightTexture = [KZTexture textureWithName:@"pause-highlight"];
  [self.pauseButton sendTouchAction:@selector(pauseTouched) to:self];
  [self addView: self.pauseButton];
  
  self.restartButton = [KZView viewWithPosition:924:10 size:40:40];
  self.restartButton.defaultTexture = [KZTexture textureWithName:@"reset"];
  self.restartButton.highlightTexture = [KZTexture textureWithName:@"reset-highlight"];
  [self.restartButton sendTouchAction:@selector(restartTouched) to:self];
  [self addView: self.restartButton];
}

- (void) pauseTouched {
  BOOL wasPaused = self.stage.isPaused;
  self.stage.isPaused = !wasPaused;
  wasPaused ?
    [self removeView: self.black] :
    [self addViewToBottom: self.black];
}

- (void) restartTouched {
  [_game reset];
}

- (void) sceneWillResume {
  _game.isPeggyWalking = NO;
}

- (void) update {
  [self.game update];
  [self peggyWalkToDestination];
  [self peggyGrabEggs];
  [self peggySlideWithIce];
  
  if([self shouldBreak]) {
    [self peggyBreak];
  }

  if(_game.surfaceMostUnderPeggy == nil) {
    self.game.peggy.force = _fzero;
    [self.game.peggy animateDeath];
    [self showDeathScene];
    return;
  }
  
  if([_game areAllEggsCollected]) {
    [self.game.peggy animateSmile];
    [self showVictoryScene];
  }
  
  for(Surface *ice in _game.surfacesUnderPeggy) {
    if(ice.canMelt) [_game meltIce: ice];
  }
}

- (BOOL) shouldBreak {
  Surface *nextSurfaceUnderPeggy = [self findNextSurfaceUnderPeggy];
  
  BOOL isWalkingOffSurface = nextSurfaceUnderPeggy == nil;
  BOOL isOnSurface = _game.surfaceMostUnderPeggy != nil;
  BOOL doBreak = isWalkingOffSurface && isOnSurface;

  return doBreak;
} 

- (Surface *) findNextSurfaceUnderPeggy {
  Peggy *p = _game.peggy;
  vec3 nextorigin = add(p.origin, vectorWithMass(p.force, p.mass));
  NSArray *surfaces = [_game.pond surfacesUnderEntity:p withOrigin: nextorigin];
  
  return [surfaces firstObject];
}

- (void) peggySlideWithIce {
  vec3 translation = sub(_game.surfaceMostUnderPeggy.origin, _game.surfaceMostUnderPeggy.lastorigin);
  _game.peggy.origin = add(_game.peggy.origin, translation);
  
  vec3 rotation = _v(0, 0, _game.surfaceMostUnderPeggy.angle.z - _game.surfaceMostUnderPeggy.lastAngle);
  _game.peggy.origin = rotate(_game.peggy.origin, _game.surfaceMostUnderPeggy.origin, rotation);
  _game.peggy.angle = add(_game.peggy.angle, rotation);
}

- (void) showDeathScene {
  DeathScene *scene = [[DeathScene alloc] init];
  [self.stage pushScene: scene];
}

- (void) showVictoryScene {
  VictoryScene *scene = [[VictoryScene alloc] init];
  [self.stage pushScene: scene];
}

- (void) peggyGrabEggs {
  for(KZEntity *egg in _game.pond.eggs) {
    if([egg isTouching: _game.peggy] == NO) continue;
    if([_game.grabbedEggs containsObject: egg]) continue;
    
    [self.stage removeEntity: egg];
    [_game.grabbedEggs addObject: egg];
  }
}

- (void) peggyWalkToDestination {
  if(_game.isPeggyWalking == NO) return;
  if([self didPeggyReachDestination: _game.peggy.origin]) {
    [self peggyStopWalking];
  } else {
    force f = _f(normalize(sub(_game.walkPeggyTo, _game.walkPeggyFrom)), 0.4f);
    f = addForces(_game.peggy.force, f);
    if(f.power > 12.f) f.power = 12.f;
    _game.peggy.force = f;
  }
}

- (BOOL) didPeggyReachDestination:(vec3) position {
  if(isEqualv(_game.walkPeggyTo, _game.walkPeggyFrom)) return YES;
  vec3 fromto = sub(_game.walkPeggyTo, _game.walkPeggyFrom);
  float t = dot(sub(position, _game.walkPeggyFrom), fromto) / dot(fromto, fromto);
  return t >= 1.f;
}

- (void) peggyStartWalkingTo:(vec3) p {
  _game.walkPeggyTo = _2d(p);
  _game.walkPeggyFrom = _2d(_game.peggy.origin);
  _game.isPeggyWalking = YES;
  _game.peggy.angle_z = angleFromOrigin(_game.walkPeggyFrom, _game.walkPeggyTo);
  [_game.peggy animateWalking];
}

- (void) peggyStopWalking {
  _game.isPeggyWalking = NO;
  [_game.peggy animateIdling];
}

- (void) peggyBreak {
  _game.isPeggyWalking = NO;
  [_game.peggy animateIdling];

  if(_game.peggy.force.power > 4.f) {
    [_game.peggy animateBreaking];
    _game.surfaceMostUnderPeggy.force = _game.peggy.force;
  }
  
  _game.peggy.force = _fzero;
}

- (void) didTouchAtPosition:(vec3) p {
  [self peggyStartWalkingTo: p];
}
- (void) didReleaseTouch {
  [self peggyStopWalking];
}

@end

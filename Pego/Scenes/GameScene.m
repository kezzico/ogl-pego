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
  self.game = [Game shared];
}

- (void) sceneWillResume {
  _game.isPeggyWalking = NO;
}

- (void) update {
  [self.game update];
  [self peggySlideWithIce];
  [self peggyWalkToDestination];
  [self peggyGrabEggs];
  
  if([self shouldBreak]) {
    [self peggyBreak];
  }
  
  if([_game.iceUnderPeggy count] == 0) {
    [self.game.peggy animateDeath];
    [self showDeathScene];
    return;
  }
  
  if([_game areAllEggsCollected]) {
    [self.game.peggy animateSmile];
    [self showVictoryScene];
  }
  
  for(Ice *ice in _game.iceUnderPeggy) {
    if(ice.canMelt) [_game meltIce: ice];
  }
}

- (BOOL) shouldBreak {
  vec3 currentorigin = _game.peggy.origin;
  NSArray *currentIce = [_game.pond iceUnderEntity: _game.peggy];
  
  _game.peggy.origin = _game.peggy.lastorigin;
  NSArray *lastIce = [_game.pond iceUnderEntity: _game.peggy];
  BOOL doBreak = [currentIce count] == 0 && [lastIce count] > 0;
  
  if(!doBreak) {
    _game.peggy.origin = currentorigin;
  }
  
  return doBreak;
}

- (void) peggySlideWithIce {
  vec3 translation = sub(_game.iceMostUnderPeggy.origin, _game.iceMostUnderPeggy.lastorigin);
  _game.peggy.origin = add(_game.peggy.origin, translation);
  
  vec3 rotation = _v(0, 0, _game.iceMostUnderPeggy.angle.z - _game.iceMostUnderPeggy.lastAngle);
  _game.peggy.origin = rotate(_game.peggy.origin, _game.iceMostUnderPeggy.origin, rotation);
  _game.peggy.angle = add(_game.peggy.angle, rotation);
}

- (void) showDeathScene {
  DeathScene *scene = [[DeathScene alloc] init];
//  scene.camera = self.camera;
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

  if([_game.iceUnderPeggy count] == 0) return;
  if(_game.peggy.force.power < 4.f) return;
  
  _game.iceMostUnderPeggy.force = _game.peggy.force;
  _game.peggy.force = _fzero;
  [_game.peggy animateBreaking];
}

- (void) didTouchAtPosition:(vec3) p {
  [self peggyStartWalkingTo: p];
}
- (void) didReleaseTouch {
  [self peggyStopWalking];
}

@end

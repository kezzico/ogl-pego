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
  
  if(_game.iceUnderPeggy == nil) {
    [_game.peggy.assets[0] setTint: _c(1, 0, 0, 1)];
//    [self showDeathScene];
//    return;
  } else {
    [_game.peggy.assets[0] setTint: _c(1, 0, 1, 1)];
  }
  
  if([_game areAllEggsCollected]) {
    [self showVictoryScene];
  }
  
}

- (void) peggySlideWithIce {
  vec3 translation = sub(_game.iceUnderPeggy.origin, _game.iceUnderPeggy.lastorigin);
  _game.peggy.origin = add(_game.peggy.origin, translation);
  
  vec3 rotation = _v(0, 0, _game.iceUnderPeggy.angle.z - _game.iceUnderPeggy.lastAngle);
  _game.peggy.origin = rotate(_game.peggy.origin, _game.iceUnderPeggy.origin, rotation);
  _game.peggy.angle = add(_game.peggy.angle, rotation);
}

- (void) showDeathScene {
  DeathScene *scene = [[DeathScene alloc] init];
  scene.camera = self.camera;
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
    Force *force = [_game.physics applyForceToEntity:_game.peggy];
    force.direction = normalize(sub(_game.walkPeggyTo, _game.walkPeggyFrom));
    force.massAcceleration = 0.28f * _game.peggy.mass;
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

  if(_game.iceUnderPeggy == nil) return;
  if(_game.peggy.speed < .8f) return;
  
  _game.iceUnderPeggy.angleVector = .02f;

//  NSArray *forces = [_game.physics forcesForEntity: _game.peggy];
//  for(Force *force in forces) {
//    force.subject = _game.iceUnderPeggy;
//  }
}

- (void) didTouchAtPosition:(vec3) p {
  [self peggyStartWalkingTo: p];
}
- (void) didReleaseTouch {
  [self peggyStopWalking];
}

@end

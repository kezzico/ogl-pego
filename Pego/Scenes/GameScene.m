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
#import "SpriteView.h"
#import "Game.h"
#import "ScoreBoard.h"
#import "SimplePersistence.h"
#import "KZScreen.h"

@implementation GameScene

- (void) sceneWillBegin {
  self.game = [Game shared];
  [self.game addObserver: self];
  NSInteger currentLevel = [SimplePersistence lastPondFinished] + 1;
  [self.game loadPond: currentLevel];
  [self setupUI];
}

- (void) sceneWillEnd {
  [self.game removeObserver:self];
}

- (void) gameDidReset:(NSNotification *) notification {
  [self clearEggHud];
  [self setupEggHud];
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

- (void) clearEggHud {
  for(KZView *egg in self.hudEggs) {
    [self removeView: egg];
  }
  
  self.hudEggs = nil;
}

- (void) setupEggHud {
  __block NSInteger index = 0;
  
  self.hudEggs = [self.game.pond.eggs mapObjects:^id(Egg *e) {
    CGFloat x = 30.f + index * 40.f, y = 30.f;
    SpriteView *egg = [SpriteView viewWithSprite:@"egg" position:x :y];
    egg.sprite.scale = 0.75f;
    egg.assets = e.assets;
    egg.sprite.animation.animationLoop = @"cutout";
    egg.sprite.animation.isLooping = NO;
    
    [self addView:egg];
    index++;
    
    return egg;
  }];
}

- (void) updateEggHud {
  NSInteger eggsGrabbed = [self.game.grabbedEggs count], index = 0;
  for(SpriteView *egg in self.hudEggs) {
    NSString *animation = ++index > eggsGrabbed ? @"cutout" : @"egg";
    egg.sprite.animation.animationLoop = animation;
    egg.sprite.animation.isLooping = NO;
  }
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
  [self pan: self.game.peggy.origin];
  
  [self.game update];
  [self peggyWalkToDestination];
  [self peggyGrabEggs];
  [self shiftIce];

  if(_game.surfaceMostUnderPeggy == nil) {
    self.game.peggy.force = _fzero;
    [self.game.peggy animateDeath];
    [self.stage playSound:@"death"];    
    [self showDeathScene];
    return;
  }
  
  if([_game areAllEggsCollected]) {
    [SimplePersistence setLastPondFinished: self.game.level];
    self.game.peggy.force = _fzero;
    [self.game.peggy animateSmile];
    [self.stage playSound:@"victory"];
    [self showVictoryScene];
  }
  
  for(Surface *ice in _game.surfacesUnderPeggy) {
    if(ice.canMelt) [_game meltIce: ice];
  }
}

- (Surface *) findNextSurfaceUnderPeggy {
  Peggy *p = _game.peggy;
  vec3 nextorigin = add(p.origin, vectorWithMass(p.force, p.mass));
  NSArray *surfaces = [_game.pond surfacesUnderEntity:p withOrigin: nextorigin];
  
  return [surfaces firstObject];
}

- (void) showDeathScene {
  DeathScene *scene = [[DeathScene alloc] init];
  [self.stage pushScene: scene];
  
  scene.viewMatrix = self.viewMatrix;
}

- (void) showVictoryScene {
  VictoryScene *scene = [[VictoryScene alloc] init];
  [self.stage pushScene: scene];
}

- (void) peggyGrabEggs {
  for(KZEntity *egg in _game.pond.eggs) {
    if([egg isTouching: _game.peggy] == NO) continue;
    if([_game.grabbedEggs containsObject: egg]) continue;
    
    [self.stage playSound:@"grab-egg"];
    [self.stage removeEntity: egg];
    [_game.grabbedEggs addObject: egg];
    [self updateEggHud];
  }
}

- (void) peggyWalkToDestination {
  if(_game.isPeggyWalking == NO) return;

  // stop applying force when finger is reached
  if([self didPeggyReachDestination: _game.peggy.origin]) {
    [self peggyStopWalking];

  // apply force to peggy while she walks
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

// TODO: remove this.
// play idle animation when force drops below 4
// due to camera panning, only stop walking when user releases touch
- (void) peggyStopWalking {
  _game.isPeggyWalking = NO;
  [_game.peggy animateIdling];
}

- (void) shiftIce {
  if(_game.peggy.force.power < 4.f) {
    return;
  }

  force peggyForce = self.game.peggy.force;
  force peggyForceReversed = _f(scale(peggyForce.direction, -1), peggyForce.power * .1f);
  Surface *ice = self.game.surfaceMostUnderPeggy;

  ice.force = peggyForceReversed;
}

- (void) peggyBreak {
  if(_game.peggy.force.power < 4.f) {
    return;
  }

  [_game.peggy animateBreaking];
//  [self.stage playSound:@"bump"];

  [_game.peggy animateBreaking];

  force peggyForce = self.game.peggy.force;
  force bumpForce = _f(peggyForce.direction, peggyForce.power * 1.2f);
  Surface *ice = self.game.surfaceMostUnderPeggy;

  ice.force = bumpForce;
  self.game.peggy.force = _fzero;
}

- (void) didTouchAtPosition:(vec3) p {
  [self peggyStartWalkingTo: p];
}

- (void) didReleaseTouch {
  [self peggyBreak];
  [self peggyStopWalking];
}

@end

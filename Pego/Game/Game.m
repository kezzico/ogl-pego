//
//  Game.m
//  Pego
//
//  Created by Lee Irvine on 12/30/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Game.h"
#import "Physics.h"
#import "PondList.h"
#import "Pond.h"
#import "Surface.h"
#import "DoodadManager.h"

static Game *shared;
@implementation Game

+ (void) initialize {
  shared = [[Game alloc] init];
}
+ (Game *) shared {
  return shared;
}

- (Peggy *) peggy {
  return _pond.peggy;
}

- (void) loadPond:(NSInteger) level {
  _level = level;
  NSString *pondName = [[PondList shared] pondNameForLevel: _level];
  self.pond = [Pond pondWithName:pondName];
  self.doodadManager = [[DoodadManager alloc] init];
  [self reset];
}

- (void) loadNextPond {
  NSString *pondName = [[PondList shared] pondNameForLevel: ++_level];
  self.pond = [Pond pondWithName:pondName];
  [self reset];
}

- (void) reset {
  self.physics = [Physics physics];
  self.grabbedEggs = [NSMutableArray array];
  [self.pond reset];
  
  KZStage *stage = [KZStage stage];
  [stage removeAllEntities];
  [stage addEntity: _pond.water];
  [stage addEntities: _pond.surfaces];
  [stage addEntities: _pond.eggs];
  [stage addEntity: _pond.peggy];
  [self.doodadManager reset];
  
  [self.physics addPhysicalEntity: _pond.peggy];
  [self.physics addPhysicalEntities: _pond.surfaces];
}

- (void) update {
  self.surfacesUnderPeggy = [self.pond surfacesUnderEntity: self.peggy];
  self.surfaceMostUnderPeggy = [self.pond surfaceMostUnderEntity: self.peggy];
  
  [self.physics applyForces];
  [self.physics bounceCollidingEntities: self.pond.surfaces];
  [self.doodadManager update];
}

- (void) meltIce:(Surface *) ice {
  float melt = (1.f / ice.mass) * 0.01f;
  if((ice.opacity -= melt) <= 0.f) {
    [[KZStage stage] removeEntity: ice];
    ice.didMelt = YES;
  }
}

- (BOOL) areAllEggsCollected {
  return [_grabbedEggs count] == [_pond.eggs count];
}

- (void) movePeggy:(vec3) origin {
  self.peggy.lastorigin = self.peggy.origin;
  self.peggy.origin = origin;
  self.surfacesUnderPeggy = [self.pond surfacesUnderEntity: self.peggy];
  self.surfaceMostUnderPeggy = [self.pond surfaceMostUnderEntity: self.peggy];
}

@end

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
  [stage addEntities: _pond.ices];
  [stage addEntities: _pond.eggs];
  [stage addEntity: _pond.peggy];
  [self.doodadManager reset];
  
  [self.physics addPhysicalEntity: _pond.peggy];
  for(Ice *ice in _pond.ices) {
    [self.physics addPhysicalEntity: ice];
  }
}
- (void) update {
  self.iceUnderPeggy = [self.pond findIceUnderPeggy];
  if(self.iceUnderPeggy.canMelt) {
    [self meltIceUnderPeggy];
  }
  
  [self.physics applyForces];
  [self.physics bounceCollidingEntities: self.pond.ices];
  [self.doodadManager update];
}

- (void) meltIceUnderPeggy {
  float melt = (1.f / self.iceUnderPeggy.mass) * 0.01f;
  if((self.iceUnderPeggy.opacity -= melt) <= 0.f) {
    [[KZStage stage] removeEntity: self.iceUnderPeggy];
    self.iceUnderPeggy.didMelt = YES;
  }
}

- (BOOL) areAllEggsCollected {
  return [_grabbedEggs count] == [_pond.eggs count];
}

@end

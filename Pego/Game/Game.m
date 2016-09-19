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
  self.physics = Physics.physics;
  self.grabbedEggs = NSMutableArray.array;
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
  [self attachEggsToIce];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:@"game.reset" object:self];
}

- (void) attachEggsToIce {
  for(Egg *egg in self.pond.eggs) {
    Surface *surfaceUnderEgg = [self.pond surfaceMostUnderEntity: egg];
    [surfaceUnderEgg attachEntity: egg];
  }
}

- (void) update {
  [self updateSurfaceUnderPeggy];
  [self.physics applyForces];
  [self.physics bounceCollidingEntities: self.pond.surfaces];
  [self.doodadManager update];
}

- (void) updateSurfaceUnderPeggy {
  self.lastSurfaceUnderPeggy = self.surfaceMostUnderPeggy;
  self.surfacesUnderPeggy = [self.pond surfacesUnderEntity: self.peggy];
  self.surfaceMostUnderPeggy = [self.pond surfaceMostUnderEntity: self.peggy];
  
  if(self.lastSurfaceUnderPeggy != self.surfaceMostUnderPeggy) {
    [self.surfaceMostUnderPeggy attachEntity: self.peggy];
    [self.lastSurfaceUnderPeggy detatchEntity: self.peggy];
  }
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

- (void) addObserver:(id)observer {
  [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(gameDidReset:) name:@"game.reset" object:self];
}

- (void) removeObserver:(id) observer {
  [[NSNotificationCenter defaultCenter] removeObserver:observer name:@"game.reset" object:self];
}

@end

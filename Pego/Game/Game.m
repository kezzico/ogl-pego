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
}
- (void) update {
  self.iceUnderPeggy = [self.pond findIceUnderPeggy];
  [self.physics applyForces];
  [self.physics bounceCollidingEntities: self.pond.ices];

}
- (BOOL) areAllEggsCollected {
  return [_grabbedEggs count] == [_pond.eggs count];
}
@end

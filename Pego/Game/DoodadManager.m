//
//  DoodadManager.m
//  Pego
//
//  Created by Lee Irvine on 5/7/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "DoodadManager.h"
#import "Doodads.h"
#import "KZScreen.h"

@implementation DoodadManager

- (id) init {
  if(self = [super init]) {
    self.doodads = [NSMutableArray array];
  }
  
  return self;
}

- (void) dealloc {
  [self removeAllDoodads];
  [self.repopulateEvent cancel];
}

- (void) reset {
  [self.repopulateEvent cancel];
  [self removeAllDoodads];
  [self prepopulate];
  
  self.repopulateEvent = [KZEvent every:5.f loop:^{
    [self repopulate];
  }];
}

- (void) update {
  NSArray *doodads = [NSArray arrayWithArray:self.doodads];
  for(Doodad *doodad in doodads) {
    doodad.origin = add(doodad.origin, _v(doodad.speed, 0, 0));
    if([self isDoodadOffScreen: doodad]) {
      [self removeDoodad: doodad];
    }
    
  }
}

- (void) prepopulate {
  NSInteger nbigwhales = arc4random() % 2;
  NSInteger nwhales = arc4random() % 5;
  NSInteger nschools = arc4random() % 5;
  NSInteger nclouds = arc4random() % 2;
  NSInteger nbabyclouds = arc4random() % 3;
  
  for(NSInteger i=0;i<nbigwhales;i++) {
    Doodad *bigwhale = [Doodad spawnBigWhale];
    [self positionDoodad: bigwhale randomX: YES outerY: NO];
    [self addDoodad: bigwhale];
  }

  for(NSInteger i=0;i<nwhales;i++) {
    Doodad *whale = [Doodad spawnWhale];
    [self positionDoodad: whale randomX: YES outerY: NO];
    [self addDoodad: whale];
  }

  for(NSInteger i=0;i<nschools;i++) {
    Doodad *school = [Doodad spawnFishSchool];
    [self positionDoodad: school randomX: YES outerY: NO];
    [self addDoodad: school];
  }

  for(NSInteger i=0;i<nclouds;i++) {
    Doodad *cloud = [Doodad spawnCloud];
    [self positionDoodad: cloud randomX: YES outerY: YES];
    [self addDoodad: cloud];
  }

  for(NSInteger i=0;i<nbabyclouds;i++) {
    Doodad *cloud = [Doodad spawnBabyCloud];
    [self positionDoodad: cloud randomX: YES outerY: YES];
    [self addDoodad: cloud];
  }
}

- (void) repopulate {
  self.eventTick++;
  BOOL spawnBigWhale = arc4random() % 4 == 0 && !self.bigWhaleOnScreen;
  BOOL spawnCloud = self.eventTick % 3 == 0 && arc4random() % 2 == 0;
  BOOL spawnBabyCloud = self.eventTick % 4 == 0 && arc4random() % 2 == 0;
  
  NSInteger nwhales = arc4random() % 2;
  NSInteger nschools = arc4random() % 3;

  if(spawnBigWhale) {
    Doodad *bigwhale = [Doodad spawnBigWhale];
    [self positionDoodad: bigwhale randomX: NO outerY: NO];
    [self addDoodad: bigwhale];
  }
  
  for(NSInteger i=0;i<nwhales;i++) {
    Doodad *whale = [Doodad spawnWhale];
    [self positionDoodad: whale randomX: NO outerY: NO];
    [self addDoodad: whale];
  }
  
  for(NSInteger i=0;i<nschools;i++) {
    Doodad *school = [Doodad spawnFishSchool];
    [self positionDoodad: school randomX: NO outerY: NO];
    [self addDoodad: school];
  }
  
  if(spawnCloud) {
    Doodad *cloud = [Doodad spawnCloud];
    [self positionDoodad: cloud randomX: NO outerY: YES];
    [self addDoodad: cloud];
  }
  
  if(spawnBabyCloud) {
    Doodad *cloud = [Doodad spawnBabyCloud];
    [self positionDoodad: cloud randomX: NO outerY: YES];
    [self addDoodad: cloud];
  }

}

- (void) positionDoodad:(Doodad *) doodad randomX:(BOOL) randomx outerY:(BOOL) outery {
  // calculate Y
  GLfloat y = 0.f;
  GLfloat screenHeight = [KZScreen shared].height;
  
  if(outery) {
    y = arc4random() % 2 == 0 ? screenHeight : 0.f;
  } else {
    NSInteger slots = screenHeight / doodad.height;
    NSInteger slot = arc4random() % slots;
    y = slot * doodad.height;
  }
  
  // calculate X
  GLfloat halfwidth = doodad.width * .5f;
  GLfloat screenWidth = [KZScreen shared].width;
  GLfloat startx = doodad.speed > 0 ? -halfwidth : (screenWidth + halfwidth);
  GLfloat x = randomx ? arc4random() % (NSInteger)screenWidth : startx;
  
  doodad.origin = _v(x, y, 0);
}

- (void) addDoodad:(Doodad *) doodad {
  [self.doodads addObject:doodad];
  [[KZStage stage] addEntity:doodad];
}

- (void) removeAllDoodads {
  for(KZEntity *doodad in self.doodads) {
    [[KZStage stage] removeEntity: doodad];
  }
  
  [self.doodads removeAllObjects];
}

- (void) removeDoodad:(KZEntity *) doodad {
  [self.doodads removeObject:doodad];
  [[KZStage stage] removeEntity: doodad];
}

- (BOOL) isDoodadOffScreen:(Doodad *) doodad {
  GLfloat halfwidth = doodad.width * .5f;
  BOOL didGoLeft = doodad.speed < 0 && doodad.origin.x + halfwidth < 0.f;
  BOOL didGoRight = doodad.speed > 0 && doodad.origin.x - halfwidth > [KZScreen shared].width;
  return didGoLeft || didGoRight;
}

- (BOOL) bigWhaleOnScreen {
  for(Doodad *doodad in self.doodads) {
    if([doodad.name isEqual:@"bigwhale"]) return YES;
  }
  
  return NO;
}

@end

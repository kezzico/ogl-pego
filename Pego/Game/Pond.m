//
//  Pond.m
//  Pego
//
//  Created by Lee Irvine on 12/29/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Pond.h"
#import "NSArray-Extensions.h"
#import "NSDictionary-Extensions.h"
#import "Surface.h"
#import "Peggy.h"
#import "Egg.h"
#import "Water.h"

@implementation Pond

+ (Pond *) pondWithName:(NSString *) name {
  NSDictionary *json = [NSDictionary jsonFromResource:name ofType:@"pond"];
  Pond *pond = [[Pond alloc] init];
  pond.name = [json valueForKey:@"name"];
  pond.peggyInitialPosition = [pond vec3FromJson: [json valueForKey:@"start"]];

  pond.iceInitialPositions = [[json valueForKey:@"ice"] mapObjects:^id(NSArray *obj) {
    tri triangle = _t(
      [pond vec3FromJson: obj[0]],
      [pond vec3FromJson: obj[1]],
      [pond vec3FromJson: obj[2]]);
    
    return [NSValue valueWithBytes:&triangle objCType:@encode(tri)];
  }];
  
  pond.rockInitialPositions = [[json valueForKey:@"rocks"] mapObjects:^id(NSArray *obj) {
    tri triangle = [pond triangleFromJson: obj];
    return [NSValue valueWithBytes:&triangle objCType:@encode(tri)];
  }];

  pond.eggInitialPositions = [[json valueForKey:@"eggs"] mapObjects:^id(NSDictionary *obj) {
    vec3 p = [pond vec3FromJson: obj];
    return [NSValue valueWithBytes:&p objCType:@encode(vec3)];
  }];
  
  return pond;
}

- (tri) triangleFromJson:(NSArray *) obj {
  vec3 a = [self vec3FromJson: obj[0]],
       b = [self vec3FromJson: obj[1]],
       c = [self vec3FromJson: obj[2]];
  
  return _t(a, b, c);
}

- (vec3) vec3FromJson: (NSDictionary *) json {
  vec3 output = (vec3){0.f, 0.f, 0.f};
  output.x = [[json valueForKey:@"x"] floatValue];
  output.y = [[json valueForKey:@"y"] floatValue];
  return output;
}

- (vec3) vec3FromValue: (NSValue *) value {
  vec3 output;
  [value getValue:&output];
  return output;
}

- (tri) triangleFromValue: (NSValue *) value {
  tri triangle;
  [value getValue:&triangle];
  return triangle;
}

- (void) reset {
  self.water = [Water spawn];
  self.peggy = [Peggy spawn: self.peggyInitialPosition];
  
  NSArray *ices = [self.iceInitialPositions mapObjects:^id(NSValue *value) {
    tri t = [self triangleFromValue: value];
    Surface *ice = [Surface spawnIceWithTriangle:t];
    return ice;
  }];
  
  NSArray *rocks = [self.rockInitialPositions mapObjects:^id(NSValue *value) {
    tri t = [self triangleFromValue: value];
    Surface *rock = [Surface spawnRockWithTriangle: t];
    return rock;
  }];
  
  self.surfaces = [ices arrayByAddingObjectsFromArray: rocks];
  self.eggs = [self.eggInitialPositions mapObjects:^id(NSValue *value) {
    return [Egg spawn: [self vec3FromValue:value]];
  }];
}

- (NSArray *) surfacesUnderEntity:(PhysicalEntity *) entity {
  NSMutableArray *surfaces = [NSMutableArray array];
  
  for(Surface *surface in self.surfaces) {
    if(surface.didMelt || [surface isTouching: entity] == NO) continue;
    [surfaces addObject: surface];
  }

  return surfaces;
}

- (NSArray *) surfacesUnderEntity:(PhysicalEntity *) entity withOrigin:(vec3) origin {
  vec3 realorigin = entity.origin;
  entity.origin = origin;
  NSArray *surfaces = [self surfacesUnderEntity: entity];
  entity.origin = realorigin;
  
  return surfaces;
}


- (Surface *) surfaceMostUnderEntity:(PhysicalEntity *) entity {
  NSArray *surfaces = [self surfacesUnderEntity:entity];
  float closest = INFINITY;
  Surface *mostUnderIce = nil;
  
  for(Surface *surface in surfaces) {
    // calculate distance from peggy's origin to each line.
    line sides[3]; [surface sides: sides];
    for(NSInteger i=0;i<3;i++) {
      float distance = distanceToLine(sides[i], self.peggy.origin);
      // the closest ice will be the ice under peggy.
      if(distance < closest) {
        closest = distance;
        mostUnderIce = surface;
      }
    }
  }
  
  return mostUnderIce;
}

@end

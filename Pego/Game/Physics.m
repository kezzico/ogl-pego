//
//  Physics.m
//  Penguin Cross
//
//  Created by Lee Irvine on 12/31/12.
//  Copyright (c) 2012 kezzi.co. All rights reserved.
//

#import "Physics.h"
#import "Force.h"
#import "Collision.h"
#import "NSArray-Extensions.h"
#import "Bank.h"

@implementation Physics

+ (Physics *) physics {
  return [[Physics alloc] init];
}

- (id) init {
  if(self = [super init]) {
    self.forces = [[NSMutableArray alloc] initWithCapacity:100];
    self.forcebank = [[Bank alloc] initWithType:[Force class]];
  }
  
  return self;
}

- (Force *) applyForceToEntity:(Entity *) entity {
  Force *output = [self.forcebank withdraw];
  [self.forces addObject:output];
  
  output.direction = (vec3){0,0,0};
  output.massAcceleration = 0.f;
  output.subject = entity;
  
  return output;
}

- (void) applyForces {
//  const float friction = 0.005f;
//  [self.forces removeObjectsMatching: ^(Force *force) {
//    if(force.subject == nil) return YES;
//    
//    vec3 vector = scale(force.direction, force.massAcceleration / force.subject.mass);
//    force.massAcceleration -= friction * force.subject.mass;
//    force.subject.origin = add(force.subject.origin, vector);
//    
//    if(force.massAcceleration <= 0.f) {
//      [self.forcebank deposit: force];
//      return YES;
//    }
//    return NO;
//  }];
}

//- (void) removeForcesForEntity:(Entity *) entity {
//  [self.forces removeObjectsMatching: ^(Force *force) {
//    return (BOOL)(force.subject == entity);
//  }];
//}

- (NSArray *) forcesForEntity:(Entity *) entity {
//  NSMutableArray *output = [[[NSMutableArray alloc] init] autorelease];
//  for(Force *force in self.forces) {
//    if(force.subject == entity) [output addObject:force];
//  }
//  
//  return [NSArray arrayWithArray: output];
}

- (void) bounceCollidingEntities:(NSArray *) entities {
//  NSArray *collisions = nil;
//  NSInteger iteration = 0;
//  
//  do {
//    collisions = [self findAllCollisions: entities];
//    for(Collision *c in collisions) {
//      c.attacker.origin = c.point;
//      
//      [self removeForcesForEntity: c.attacker];
//      [self removeForcesForEntity: c.victim];
//      Force *victimForce = [self applyForceToEntity:c.victim];
//      Force *attackerForce = [self applyForceToEntity:c.attacker];
//      
//      victimForce.massAcceleration = c.massAcceleration * 0.6f;
//      attackerForce.massAcceleration = c.massAcceleration * 0.4f;
//      victimForce.direction = c.direction;
//      // TODO: instead of reversing the direction mirror it about the colloding axis.
//      attackerForce.direction = iteration > 0 ? scale(c.direction, -1.f) : c.direction;
//    }
//  } while([collisions count] > 0 && iteration++ < 16);
}

- (NSArray *) findAllCollisions:(NSArray *) entities {
//  NSMutableArray *collisions = [NSMutableArray array];
//  
//  Entity *b = nil;
//  for(Entity *a in entities) {
//    if([a isMoving] == NO) continue;
//    if((b = [self firstEntity:entities touching:a]) == nil) continue;
//    [collisions addObject: [self collisionWith:a and:b] ];
//  }
//  
//  return [NSArray arrayWithArray: collisions];
}

- (KZEntity *) firstEntity:(NSArray *) entities touching:(KZEntity *) t {
//  for(Entity *e in entities) {
//    if(t == e) continue;
//    if([t isTouching: e]) return e;
//  }
//  return nil;
}

- (Collision *) collisionWith:(Entity *) a and: (KZEntity *) b {
//  Collision *collision = [[Collision alloc] init];
//  
//  collision.attacker = a;
//  collision.victim = b;
//  collision.point = [self findCollisionPoint:a : b];
//  
//  for(Force *f in [self forcesForEntity: a]) {
//    collision.direction = add(collision.direction, f.direction);
//    collision.massAcceleration += f.massAcceleration;
//  }
//  
//  collision.direction = normalize(collision.direction);
//  return collision;
}

- (vec3) findCollisionPoint:(Entity *) a : (Entity *) b {
//  float closestLineDistance = a.halfwidth + b.halfwidth;
//  vec3 vector = scale(a.vector, (a.halfwidth + b.halfwidth));
//  vec3 output = a.lastorigin;
//  
//  vec3 tl = (vec3){b.origin.x + b.halfwidth, b.origin.y - b.halfwidth, 0};
//  vec3 tr = (vec3){b.origin.x + b.halfwidth, b.origin.y + b.halfwidth, 0};
//  vec3 bl = (vec3){b.origin.x - b.halfwidth, b.origin.y - b.halfwidth, 0};
//  vec3 br = (vec3){b.origin.x - b.halfwidth, b.origin.y + b.halfwidth, 0};
//  
//  vec3 sides[4][2] = { {tl, tr}, {bl, br}, {bl, tl}, {br, tr} };
//  
//  for(int i=0;i<4;i++) {
//    if(linesCanIntersect(a.lastorigin, add(a.lastorigin, vector), sides[i][0], sides[i][1])) {
//      vec3 p = segmentIntersect(a.lastorigin, add(a.lastorigin, vector), sides[i][0], sides[i][1]);
//      float distance = fabsf(p.x - a.lastorigin.x) + fabsf(p.y - a.lastorigin.y);
//      if(distance < closestLineDistance) {
//        closestLineDistance = distance;
//        output = p;
//      }
//    }
//  }
//  
//  return output;
}


@end

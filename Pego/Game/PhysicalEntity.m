//
//  PhysicalEntity.m
//  Pego
//
//  Created by Lee Irvine on 3/23/13.
//  Copyright (c) 2013 kezzi.co. All rights reserved.
//

#import "PhysicalEntity.h"

@interface PhysicalEntity ()
@property (nonatomic, strong) NSMutableSet *attachments;
@end

@implementation PhysicalEntity

- (BOOL) isTouching:(KZEntity *) e {
  PhysicalEntity *a = (PhysicalEntity *) e, *b = self;
  
  BOOL isPhysical = [[e class] isSubclassOfClass: [PhysicalEntity class]];
  if(isPhysical == NO) {
    return [super isTouching: e];
  }
  
  if(isZerof(a.radius) && isZerof(b.radius)) {
    return [self triangle: a isTouchingTriangle: b];
  }

  if(a.radius > 0.f && b.radius > 0.f) {
    return distance(a.origin, b.origin) < (a.radius + b.radius);
  }
  
  if(isZerof(a.radius) && isZerof(b.radius) == NO) {
    return [self sphere: b isTouchingTriangle: a];
  }
  
  if(isZerof(b.radius) && isZerof(a.radius) == NO) {
    return [self sphere: a isTouchingTriangle: b];
  }
  
  return NO;
}

- (BOOL) triangle:(PhysicalEntity *) a isTouchingTriangle:(PhysicalEntity *) b {
  static NSInteger sequence[36] = {
    0,1,0,1,
    0,1,0,2,
    0,1,1,2,
    
    0,1,0,1,
    0,2,0,2,
    0,2,1,2,
    
    1,2,0,1,
    1,2,0,2,
    1,2,1,2
  };
  
  vec3 averts[3]; [a verts: averts];
  vec3 bverts[3]; [b verts: bverts];
  
  // check for edge overlap
  for(NSInteger i=0;i<34;i+=4) {
    BOOL intersect = doSegmentsIntersect(
     _l(averts[sequence[i+0]], averts[sequence[i+1]]),
     _l(bverts[sequence[i+2]], bverts[sequence[i+3]]));
    
    if(intersect) return YES;
  }
  
  // check if a single point is contained within either triangle
  if(isPointInTriangle(bverts[0], _t(averts[0], averts[1], averts[2]))) {
    return YES;
  }
  
  if(isPointInTriangle(averts[0], _t(bverts[0], bverts[1], bverts[2]))) {
    return YES;
  }
  
  return NO;
}

- (BOOL) sphere:(PhysicalEntity *) a isTouchingTriangle:(PhysicalEntity *) b {
  if(isPointInTriangle(a.origin, b.translatedBounds)) {
    return YES;
  }

  vec3 verts[3]; [b verts: verts];
  static NSInteger sequence[6] = { 0,1,0,2,1,2 };
  for(NSInteger i=0;i<6;i+=2) {
    line l = _l(verts[sequence[i+0]], verts[sequence[i+1]]);
    float d = distanceToLine(l, a.origin);
    if(d > a.radius) continue;
    if(isSphereAboveSegment(a.origin, a.radius, l)) {
      return YES;
    }
  }

  return NO;
}

- (void) verts:(vec3 *) buffer {
  buffer[0] = rotate(add(self.origin, _bounds.a), self.origin, self.angle);
  buffer[1] = rotate(add(self.origin, _bounds.b), self.origin, self.angle);
  buffer[2] = rotate(add(self.origin, _bounds.c), self.origin, self.angle);
}

- (tri) translatedBounds {
  return _t(
    rotate(add(self.origin, _bounds.a), self.origin, self.angle),
    rotate(add(self.origin, _bounds.b), self.origin, self.angle),
    rotate(add(self.origin, _bounds.c), self.origin, self.angle));
}

- (void) sides:(line *) buffer {
  vec3 v[3]; [self verts: v];
  buffer[0] = _l(v[0], v[1]);
  buffer[1] = _l(v[0], v[2]);
  buffer[2] = _l(v[1], v[2]);
}

- (BOOL) isMoving {
  return isZerov(_2d(sub(self.lastorigin, self.origin))) == NO;
}

- (void) update {
  [super update];

  self.lastorigin = self.origin;
  self.lastAngle = self.angle.z;
}

- (void) setOrigin:(vec3)origin {
  vec3 translation = sub(origin, self.origin);
  [super setOrigin: origin];
  
  for(PhysicalEntity *entity in self.attachments) {
    entity.origin = add(entity.origin, translation);
  }
}

- (void) attachEntity:(PhysicalEntity *) e {
  if(self.attachments == nil) {
    self.attachments = [NSMutableSet set];
  }
  
  [self.attachments addObject:e];
}

- (void) detatchEntity:(PhysicalEntity *) e {
  [self.attachments removeObject:e];
}

//- (float) mass {
//  float mass = _mass;
//  
//  for(PhysicalEntity *entity in self.attachments) {
//    mass += entity.mass;
//  }
//  
//  return mass;
//}

@end
